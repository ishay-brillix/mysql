DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `drop_old_partitions_outbound_full`()
BEGIN

	declare latest_partition varchar(10);
    declare curr_date varchar(10);
    declare curr_created_partition_date varchar(10);
    declare curr_created_partition_name varchar(7);
    declare curr_range_date varchar(20);
    declare parts_to_define int;
    declare defined_parts int;


    select date(now()) into curr_date;

select max(replace(partition_description,"'",""))
    from information_schema.partitions
    where table_name='tbl_outbound_sms_history_full_partbyrange' and table_schema='multi_send_rmq'
    and partition_description not like 'MAXVALUE'
    into latest_partition;


    select date_sub(latest_partition,interval 1 day) into latest_partition;


    select datediff(latest_partition,date_add(curr_date, interval 180 day)) into parts_to_define;


    if parts_to_define >= 0 then
select 'no partitions need to be defined';
elseif parts_to_define < 0 then

select parts_to_define * (-1) into defined_parts;

set @alter_stmt="alter table multi_send_rmq.tbl_outbound_sms_history_full_partbyrange reorganize partition pmax into (";

while parts_to_define < 0 do

select date_add(date(latest_partition), interval 1 day) into curr_created_partition_date;


            select concat('P',substr(curr_created_partition_date,3,2),substr(curr_created_partition_date,6,2),substr(curr_created_partition_date,9,2)) into curr_created_partition_name;


            select date_add(curr_created_partition_date,interval 1 day) into curr_range_date;


            set @alter_stmt=concat(@alter_stmt,
						"PARTITION ",
                        curr_created_partition_name,
                        " VALUES LESS THAN ('",
                        curr_range_date,
                        "'),");
		
set latest_partition = curr_created_partition_date;


            set parts_to_define = parts_to_define + 1;
        end while;
        
	set @alter_stmt=concat(@alter_stmt,
    "PARTITION pmax VALUES LESS THAN MAXVALUE)");
	
    
	prepare stmt from @alter_stmt;
	execute stmt;
	deallocate prepare stmt;
    select concat("Partition creation completed, created ", defined_parts ," partitions. ",
			"the date of the latest partition is now: ", latest_partition) as message;
    end if;
END$$
DELIMITER ;
