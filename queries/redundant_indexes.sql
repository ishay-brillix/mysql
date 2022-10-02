SELECT
    redundant_keys.table_schema,
    redundant_keys.table_name,
    redundant_keys.index_name AS redundant_index_name,
    redundant_keys.index_columns AS redundant_index_columns,
    redundant_keys.non_unique AS redundant_index_non_unique,
    dominant_keys.index_name AS dominant_index_name,
    dominant_keys.index_columns AS dominant_index_columns,
    dominant_keys.non_unique AS dominant_index_non_unique,
    IF(
        redundant_keys.subpart_exists
        OR dominant_keys.subpart_exists,
        1,
        0
    ) AS subpart_exists,
    CONCAT(
        'ALTER TABLE `',
        redundant_keys.table_schema,
        '`.`',
        redundant_keys.table_name,
        '` DROP INDEX `',
        redundant_keys.index_name,
        '`'
    ) AS sql_drop_index
FROM
    (
        SELECT
            TABLE_SCHEMA,
            TABLE_NAME,
            INDEX_NAME,
            MAX(NON_UNIQUE) AS non_unique,
            MAX(IF(SUB_PART IS NULL, 0, 1)) AS subpart_exists,
            GROUP_CONCAT(
                COLUMN_NAME
                ORDER BY
                    SEQ_IN_INDEX
            ) AS index_columns
        FROM
            INFORMATION_SCHEMA.STATISTICS
        WHERE
            INDEX_TYPE = 'BTREE'
            AND TABLE_SCHEMA NOT IN (
                'mysql',
                'sys',
                'INFORMATION_SCHEMA',
                'PERFORMANCE_SCHEMA'
            )
        GROUP BY
            TABLE_SCHEMA,
            TABLE_NAME,
            INDEX_NAME
    ) AS redundant_keys
    INNER JOIN (
        SELECT
            TABLE_SCHEMA,
            TABLE_NAME,
            INDEX_NAME,
            MAX(NON_UNIQUE) AS non_unique,
            MAX(IF(SUB_PART IS NULL, 0, 1)) AS subpart_exists,
            GROUP_CONCAT(
                COLUMN_NAME
                ORDER BY
                    SEQ_IN_INDEX
            ) AS index_columns
        FROM
            INFORMATION_SCHEMA.STATISTICS
        WHERE
            INDEX_TYPE = 'BTREE'
            AND TABLE_SCHEMA NOT IN (
                'mysql',
                'sys',
                'INFORMATION_SCHEMA',
                'PERFORMANCE_SCHEMA'
            )
        GROUP BY
            TABLE_SCHEMA,
            TABLE_NAME,
            INDEX_NAME
    ) AS dominant_keys USING (TABLE_SCHEMA, TABLE_NAME)
WHERE
    redundant_keys.index_name != dominant_keys.index_name
    AND (
        (
            /* Identical columns */
            (
                redundant_keys.index_columns = dominant_keys.index_columns
            )
            AND (
                (
                    redundant_keys.non_unique > dominant_keys.non_unique
                )
                OR (
                    redundant_keys.non_unique = dominant_keys.non_unique
                    AND IF(
                        redundant_keys.index_name = 'PRIMARY',
                        '',
                        redundant_keys.index_name
                    ) > IF(
                        dominant_keys.index_name = 'PRIMARY',
                        '',
                        dominant_keys.index_name
                    )
                )
            )
        )
        OR (
            /* Non-unique prefix columns */
            LOCATE(
                CONCAT(redundant_keys.index_columns, ','),
                dominant_keys.index_columns
            ) = 1
            AND redundant_keys.non_unique = 1
        )
        OR (
            /* Unique prefix columns */
            LOCATE(
                CONCAT(dominant_keys.index_columns, ','),
                redundant_keys.index_columns
            ) = 1
            AND dominant_keys.non_unique = 0
        )
    );