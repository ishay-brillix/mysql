select count_star,query_sample_text,query_sample_seen,sys.format_time(query_sample_timer_wait),
sys.format_time(avg_timer_wait) as avg_time
from events_statements_summary_by_digest
where digest_text like '%dropbox_errors%';