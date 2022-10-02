ALTER TABLE favorite_food
    DROP FOREIGN KEY fk_fav_food_person_id;

ALTER TABLE favorite_food
    ADD CONSTRAINT fk_fav_food_person_id FOREIGN KEY (person_id)
          REFERENCES person (person_id);

select concat('ALTER TABLE garantiaSM.',
t1.TABLE_NAME,' DROP FOREIGN KEY `', 
t1.CONSTRAINT_NAME,'`;' )
from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS t1
where CONSTRAINT_SCHEMA='garantiaSM';


select concat('ALTER TABLE garantiaSM.',
t1.TABLE_NAME,' ADD CONSTRAINT `', 
t1.CONSTRAINT_NAME,
'` FOREIGN KEY (`',
t2.COLUMN_NAME,
'`) REFERENCES `',
t2.REFERENCED_TABLE_NAME,
'` (`',
t2.REFERENCED_COLUMN_NAME,
'`) ON DELETE ',
t1.DELETE_RULE,
' ON UPDATE ',
t1.UPDATE_RULE,
';')
from INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS t1
join information_schema.key_column_usage t2 on t1.CONSTRAINT_NAME=t2.CONSTRAINT_NAME
where t1.CONSTRAINT_SCHEMA='garantiaSM';