DELIMITER $$

-- Debugging table
-- create table deleteme (txt longtext) $$




-- procedure to drop a new partition
DROP PROCEDURE IF EXISTS uptime_drop_partition $$
CREATE PROCEDURE uptime_drop_partition(IN dbname varchar(64), IN tbl varchar(64), IN months int)
BEGIN
    DECLARE var_last_par_name	varchar(50);
	DECLARE row_count			bigint;
	DECLARE var_par_to_drop		varchar(50);
	
	SET @var_last_par_name	= date_format(curdate() - interval months MONTH, 'par_%Y_%m');	-- get the name of the partition "x" months ago ("months" variable) (par_YYYY_MM)

	-- Check if the month's partition name exists...
	SELECT count(partition_name)
	INTO @row_count
	FROM information_schema.partitions
	WHERE table_name like tbl
	AND partition_name = @var_last_par_name;
	
	-- ... and if it exists, let's drop all partitions before it (but not it)
	IF @row_count > 0 THEN
		drop_partitions: LOOP
			SELECT partition_name
			INTO @var_par_to_drop
			FROM information_schema.partitions
			WHERE table_name like tbl
			AND partition_ordinal_position = 1;
			
			-- Leave the loop if the partition name is the same as the original
			IF @var_last_par_name LIKE @var_par_to_drop THEN
				LEAVE drop_partitions;
			ELSE
				-- Drop the partition from table
				SET @stmt_query:=CONCAT("ALTER TABLE ",dbname,'.',tbl," DROP PARTITION ",@var_par_to_drop);
				PREPARE stmt FROM @stmt_query;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
			END IF;
		END LOOP drop_partitions;
	END IF;
END $$


-- procedure to add new partition
DROP PROCEDURE IF EXISTS uptime_add_partition $$
CREATE PROCEDURE uptime_add_partition(IN dbname varchar(64), IN tbl varchar(64))
BEGIN
	-- Declare variables
	DECLARE var_next_par_name	varchar(64);	-- next month's partition name
	DECLARE row_count			bigint;
	DECLARE var_next_date		datetime;
	
	-- Set variables
	SET @var_next_par_name	= date_format(curdate() + interval 1 MONTH, 'par_%Y_%m');	-- get next month's partition name (par_YYYY_MM)
	SET @var_next_date		= date_format(curdate() + interval 2 MONTH, '%Y-%m-01');	-- get next month's date partition (should be 2 months since it's LESS THAN the next-next month)
	
	
	-- Check if next month's partition name exists...
	SELECT count(partition_name)
	INTO @row_count
	FROM information_schema.partitions
	WHERE table_schema like dbname
	AND table_name like tbl
	AND partition_name = @var_next_par_name;
	
	-- ... if not, let's add a new partition
	IF @row_count = 0 THEN
		-- partition doesn't exist; so let's create it
		-- split last partition (par_max) into two partitions
		SET @stmt_query:=CONCAT("ALTER TABLE ",dbname,'.',tbl," REORGANIZE PARTITION par_max INTO (",
		"PARTITION ",@var_next_par_name," VALUES LESS THAN (TO_DAYS('",@var_next_date,"')),",
		"PARTITION par_max VALUES LESS THAN (MAXVALUE))");
		
		PREPARE stmt FROM @stmt_query;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	END IF;
END $$

