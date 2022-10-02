select
    `information_schema`.`COLUMNS`.`TABLE_SCHEMA` AS `TABLE_SCHEMA`,
    `information_schema`.`COLUMNS`.`TABLE_NAME` AS `TABLE_NAME`,
    `information_schema`.`COLUMNS`.`COLUMN_NAME` AS `COLUMN_NAME`,
    `information_schema`.`COLUMNS`.`DATA_TYPE` AS `DATA_TYPE`,
    `information_schema`.`COLUMNS`.`COLUMN_TYPE` AS `COLUMN_TYPE`,
(
        locate(
            'unsigned',
            `information_schema`.`COLUMNS`.`COLUMN_TYPE`
        ) = 0
    ) AS `is_signed`,
(
        locate(
            'unsigned',
            `information_schema`.`COLUMNS`.`COLUMN_TYPE`
        ) > 0
    ) AS `is_unsigned`,
(
        (
            case
                `information_schema`.`COLUMNS`.`DATA_TYPE`
                when 'tinyint' then 255
                when 'smallint' then 65535
                when 'mediumint' then 16777215
                when 'int' then 4294967295
                when 'bigint' then 18446744073709551615
            end
        ) > > if(
            (
                locate(
                    'unsigned',
                    `information_schema`.`COLUMNS`.`COLUMN_TYPE`
                ) > 0
            ),
            0,
            1
        )
    ) AS `max_value`,
    `information_schema`.`TABLES`.`AUTO_INCREMENT` AS `AUTO_INCREMENT`,
(
        `information_schema`.`TABLES`.`AUTO_INCREMENT` / (
            (
                case
                    `information_schema`.`COLUMNS`.`DATA_TYPE`
                    when 'tinyint' then 255
                    when 'smallint' then 65535
                    when 'mediumint' then 16777215
                    when 'int' then 4294967295
                    when 'bigint' then 18446744073709551615
                end
            ) > > if(
                (
                    locate(
                        'unsigned',
                        `information_schema`.`COLUMNS`.`COLUMN_TYPE`
                    ) > 0
                ),
                0,
                1
            )
        )
    ) AS `auto_increment_ratio`
from
    (
        `information_schema`.`COLUMNS`
        join `information_schema`.`TABLES` on(
            (
                (
                    `information_schema`.`COLUMNS`.`TABLE_SCHEMA` = `information_schema`.`TABLES`.`TABLE_SCHEMA`
                )
                and (
                    `information_schema`.`COLUMNS`.`TABLE_NAME` = `information_schema`.`TABLES`.`TABLE_NAME`
                )
            )
        )
    )
where
    (
        (
            `information_schema`.`COLUMNS`.`TABLE_SCHEMA` not in (
                'mysql',
                'sys',
                'INFORMATION_SCHEMA',
                'performance_schema'
            )
        )
        and (
            `information_schema`.`TABLES`.`TABLE_TYPE` = 'BASE TABLE'
        )
        and (
            `information_schema`.`COLUMNS`.`EXTRA` = 'auto_increment'
        )
    )
order by
    (
        `information_schema`.`TABLES`.`AUTO_INCREMENT` / (
            (
                case
                    `information_schema`.`COLUMNS`.`DATA_TYPE`
                    when 'tinyint' then 255
                    when 'smallint' then 65535
                    when 'mediumint' then 16777215
                    when 'int' then 4294967295
                    when 'bigint' then 18446744073709551615
                end
            ) > > if(
                (
                    locate(
                        'unsigned',
                        `information_schema`.`COLUMNS`.`COLUMN_TYPE`
                    ) > 0
                ),
                0,
                1
            )
        )
    ) desc,
(
        (
            case
                `information_schema`.`COLUMNS`.`DATA_TYPE`
                when 'tinyint' then 255
                when 'smallint' then 65535
                when 'mediumint' then 16777215
                when 'int' then 4294967295
                when 'bigint' then 18446744073709551615
            end
        ) > > if(
            (
                locate(
                    'unsigned',
                    `information_schema`.`COLUMNS`.`COLUMN_TYPE`
                ) > 0
            ),
            0,
            1
        )
    )