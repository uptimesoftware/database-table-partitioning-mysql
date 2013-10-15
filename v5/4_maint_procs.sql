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
    DECLARE var_last_par_value_str longtext;
    DECLARE var_last_par_value bigint;

	-- reset all values
	set @var_last_par_value_str='';
	set @var_last_par_value=0;
	set @var_next_value=0;

    -- get what should be next month's partition "less than" date value, which is actually beginning of next-next month (+2 months)
    set @var_next_date=date_format(curdate() + interval 2 MONTH, '%Y-%m-01');
	set @var_next_value=TO_DAYS(@var_next_date);
    
    -- get the (newest) partition "TO_DAYS" value just before par_max
	SELECT partition_description
	INTO @var_last_par_value_str
	FROM information_schema.partitions
	WHERE table_name LIKE tbl
	AND partition_ordinal_position = 
	(
		SELECT partition_ordinal_position
		FROM information_schema.partitions
		WHERE table_name LIKE tbl
		AND partition_name = 'par_max'
	) - 1;

	-- convert the string value to bigint for proper comparison
	set @var_last_par_value=CAST(@var_last_par_value_str AS UNSIGNED);
    -- if the next month has a partition already, then skip
	IF @var_last_par_value < @var_next_value THEN

		-- get next month's partition name (par_YYYY_MM)
		set @var_next_par_name=date_format(curdate() + interval 1 MONTH, 'par_%Y_%m');
		
        -- split last partition (par_max) into two partitions
        SET @stmt_query:=CONCAT("ALTER TABLE ",tbl," REORGANIZE PARTITION par_max INTO (",
        "PARTITION ",@var_next_par_name," VALUES LESS THAN (TO_DAYS('",@var_next_date,"')),",
        "PARTITION par_max VALUES LESS THAN (MAXVALUE))");

        PREPARE stmt FROM @stmt_query;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
        
        -- automatically call the add_partition procedure
        CALL uptime_drop_partition(tbl);
    END IF;
END $$


DROP PROCEDURE IF EXISTS uptime_manage_partitions $$

CREATE PROCEDURE uptime_manage_partitions (IN tbl varchar(64))
BEGIN
    CALL uptime_add_partition('uptime.performance_sample');
    CALL uptime_add_partition('uptime.performance_aggregate_par');
    CALL uptime_add_partition('uptime.performance_cpu_par');
    CALL uptime_add_partition('uptime.performance_disk_par');
    CALL uptime_add_partition('uptime.performance_disk_total_par');
    CALL uptime_add_partition('uptime.performance_esx3_workload_par');
    CALL uptime_add_partition('uptime.performance_fscap_par');
    CALL uptime_add_partition('uptime.performance_lpar_workload_par');
    CALL uptime_add_partition('uptime.performance_network_par');
    CALL uptime_add_partition('uptime.performance_nrm_par');
    CALL uptime_add_partition('uptime.performance_psinfo_par');
    CALL uptime_add_partition('uptime.performance_vxvol_par');
    CALL uptime_add_partition('uptime.performance_who_par');
    CALL uptime_add_partition('uptime.erdc_decimal_data');
    CALL uptime_add_partition('uptime.erdc_int_data');
    CALL uptime_add_partition('uptime.erdc_string_data');
    CALL uptime_add_partition('uptime.ranged_object_value');
END $$


DROP EVENT IF EXISTS uptime_event_auto_partition $$

CREATE EVENT IF NOT EXISTS uptime_event_auto_partition
ON SCHEDULE EVERY 1 DAY
DO CALL uptime_manage_partitions(); $$


DELIMITER ;

set global event_scheduler = ON;
