select
    t.thread_id,
    t.name,
    t.PROCESSLIST_ID,
    t.PROCESSLIST_USER,
    t.PROCESSLIST_COMMAND,
    t.PROCESSLIST_TIME,
    t.PROCESSLIST_STATE,
    t.PROCESSLIST_INFO,
    locks.thread_id,
    locks.object_name,
    locks.locked_thread_count
from
    threads t
    join (
        select
            l.thread_id,
            l.object_name,
            count(distinct lw.REQUESTING_THREAD_ID) as locked_thread_count
        from
            data_locks l
            join data_lock_waits lw on l.thread_id = lw.blocking_thread_id
        where
            REQUESTING_THREAD_ID is not null
        group by
            l.thread_id,
            l.object_name
    ) locks on t.thread_id = locks.thread_id
order by
    locks.locked_thread_count desc;