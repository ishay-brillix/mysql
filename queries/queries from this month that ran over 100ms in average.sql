use performance_schema;

select digest_text,count_star,avg_timer_wait,sys.format_time(avg_timer_wait) as avg,sum_rows_examined,sum_rows_affected ,last_seen,count_star/datediff(last_seen,first_seen) times_a_day
#select *
from events_statements_summary_by_digest
where count_star>100
and last_seen > '2020-10-01'
and avg_timer_wait>100000000000
#and count_star>1000
order by times_a_day desc;



select * from events_statements_summary_by_digest;