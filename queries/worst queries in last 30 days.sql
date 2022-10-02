select digest,digest_text,sys.format_time(avg_timer_wait) as avg_time,sys.format_time(min_timer_wait) as min_time,
count_star,sum_rows_sent,sum_rows_examined ,first_seen,last_seen
from performance_schema.events_statements_summary_by_digest
where count_star>10000
and last_seen > date_sub(curdate(),interval 30 day)
#and digest_text like '%SUPERID%ROUTE_PHONE%ROUTE_PHONE%'
order by avg_timer_Wait desc;