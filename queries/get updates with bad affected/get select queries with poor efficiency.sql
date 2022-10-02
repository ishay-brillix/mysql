select
    digest,query_sample_text,
    (sum_rows_sent/sum_rows_examined)*100 as efficiency,
    sum_rows_sent,
    sum_rows_examined,
    sum_rows_examined/count_star as avg_examined,
    sys.format_time(min_timer_wait) as min_time,
    sys.format_time(avg_timer_wait) as avg_time,
    sys.format_time(max_timer_wait) as max_time,
    sys.format_time(QUANTILE_95) as Q95_time,
    count_star,
    first_seen,
    last_seen
from
    performance_schema.events_statements_summary_by_digest
where
    count_star > 1000000
    and digest_text like 'SELECT%'
    and ((sum_rows_sent/sum_rows_examined)*100) < 50
order by
    efficiency asc
limit
    10 \G