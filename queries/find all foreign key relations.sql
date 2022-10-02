select
  json_objectagg(parent_data, child_tables)
from
  (
    select
      json_object(
        'parent_table_schema',
        REFERENCED_TABLE_SCHEMA,
        'parent_table',
        REFERENCED_TABLE_NAME,
        'parent_column',
        REFERENCED_COLUMN_NAME
      ) as parent_data,
      JSON_ARRAYAGG(
        json_object(
          'child_table_schema',
          table_schema,
          'child_table',
          table_name,
          'child_column',
          COLUMN_NAME
        )
      ) as child_tables
    from
      information_schema.key_column_usage
    where
      REFERENCED_TABLE_NAME is not null
      and referenced_table_schema = 'safebeing_dev'
    group by
      parent_data
  ) t1 \ G

select
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME,
  count(*) as count
from
  information_schema.key_column_usage
where
  REFERENCED_TABLE_NAME is not null
  and referenced_table_schema = 'safebeing_dev'
group by
  REFERENCED_TABLE_NAME,
  REFERENCED_COLUMN_NAME
order by count desc;