-- procedure to drop the last partition(s) (depending on the archive policy, and if successful, add a new partition as well
DROP PROCEDURE IF EXISTS uptime_manage_partitions $$
-- all the main "drop partition" code is here
CREATE PROCEDURE uptime_manage_partitions (IN table_name varchar(64), IN months int)
BEGIN
	CALL uptime_add_partition('uptime', table_name);
	CALL uptime_drop_partition('uptime', table_name, months);
END $$



-- function to get the archive policy number of months for each type
DROP FUNCTION IF EXISTS uptime_get_ap_months $$
CREATE FUNCTION uptime_get_ap_months (ap_type VARCHAR(64))
RETURNS int
BEGIN
	DECLARE ret_months int;
	SET @ret_months=0;
	
	-- return the largest number if the ap_type is 'max'
	IF ap_type like 'max' THEN
		SELECT max(months)
		INTO @ret_months
		FROM archive_policy;
	ELSE
		SELECT months
		INTO @ret_months
		FROM archive_policy
		WHERE type = ap_type;
	END IF;
	
	RETURN @ret_months;
END $$






-- The procedures that will call the master procedure above

-- performance tables
DROP PROCEDURE IF EXISTS uptime_manage_perf_aggregate $$
CREATE PROCEDURE uptime_manage_perf_aggregate ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('cpustats') INTO months;
	CALL uptime_manage_partitions('performance_aggregate_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_cpu $$
CREATE PROCEDURE uptime_manage_perf_cpu ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('cpus') INTO months;
	CALL uptime_manage_partitions('performance_cpu_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_disk $$
CREATE PROCEDURE uptime_manage_perf_disk ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('disks') INTO months;
	CALL uptime_manage_partitions('performance_disk_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_disk_total $$
CREATE PROCEDURE uptime_manage_perf_disk_total ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('disks') INTO months;
	CALL uptime_manage_partitions('performance_disk_total_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_esx3_workload $$
CREATE PROCEDURE uptime_manage_perf_esx3_workload ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('cpustats') INTO months;
	CALL uptime_manage_partitions('performance_esx3_workload_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_fscap $$
CREATE PROCEDURE uptime_manage_perf_fscap ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('filesystems') INTO months;
	CALL uptime_manage_partitions('performance_fscap_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_lpar_workload $$
CREATE PROCEDURE uptime_manage_perf_lpar_workload ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('cpustats') INTO months;
	CALL uptime_manage_partitions('performance_lpar_workload_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_network $$
CREATE PROCEDURE uptime_manage_perf_network ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('networks') INTO months;
	CALL uptime_manage_partitions('performance_network_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_nrm $$
CREATE PROCEDURE uptime_manage_perf_nrm ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('cpustats') INTO months;
	CALL uptime_manage_partitions('performance_nrm_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_psinfo $$
CREATE PROCEDURE uptime_manage_perf_psinfo ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('processes') INTO months;
	CALL uptime_manage_partitions('performance_psinfo_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_vxvol $$
CREATE PROCEDURE uptime_manage_perf_vxvol ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vxvols') INTO months;
	CALL uptime_manage_partitions('performance_vxvol_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_who $$
CREATE PROCEDURE uptime_manage_perf_who ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('who') INTO months;
	CALL uptime_manage_partitions('performance_who_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_perf_sample $$
CREATE PROCEDURE uptime_manage_perf_sample ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('max') INTO months;
	CALL uptime_manage_partitions('performance_sample', months);
END $$


-- retained tables
DROP PROCEDURE IF EXISTS uptime_manage_erdc_int $$
CREATE PROCEDURE uptime_manage_erdc_int ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('retained') INTO months;
	CALL uptime_manage_partitions('erdc_int_data', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_erdc_decimal $$
CREATE PROCEDURE uptime_manage_erdc_decimal ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('retained') INTO months;
	CALL uptime_manage_partitions('erdc_decimal_data', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_erdc_string $$
CREATE PROCEDURE uptime_manage_erdc_string ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('retained') INTO months;
	CALL uptime_manage_partitions('erdc_string_data', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_ranged $$
CREATE PROCEDURE uptime_manage_ranged ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('retained') INTO months;
	CALL uptime_manage_partitions('ranged_object_value', months);
END $$


-- up.time 6 VMware tables

DROP PROCEDURE IF EXISTS uptime_manage_vmw_aggregate $$
CREATE PROCEDURE uptime_manage_vmw_aggregate ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_aggregate_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_cluster $$
CREATE PROCEDURE uptime_manage_vmw_cluster ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_cluster_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_datastore_usage $$
CREATE PROCEDURE uptime_manage_vmw_datastore_usage ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_datastore_usage_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_datastore_vm_usage $$
CREATE PROCEDURE uptime_manage_vmw_datastore_vm_usage ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_datastore_vm_usage_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_disk_rate $$
CREATE PROCEDURE uptime_manage_vmw_disk_rate ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_disk_rate_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_entitlement $$
CREATE PROCEDURE uptime_manage_vmw_entitlement ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_entitlement_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_host_cpu $$
CREATE PROCEDURE uptime_manage_vmw_host_cpu ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_host_cpu_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_host_disk_io $$
CREATE PROCEDURE uptime_manage_vmw_host_disk_io ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_host_disk_io_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_host_disk_io_adv $$
CREATE PROCEDURE uptime_manage_vmw_host_disk_io_adv ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_host_disk_io_adv_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_host_network $$
CREATE PROCEDURE uptime_manage_vmw_host_network ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_host_network_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_host_power_state $$
CREATE PROCEDURE uptime_manage_vmw_host_power_state ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_host_power_state_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_mem $$
CREATE PROCEDURE uptime_manage_vmw_mem ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_mem_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_mem_advanced $$
CREATE PROCEDURE uptime_manage_vmw_mem_advanced ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_mem_advanced_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_network_rate $$
CREATE PROCEDURE uptime_manage_vmw_network_rate ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_network_rate_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_vm_cpu $$
CREATE PROCEDURE uptime_manage_vmw_vm_cpu ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_vm_cpu_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_vm_disk_io $$
CREATE PROCEDURE uptime_manage_vmw_vm_disk_io ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_vm_disk_io_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_vm_network $$
CREATE PROCEDURE uptime_manage_vmw_vm_network ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_vm_network_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_vm_power_state $$
CREATE PROCEDURE uptime_manage_vmw_vm_power_state ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_vm_power_state_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_vm_storage_usage $$
CREATE PROCEDURE uptime_manage_vmw_vm_storage_usage ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_vm_storage_usage_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_vm_vcpu $$
CREATE PROCEDURE uptime_manage_vmw_vm_vcpu ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_vm_vcpu_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_watts $$
CREATE PROCEDURE uptime_manage_vmw_watts ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_watts_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_vmw_sample $$
CREATE PROCEDURE uptime_manage_vmw_sample ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('vmwarePerformance') INTO months;
	CALL uptime_manage_partitions('vmware_perf_sample', months);
END $$


-- up.time 7 Network Device tables

DROP PROCEDURE IF EXISTS uptime_manage_nd_ping $$
CREATE PROCEDURE uptime_manage_nd_ping ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('networkDevicePerformance') INTO months;
	CALL uptime_manage_partitions('net_device_perf_ping_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_nd_port $$
CREATE PROCEDURE uptime_manage_nd_port ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('networkDevicePerformance') INTO months;
	CALL uptime_manage_partitions('net_device_perf_port_par', months);
END $$

DROP PROCEDURE IF EXISTS uptime_manage_nd_sample $$
CREATE PROCEDURE uptime_manage_nd_sample ()
BEGIN
	DECLARE months int;
	SELECT uptime_get_ap_months('networkDevicePerformance') INTO months;
	CALL uptime_manage_partitions('net_device_perf_sample', months);
END $$



-- Create scheduled event to be called on a daily basis
DROP EVENT IF EXISTS uptime_event_auto_partition $$

CREATE EVENT IF NOT EXISTS uptime_event_auto_partition
	ON SCHEDULE EVERY 1 DAY
DO BEGIN
	CALL uptime_manage_perf_aggregate();
	CALL uptime_manage_perf_cpu();
	CALL uptime_manage_perf_disk();
	CALL uptime_manage_perf_disk_total();
	CALL uptime_manage_perf_esx3_workload();
	CALL uptime_manage_perf_fscap();
	CALL uptime_manage_perf_lpar_workload();
	CALL uptime_manage_perf_network();
	CALL uptime_manage_perf_nrm();
	CALL uptime_manage_perf_psinfo();
	CALL uptime_manage_perf_vxvol();
	CALL uptime_manage_perf_who();
	CALL uptime_manage_perf_sample();
	CALL uptime_manage_erdc_int();
	CALL uptime_manage_erdc_decimal();
	CALL uptime_manage_erdc_string();
	CALL uptime_manage_ranged();
	CALL uptime_manage_vmw_aggregate();
	CALL uptime_manage_vmw_cluster();
	CALL uptime_manage_vmw_datastore_usage();
	CALL uptime_manage_vmw_datastore_vm_usage();
	CALL uptime_manage_vmw_disk_rate();
	CALL uptime_manage_vmw_entitlement();
	CALL uptime_manage_vmw_host_cpu();
	CALL uptime_manage_vmw_host_disk_io();
	CALL uptime_manage_vmw_host_disk_io_adv();
	CALL uptime_manage_vmw_host_network();
	CALL uptime_manage_vmw_host_power_state();
	CALL uptime_manage_vmw_mem();
	CALL uptime_manage_vmw_mem_advanced();
	CALL uptime_manage_vmw_network_rate();
	CALL uptime_manage_vmw_vm_cpu();
	CALL uptime_manage_vmw_vm_disk_io();
	CALL uptime_manage_vmw_vm_network();
	CALL uptime_manage_vmw_vm_power_state();
	CALL uptime_manage_vmw_vm_storage_usage();
	CALL uptime_manage_vmw_vm_vcpu();
	CALL uptime_manage_vmw_watts();
	CALL uptime_manage_vmw_sample();
	CALL uptime_manage_nd_ping();
	CALL uptime_manage_nd_port();
	CALL uptime_manage_nd_sample();
END $$


DELIMITER ;

set global event_scheduler = ON;
