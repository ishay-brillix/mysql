SELECT table_schema,sum(rows_inserted) as sum_insert,sum(rows_updated) as sum_update,sum(rows_deleted) as sum_delete, sum(rows_fetched) as sum_fetch FROM sys.schema_table_statistics
group by table_schema
order by rows_inserted desc
