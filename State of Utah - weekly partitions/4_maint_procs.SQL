--
-- 2011-03-23 (MAF)
--
-- Changed uptime_add_partition() to handle weekly partitions
-- rather than monthly.  Partition names and ranges changed
-- accordingly.
--

DELIMITER $$

DROP PROCEDURE IF EXISTS uptime_drop_partition $$

CREATE PROCEDURE uptime_drop_partition(IN tbl varchar(64))
BEGIN
    -- -------------------------
    -- Drop oldest partition
    -- -------------------------
    DECLARE par_name varchar(50);
    
    -- get first partition name
    SELECT partition_name
    INTO par_name
    FROM information_schema.partitions
    WHERE table_name like tbl
    AND partition_ordinal_position = 1;
    
    -- drop partition from table
    SET @stmt_query:=CONCAT("ALTER TABLE ",tbl," DROP PARTITION ",par_name);
    PREPARE stmt FROM @stmt_query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
    
END $$


DROP PROCEDURE IF EXISTS uptime_add_partition $$

CREATE PROCEDURE uptime_add_partition(IN tbl varchar(64))
BEGIN
    -- -------------------------
    -- Add new partition
    -- -------------------------
    DECLARE par_name varchar(50);
    -- get next week's partition "less than" date value, which is actually beginning of next-next month (+2 months)
    set @var_next_partition=date_format(date_add('0000-01-01', interval (to_days(now()) - (to_days(now()) % 7)) day) + interval 2 WEEK, '%Y-%m-%d');
    -- get next week's partition name (par_YYYY_MM_DD)
    set @var_next_par_name=date_format(date_add('0000-01-01', interval (to_days(now()) - (to_days(now()) % 7)) day) + interval 1 WEEK, 'par_%Y_%m_%d');

    -- get the (newest) partition name just before par_max
    SELECT partition_name
    INTO par_name
    FROM information_schema.partitions
    WHERE table_name LIKE tbl
	AND partition_ordinal_position = 
    (
    SELECT partition_ordinal_position
    FROM information_schema.partitions
    WHERE table_name LIKE tbl
    AND partition_name = 'par_max'
    ) - 1;
    
    -- check if the next month has a partition already
    IF @var_next_par_name != par_name THEN
        -- split last partition (par_max) into two partitions
        SET @stmt_query:=CONCAT("ALTER TABLE ",tbl," REORGANIZE PARTITION par_max INTO (",
        "PARTITION ",@var_next_par_name," VALUES LESS THAN (TO_DAYS('",@var_next_partition,"')),",
        "PARTITION par_max VALUES LESS THAN (MAXVALUE))");

        PREPARE stmt FROM @stmt_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
        -- drop the last partition
        CALL uptime_drop_partition(tbl);
    END IF;
END $$


DROP PROCEDURE IF EXISTS uptime_manage_partitions $$

CREATE PROCEDURE uptime_manage_partitions (IN tbl varchar(64))
BEGIN
    CALL uptime_add_partition('performance_sample');
    CALL uptime_add_partition('performance_aggregate_par');
    CALL uptime_add_partition('performance_cpu_par');
    CALL uptime_add_partition('performance_disk_par');
    CALL uptime_add_partition('performance_disk_total_par');
    CALL uptime_add_partition('performance_esx3_workload_par');
    CALL uptime_add_partition('performance_fscap_par');
    CALL uptime_add_partition('performance_lpar_workload_par');
    CALL uptime_add_partition('performance_network_par');
    CALL uptime_add_partition('performance_nrm_par');
    CALL uptime_add_partition('performance_psinfo_par');
    CALL uptime_add_partition('performance_vxvol_par');
    CALL uptime_add_partition('performance_who_par');
    CALL uptime_add_partition('erdc_decimal_data');
    CALL uptime_add_partition('erdc_int_data');
    CALL uptime_add_partition('erdc_string_data');
    CALL uptime_add_partition('ranged_object_value');
END $$


DROP EVENT IF EXISTS uptime_event_auto_partition $$

CREATE EVENT IF NOT EXISTS uptime_event_auto_partition
ON SCHEDULE EVERY 1 DAY
DO CALL uptime_manage_partitions(); $$


DELIMITER ;

set global event_scheduler = ON;
