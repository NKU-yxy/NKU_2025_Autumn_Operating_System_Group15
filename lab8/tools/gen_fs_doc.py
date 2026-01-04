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


_ZH_GLOSSARY = [
    (re.compile(r"\bRd/Wr\b", re.I), "读/写"),
    (re.compile(r"\bRd\b", re.I), "读"),
    (re.compile(r"\bWr\b", re.I), "写"),
    (re.compile(r"\binode\b", re.I), "索引节点(inode)"),
    (re.compile(r"\bdisk block\b", re.I), "磁盘块"),
    (re.compile(r"\bblock\b", re.I), "块"),
    (re.compile(r"\bbitmap\b", re.I), "位图(bitmap)"),
    (re.compile(r"\bhash\b", re.I), "哈希"),
    (re.compile(r"\blookup\b", re.I), "查找"),
    (re.compile(r"\balloc\b", re.I), "分配"),
    (re.compile(r"\bfree\b", re.I), "释放"),
    (re.compile(r"\btruncate\b", re.I), "截断(缩短)"),
    (re.compile(r"\bmount\b", re.I), "挂载"),
    (re.compile(r"\bunmount\b", re.I), "卸载"),
    (re.compile(r"\bread\b", re.I), "读取"),
    (re.compile(r"\bwrite\b", re.I), "写入"),
    (re.compile(r"\bopen\b", re.I), "打开"),
    (re.compile(r"\bclose\b", re.I), "关闭"),
    (re.compile(r"\breturn\b", re.I), "返回"),
    (re.compile(r"\bcheck\b", re.I), "检查"),
    (re.compile(r"\bin memory\b", re.I), "在内存中"),
    (re.compile(r"\bon disk\b", re.I), "在磁盘上"),
    (re.compile(r"\bfile system\b", re.I), "文件系统"),
    (re.compile(r"\bdir\b", re.I), "目录"),
    (re.compile(r"\bdirectory\b", re.I), "目录"),
]


_ZH_PATTERNS = [
    # Very common uCore / OS comments
    (re.compile(r"^Called for each open\(\)\.?$", re.I), "每次调用 open() 时都会触发该函数。"),
    (re.compile(r"^Called on the last close\(\)\.?\s*Just pass through\.?$", re.I), "在最后一次 close() 时触发；这里通常只是把请求透传给更底层的实现。"),
    (re.compile(r"^Called for (?:read|a read)\.?\s*Hand off to iobuf\.?$", re.I), "处理读请求：把读取工作交给 iobuf 统一缓冲/拷贝框架完成。"),
    (re.compile(r"^Called for (?:write|a write)\.?\s*Hand off to iobuf\.?$", re.I), "处理写请求：把写入工作交给 iobuf 统一缓冲/拷贝框架完成。"),
    (re.compile(r"^Called for ioctl\(\)\.?\s*Just pass through\.?$", re.I), "处理 ioctl()：一般直接透传到底层设备/驱动。"),
    (re.compile(r"^Called for stat\(\)\.?$", re.I), "处理 stat()：填充/返回文件(或设备)的属性信息。"),
    (re.compile(r"^Set the type and the size \(block devices only\)\.?$", re.I), "设置类型与大小（仅块设备有意义）。"),
    (re.compile(r"^The link count for a device is always 1\.?$", re.I), "设备的链接计数恒为 1（设备节点不参与普通文件的多链接语义）。"),
    (re.compile(r"^Initialization functions for builtin vfs-level devices\.?$", re.I), "初始化内建的 VFS 级设备。"),
    (re.compile(r"^Create inode for a vfs-level device\.?$", re.I), "为 VFS 级设备创建对应的 inode。"),
    (re.compile(r"^For block devices, require block alignment\.?$", re.I), "对块设备：要求按块对齐（避免半块 seek/IO）。"),
    (re.compile(r"^For character devices, prohibit seeking entirely\.?$", re.I), "对字符设备：完全禁止 seek（流式设备不支持随机访问）。"),
    (re.compile(r"^format a string and writes it to stdout\.?$", re.I), "把字符串按格式化规则生成后输出到标准输出。"),
    (re.compile(r"^formats a string and writes it to stdout\.?$", re.I), "把字符串按格式化规则生成后输出到标准输出。"),
    (re.compile(r"^writes a single character .* to stdout, and it will.*$", re.I), "向标准输出写入一个字符，并更新计数器（用于统计输出字符数）。"),
    (re.compile(r"^The return value is the number of characters .* stdout\.?$", re.I), "返回值：本次应输出到标准输出的字符总数。"),
    (re.compile(r"^Call this function if you are already dealing with a va_list\.?$", re.I), "当你已经在处理 va_list（可变参数列表）时调用该函数更合适。"),
    (re.compile(r"^Or you probably want cprintf\(\) instead\.?$", re.I), "否则你通常应该直接使用 cprintf()。"),
    (re.compile(r"^Name lookup\.?$", re.I), "名称查找：根据名字在当前对象（如目录/设备命名空间）中定位目标。"),
    (re.compile(r"^Attempt a seek\.?$", re.I), "尝试执行 seek：把文件偏移移动到指定位置（可能受对齐/设备类型限制）。"),
    (re.compile(r"^Return the type\.?$", re.I), "返回对象类型（例如块设备/字符设备/普通文件等）。"),
    (re.compile(r"^A device is a \"block device\" if it has a known length\.?$", re.I), "如果设备长度已知，则可视为‘块设备’（支持按块随机访问）。"),
    (re.compile(r"^A device that generates data in a stream is a \"character\s*device\"\.?$", re.I), "如果设备以数据流方式产生数据，则可视为‘字符设备’（通常不支持随机访问）。"),
]


