#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""Generate a Markdown documentation for lab8 filesystem-related code.

Goal:
- Enumerate relevant files (user tests, user libs, kern fs/vfs/sfs/devs, syscalls, proc/init, mksfs).
- Extract function definitions with start line numbers.
- Capture the closest preceding comment block for per-function explanation.
- Emit Markdown with clickable links to source locations (GitHub-style: path#Lx).

This is a best-effort parser (regex/heuristic), designed for uCore-like code style.
"""

from __future__ import annotations

import os
import re
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, List, Optional, Tuple


RE_CONTROL = re.compile(r"^\s*(if|for|while|switch|do|else)\b")
RE_FUNC_NAME = re.compile(r"([A-Za-z_][A-Za-z0-9_]*)\s*\(")
RE_PREPROC = re.compile(r"^\s*#")


@dataclass
class Func:
    name: str
    signature: str
    start_line: int
    comment: str


def _strip_block_comments_keep_newlines(s: str) -> str:
    # Replace block comments with whitespace but keep line count stable.
    def repl(m: re.Match) -> str:
        return "\n" * m.group(0).count("\n")

    return re.sub(r"/\*.*?\*/", repl, s, flags=re.S)


def _strip_line_comment(s: str) -> str:
    return re.sub(r"//.*", "", s)


def _is_probable_func_start(signature: str) -> bool:
    # Must contain parentheses, must not end with ';'
    if "(" not in signature or ")" not in signature:
        return False
    if ";" in signature:
        return False
    # Disallow typedef declarations; allow struct/enum/union in return/params.
    if signature.lstrip().startswith("typedef"):
        return False
    if "=" in signature:
        return False
    return True


def _extract_preceding_comment(lines: List[str], idx_start: int) -> str:
    """Capture closest preceding /* ... */ or consecutive // lines.

    idx_start: 0-based index of the first line of function signature.
    """
    i = idx_start - 1
    # Skip blank lines
    while i >= 0 and lines[i].strip() == "":
        i -= 1

    if i < 0:
        return ""

    # Case 1: block comment ending right before
    if "*/" in lines[i]:
        # Walk backwards to find /*
        j = i
        while j >= 0:
            if "/*" in lines[j]:
                block = "".join(lines[j : i + 1])
                return block.strip()
            j -= 1

    # Case 2: consecutive // lines
    if lines[i].lstrip().startswith("//"):
        j = i
        while j >= 0 and lines[j].lstrip().startswith("//"):
            j -= 1
        block = "".join(lines[j + 1 : i + 1])
        return block.strip()

    return ""


def extract_functions(path: Path) -> List[Func]:
    raw = path.read_text(encoding="utf-8", errors="ignore")

    # Remove comments for parsing, but keep original lines for comment extraction.
    no_block = _strip_block_comments_keep_newlines(raw)
    no_line = "\n".join(_strip_line_comment(l) for l in no_block.splitlines())
    orig_lines = raw.splitlines(keepends=True)
    scan_lines = no_line.splitlines(keepends=True)

    funcs: List[Func] = []

    brace_depth = 0
    sig_buf: List[Tuple[int, str]] = []  # (line_no_1based, signature_part)

    for idx, scan_line in enumerate(scan_lines):
        line_no = idx + 1
        stripped = scan_line.strip()

        # Ignore preprocessor at top-level
        if brace_depth == 0 and RE_PREPROC.match(scan_line):
            sig_buf.clear()
            continue

        # At top-level, accumulate potential signature lines.
        if brace_depth == 0:
            if stripped == "":
                # blank line ends a signature candidate
                if sig_buf:
                    sig_buf.clear()
                continue

            # Heuristic: skip obvious control-flow (shouldn't appear at top-level in C anyway)
            if RE_CONTROL.match(scan_line):
                sig_buf.clear()
                continue

            sig_buf.append((line_no, scan_line))
            if len(sig_buf) > 20:
                sig_buf = sig_buf[-20:]

            # A top-level ';' without '{' likely ends a declaration/prototype.
            if ";" in scan_line and "{" not in scan_line:
                sig_buf.clear()
                continue

            # When we hit '{' at top-level, attempt to parse a function definition.
            if "{" in scan_line:
                # Build candidate signature from buffered lines, stopping at '{'
                parts: List[str] = []
                for _, l in sig_buf:
                    if "{" in l:
                        parts.append(l.split("{", 1)[0])
                        break
                    parts.append(l)
                sig_text = "".join(parts).strip()
                sig_text_flat = re.sub(r"\s+", " ", sig_text)

                # Exclude common non-function initializers like "= {"
                if "=" in sig_text_flat:
                    sig_buf.clear()
                elif _is_probable_func_start(sig_text_flat):
                    m = list(RE_FUNC_NAME.finditer(sig_text))
                    if m:
                        name = m[-1].group(1)
                        start_line = sig_buf[0][0] if sig_buf else line_no
                        comment = _extract_preceding_comment(orig_lines, start_line - 1)
                        funcs.append(
                            Func(
                                name=name,
                                signature=sig_text_flat,
                                start_line=start_line,
                                comment=comment,
                            )
                        )
                sig_buf.clear()

        # Update brace depth after processing this line.
        # (We count braces on comment-stripped text, which is good enough for this codebase.)
        brace_depth += scan_line.count("{")
        brace_depth -= scan_line.count("}")
        if brace_depth < 0:
            brace_depth = 0

    return funcs


def rel_link(base: Path, p: Path, line: int) -> str:
    rel = p.relative_to(base).as_posix()
    return f"{rel}#L{line}"


def gather_files(base: Path) -> List[Path]:
    patterns = [
        "user/**/*.c",
        "user/libs/**/*.[ch]",
        "kern/fs/**/*.[ch]",
        "kern/syscall/*.[ch]",
        "kern/process/*.[ch]",
        "kern/init/*.[ch]",
        "tools/mksfs.c",
    ]
    files: List[Path] = []
    for pat in patterns:
        files.extend(sorted(base.glob(pat)))

    # De-dup while preserving order
    seen = set()
    out: List[Path] = []
    for f in files:
        rp = f.resolve()
        if rp not in seen and f.is_file():
            seen.add(rp)
            out.append(f)
    return out


def guess_file_intro(relpath: str) -> str:
    # Minimal human-friendly descriptions for major areas.
    if relpath.startswith("kern/fs/sfs/"):
        return "SimpleFS（SFS）具体实现：superblock/bitmap/inode/目录项/磁盘块映射与 I/O。"
    if relpath.startswith("kern/fs/vfs/"):
        return "VFS 抽象层：路径解析、inode 抽象、vfs lookup、设备挂载与通用文件操作封装。"
    if relpath.startswith("kern/fs/devs/"):
        return "文件系统的设备 I/O 适配层：stdin/stdout/disk0 的 dev 接口实现。"
    if relpath.startswith("kern/fs/"):
        return "通用文件系统层：sysfile/file/iobuf/fs 初始化与通用封装。"
    if relpath.startswith("kern/syscall/"):
        return "内核系统调用分发与文件系统相关 syscall 入口。"
    if relpath.startswith("user/libs/"):
        return "用户态文件/目录/系统调用封装库，用于测试用例调用。"
    if relpath.startswith("user/"):
        return "用户态测试用例（包含文件系统相关测试与 shell）。"
    if relpath.startswith("kern/process/"):
        return "进程结构扩展与文件系统状态（fs_struct）相关支持。"
    if relpath.startswith("kern/init/"):
        return "内核初始化：包含文件系统初始化调用。"
    if relpath.startswith("tools/mksfs.c"):
        return "辅助工具：构造 SFS 磁盘镜像（理解布局/元数据很有帮助）。"
    return ""


def main() -> int:
    base = Path(__file__).resolve().parents[1]  # .../lab8
    out_path = base / "FS_Documentation.md"

    files = gather_files(base)

    # Group by directory for readability
    groups: dict[str, List[Path]] = {}
    for f in files:
        rel = f.relative_to(base).as_posix()
        key = rel.split("/", 2)[:2]
        group = "/".join(key)
        groups.setdefault(group, []).append(f)

    lines: List[str] = []
    lines.append("# Lab8 文件系统相关代码详解（可点击跳转）\n")
    lines.append("\n")
    lines.append("本文件由脚本 `lab8/tools/gen_fs_doc.py` 自动生成：\n")
    lines.append("- 目标：覆盖本次实验涉及的文件，并为每个函数提供跳转链接与说明（优先复用源码注释）。\n")
    lines.append("- 跳转格式：`path/to/file.c#L123`（在 VS Code / GitHub Markdown 中可点击）。\n")
    lines.append("\n")

    lines.append("## 0. 总体调用链（从 user 到磁盘）\n")
    lines.append("- user 测试用例通过 `user/libs/syscall.c` 发起系统调用（open/read/write/getdirentry 等）。\n")
    lines.append("- 内核在 `kern/syscall/syscall.c` 分发到对应 `sys_*` 实现，文件相关通常进入 `kern/fs/sysfile.c`。\n")
    lines.append("- `kern/fs/sysfile.c` 调用 VFS 接口（如 `vfs_open/vfs_read/vfs_write/vfs_getdirentry/...`）。\n")
    lines.append("- VFS 在 `kern/fs/vfs/*` 中完成路径解析、inode/文件对象管理，并通过 inode 的 `inode_ops` 下发到具体文件系统（SFS）。\n")
    lines.append("- SFS 在 `kern/fs/sfs/*` 中实现 inode/目录项/块映射与实际 I/O；最终通过 `kern/fs/devs/dev_disk0.c` 等把请求落到磁盘设备。\n")
    lines.append("\n")

    lines.append("## 1. 文件与函数索引\n")

    # Deterministic ordering
    for group in sorted(groups.keys()):
        lines.append(f"### {group}\n")
        for f in groups[group]:
            rel = f.relative_to(base).as_posix()
            intro = guess_file_intro(rel)
            if intro:
                lines.append(f"- **{rel}**：{intro}\n")
            else:
                lines.append(f"- **{rel}**\n")
        lines.append("\n")

    # Per-file details
    lines.append("## 2. 按文件逐函数说明\n")

    for f in files:
        rel = f.relative_to(base).as_posix()
        intro = guess_file_intro(rel)
        lines.append(f"### {rel}\n")
        if intro:
            lines.append(f"**文件作用**：{intro}\n")
        lines.append("\n")

        funcs = extract_functions(f) if f.suffix in (".c", ".h") else []
        if not funcs:
            lines.append("（未检测到函数定义，或本文件主要为结构/宏定义。）\n\n")
            continue

        lines.append("| 函数 | 源码跳转 | 说明（原注释/逻辑要点） |\n")
        lines.append("|---|---:|---|\n")
        for fn in funcs:
            link = rel_link(base, f, fn.start_line)
            comment = fn.comment.replace("\n", "<br>") if fn.comment else "（建议直接点链接阅读实现细节；本函数缺少紧邻注释。）"
            # Keep signature short in table; full signature in collapsible block after table if needed.
            lines.append(f"| `{fn.name}` | [{Path(rel).name}#L{fn.start_line}]({link}) | {comment} |\n")

        # Add signatures below for readability
        lines.append("\n")
        lines.append("<details><summary>函数签名（展开查看）</summary>\n\n")
        for fn in funcs:
            link = rel_link(base, f, fn.start_line)
            lines.append(f"- [{fn.name}]({link})\n\n")
            lines.append("```c\n")
            lines.append(fn.signature.strip() + "\n")
            lines.append("```\n\n")
        lines.append("</details>\n\n")

    out_path.write_text("".join(lines), encoding="utf-8")
    print(f"Wrote: {out_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
