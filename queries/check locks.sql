select t.processlist_id,l.lock_type,l.lock_mode,t.processlist_info,count(*) 
from performance_schema.data_locks l
join performance_schema.threads t on l.thread_id = t.thread_id
group by t.processlist_id,l.lock_type,l.lock_mode,t.processlist_info