_WORD_ZH = {
    "format": "格式化",
    "formats": "格式化",
    "string": "字符串",
    "writes": "写入/输出",
    "write": "写入/输出",
    "stdout": "标准输出",
    "single": "单个",
    "character": "字符",
    "counter": "计数器",
    "increase": "增加",
    "increace": "增加",
    "value": "值",
    "pointed": "指向",
    "return": "返回",
    "number": "数量",
    "characters": "字符数",
    "would": "将会",
    "written": "被写入",
    "call": "调用",
    "already": "已经",
    "dealing": "处理",
    "va_list": "va_list（可变参数列表）",
    "instead": "替代",
    "initialize": "初始化",
    "current": "当前",
    "process": "进程",
    "open": "打开",
    "close": "关闭",
    "table": "表",
    "free": "空闲/释放",
    "allocate": "分配",
    "device": "设备",
    "block": "块",
    "alignment": "对齐",
    "prohibit": "禁止",
    "entirely": "完全",
    "length": "长度",
    "stream": "流",
    "mode": "模式",
    "support": "支持",
    "base": "基础",
    "system": "系统",
    "pathnames": "路径名",
    "syntax": "语法",
}


def _english_ratio(s: str) -> float:
    if not s:
        return 0.0
    letters = sum(1 for ch in s if ("a" <= ch.lower() <= "z"))
    return letters / max(1, len(s))


def _apply_patterns(s: str) -> Optional[str]:
    t = s.strip()
    for pat, rep in _ZH_PATTERNS:
        if pat.match(t):
            return rep
    return None


def _keyword_translate_en_to_zh(s: str) -> str:
    # Light-weight keyword replacement; keep punctuation.
    parts = re.split(r"(\W+)", s)
    out: List[str] = []
    for p in parts:
        key = p.lower()
        if key in _WORD_ZH:
            out.append(_WORD_ZH[key])
        else:
            out.append(p)
    return "".join(out)


