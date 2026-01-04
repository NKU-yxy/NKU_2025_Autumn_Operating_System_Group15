#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <sched.h>

/*
 * FIFO scheduler (First-In-First-Out).
 * Simple queue-based scheduler: insert at tail, pick from head.
 * Time-slice handling mirrors RR so that integration with the rest
 * of the kernel is consistent.
 */

static void
FIFO_init(struct run_queue *rq)
{
    list_init(&rq->run_list);
    rq->proc_num = 0;
    if (rq->max_time_slice <= 0)
        rq->max_time_slice = 1;
    rq->lab6_run_pool = NULL;
}

static void
FIFO_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(proc->rq == NULL);
    list_add_before(&rq->run_list, &proc->run_link);
    proc->time_slice = (rq->max_time_slice > 0) ? rq->max_time_slice : 1;
    proc->rq = rq;
    rq->proc_num++;
}

static void
FIFO_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(proc->rq == rq);
    list_del_init(&proc->run_link);
    proc->rq = NULL;
    if (rq->proc_num > 0)
        rq->proc_num--;
}

static struct proc_struct *
FIFO_pick_next(struct run_queue *rq)
{
    if (list_empty(&rq->run_list))
        return NULL;
    list_entry_t *le = list_next(&rq->run_list);
    return le2proc(le, run_link);
}

static void
FIFO_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    if (!proc)
        return;
    if (proc->time_slice > 0)
        proc->time_slice--;
    if (proc->time_slice == 0)
        proc->need_resched = 1;
}

struct sched_class fifo_sched_class = {
    .name = "FIFO_scheduler",
    .init = FIFO_init,
    .enqueue = FIFO_enqueue,
    .dequeue = FIFO_dequeue,
    .pick_next = FIFO_pick_next,
    .proc_tick = FIFO_proc_tick,
};
