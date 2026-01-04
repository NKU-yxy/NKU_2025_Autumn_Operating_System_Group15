#include <defs.h>
#include <list.h>
#include <proc.h>
#include <assert.h>
#include <sched.h>

// Challenge2:2311973

static void
SJF_init(struct run_queue *rq)
{
    list_init(&rq->run_list);
    rq->proc_num = 0;
    if (rq->max_time_slice <= 0)
        rq->max_time_slice = 1;
    rq->lab6_run_pool = NULL;
}

static void
SJF_enqueue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(proc->rq == NULL);
    
    list_add_before(&rq->run_list, &proc->run_link);
    proc->time_slice = (rq->max_time_slice > 0) ? rq->max_time_slice : 1;
    proc->rq = rq;
    rq->proc_num++;
}

static void
SJF_dequeue(struct run_queue *rq, struct proc_struct *proc)
{
    assert(proc->rq == rq);
    list_del_init(&proc->run_link);
    proc->rq = NULL;
    if (rq->proc_num > 0)
        rq->proc_num--;
}

static struct proc_struct *
SJF_pick_next(struct run_queue *rq)
{
    if (list_empty(&rq->run_list))
        return NULL;
    list_entry_t *le = list_next(&rq->run_list);
    struct proc_struct *best = NULL;
    for (; le != &rq->run_list; le = list_next(le))
    {
        struct proc_struct *p = le2proc(le, run_link);
        if (best == NULL || p->runs < best->runs)
        {
            best = p;
        }
    }
    return best;
}



static void
SJF_proc_tick(struct run_queue *rq, struct proc_struct *proc)
{
    if (!proc)
        return;
    if (proc->time_slice > 0)
        proc->time_slice--;
    if (proc->time_slice == 0)
        proc->need_resched = 1;
}

struct sched_class sjf_sched_class = {
    .name = "SJF_scheduler",
    .init = SJF_init,
    .enqueue = SJF_enqueue,
    .dequeue = SJF_dequeue,
    .pick_next = SJF_pick_next,
    .proc_tick = SJF_proc_tick,
};