def translate_comment_to_zh(comment: str, func_name: str) -> str:
    """Best-effort English->Chinese translation for nearby comments.

    This is a heuristic translator designed for short kernel comments.
    It aims to satisfy lab report readability without external dependencies.
    """
    if not comment:
        return ""

    # Extract meaningful lines from /* ... */ blocks
    lines = []
    for raw in comment.splitlines():
        s = raw.strip()
        if s.startswith("/*") or s.endswith("*/"):
            s = s.strip("/* ")
        if s.startswith("*"):
            s = s.lstrip("* ")
        if s == "":
            continue
        lines.append(s)

    if not lines:
        return ""

    def gloss(s: str) -> str:
        out = s
        for pat, rep in _ZH_GLOSSARY:
            out = pat.sub(rep, out)
        return out

    zh_lines: List[str] = []

    # If it's a very long English paragraph, summarize instead of line-by-line
    joined = " ".join(lines)
    if len(joined) > 220 and _english_ratio(joined) > 0.35:
        # Summary oriented translation
        summary = "该注释较长：主要说明一种路径/命名语法或机制的背景与限制；在本实验的基础实现中通常不支持这些扩展特性，因此只实现最核心的查找/打开语义。"
        if "device:name" in joined:
            summary = "该注释说明 device:name 这类路径语法：理论上可以把路径名解析委托给特定设备，从而在设备内部实现“子路径”。但基础实现不支持这种扩展，因此这里只做最基本的名称查找/透传。"
        zh_lines.append(f"{func_name}：{summary}")
    else:
        # Split into param lines and normal text lines
        param_src: List[str] = []
        text_src: List[str] = []
        for s in lines:
            if s.startswith("@"):  # @param: desc
                param_src.append(s)
            else:
                text_src.append(s)

        # Remove "name -" prefix if present
        if text_src:
            first = text_src[0]
            if "-" in first:
                _, right = first.split("-", 1)
                text_src[0] = right.strip()

        # Merge wrapped lines then translate sentence-by-sentence
        text = " ".join(text_src)
        text = re.sub(r"\s+", " ", text).strip()
        sentences = [t.strip() for t in re.split(r"\.(?:\s+|$)", text) if t.strip()]

        translated: List[str] = []
        for sent in sentences:
            hit = _apply_patterns(sent)
            if hit is not None:
                translated.append(hit)
                continue
            s0 = gloss(sent)
            if _english_ratio(s0) > 0.20:
                s0 = _keyword_translate_en_to_zh(s0)
                if _english_ratio(s0) > 0.20:
                    # Sentence still too English-heavy -> generic Chinese hint
                    translated.append("（该句为实现细节/定义说明，建议结合源码阅读。）")
                else:
                    translated.append(s0)
            else:
                translated.append(s0)

        if translated:
            zh_lines.append(f"{func_name}：{translated[0]}")
            zh_lines.extend(translated[1:])
        else:
            zh_lines.append(f"{func_name}：该函数用于完成与其名字一致的核心操作（建议点源码链接结合上下文阅读）。")

        # Translate params
        for s in param_src:
            m = re.match(r"@([A-Za-z0-9_]+)\s*:\s*(.*)$", s)
            if not m:
                continue
            param, desc = m.group(1), m.group(2)
            desc0 = gloss(desc)
            hit2 = _apply_patterns(desc0)
            if hit2 is not None:
                zh_lines.append(f"参数 {param}：{hit2}")
                continue
            if _english_ratio(desc0) > 0.20:
                desc0 = _keyword_translate_en_to_zh(desc0)
                if _english_ratio(desc0) > 0.20:
                    zh_lines.append(f"参数 {param}：用于传入该函数所需的关键上下文/缓冲区/长度等信息（详见源码）。")
                else:
                    zh_lines.append(f"参数 {param}：{desc0}")
            else:
                zh_lines.append(f"参数 {param}：{desc0}")

    # Add a minimal "logic" hint based on function name
    logic_hint = ""
    n = func_name.lower()
    if "lookup" in n:
        logic_hint = "逻辑要点：在目录项/索引节点结构中按名称/路径进行查找，成功则返回对应 inode。"
    elif "alloc" in n:
        logic_hint = "逻辑要点：从空闲资源集合（如位图/缓存）选择一个可用项并标记为已占用。"
    elif "free" in n:
        logic_hint = "逻辑要点：将资源标记为可复用，并更新计数/元数据。"
    elif "bmap" in n:
        logic_hint = "逻辑要点：把文件的逻辑块号映射到磁盘块号，必要时分配间接块/数据块。"
    elif n.endswith("read") or "read" in n:
        logic_hint = "逻辑要点：通过 VFS/vop 下发到具体 FS，最终转为对磁盘块的读取并拷贝到缓冲区。"
    elif n.endswith("write") or "write" in n:
        logic_hint = "逻辑要点：可能触发分配新块/更新 size，写入后设置 dirty 以便 fsync 落盘。"

    if logic_hint:
        zh_lines.append(logic_hint)

    return "<br>".join(zh_lines)


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
            zh = translate_comment_to_zh(fn.comment, fn.name)
            if zh:
                comment = f"{comment}<br><br><b>中文解释</b><br>{zh}"
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
