<?php
/*
 * 2011-03-23 (MAF)
 *
 * Changed partitioning scheme from monthly to weekly.
 * Weeks begin with Sunday.
 * Partition names and ranges changed accordingly.
 *
 * Changed interface to CLI so table definitions could
 * be generated on the command line and piped through
 * mysql or redirected to a file.
 *
 * Usage:  php p.php [num_of_partitions]
 *
 */

error_reporting(E_ALL ^ E_NOTICE);

// /tools/partitioning-mysql-creates.php?partitions=12

########################################################
## set vars
########################################################
if (count($argv) >= 2) {
  $num_of_partitions = $argv[1];
	// should not have less than 4 partitions
	if ($num_of_partitions < 4) {
		$num_of_partitions = 12;
	}
} else {
	$num_of_partitions = 12;
}

$title = "up.time - MySQL 'Create Table' Generator for Table Partitioning";



########################################################
## build the create table string
########################################################
	$partition_sampletime  = "PARTITION BY RANGE (TO_DAYS(sampletime)) (\n";
	$partition_sample_time = "PARTITION BY RANGE (TO_DAYS(sample_time)) (\n";

  $today = getdate();
    for ($i = $num_of_partitions-1; $i >= -1; $i--) {
		// calculate new date
		// date format: 2010-09-01 00:00:00
        $newStamp = strtotime(date("Y-m-d", time() - (86400 * $today['wday'])) . " -" . $i . " weeks");
		$newStampPlus = strtotime(date("Y-m-d", time() - (86400 * $today['wday'])) . " -" . ($i-1) . " weeks");
		$year  = date("Y", $newStamp);
		$month = date("m", $newStamp);
		$day = date("d", $newStamp);
		$partition_sampletime .= "PARTITION par_{$year}_{$month}_{$day} VALUES LESS THAN (TO_DAYS('" . date("Y-m-d", $newStampPlus) . " 00:00:00') - (TO_DAYS('" . date("Y-m-d", $newStampPlus) . " 00:00:00') % 7)),\n";
		$partition_sample_time .= "PARTITION par_{$year}_{$month}_{$day} VALUES LESS THAN (TO_DAYS('" . date("Y-m-d", $newStampPlus) . " 00:00:00') - (TO_DAYS('" . date("Y-m-d", $newStampPlus) . " 00:00:00') % 7)),\n";
    }
	$partition_sampletime .= "PARTITION par_max VALUES LESS THAN (MAXVALUE)\n);\n";
	$partition_sample_time .= "PARTITION par_max VALUES LESS THAN (MAXVALUE)\n);\n";

?>
CREATE TABLE performance_sample_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  erdc_id bigint(20) DEFAULT NULL,
  uptimehost_id bigint(20) DEFAULT NULL,
  sample_time datetime DEFAULT NULL,
  PRIMARY KEY (id, sample_time),
  KEY SAMPLE_ERDC_ID (erdc_id),
  KEY UPTIMEHOST_ID (uptimehost_id),
  KEY LATEST_SAMPLE (erdc_id,sample_time),
  KEY LATEST_SAMPLE_BY_HOST (uptimehost_id,sample_time)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_aggregate_par (
  sample_id bigint(20) NOT NULL DEFAULT '0',
  cpu_usr double DEFAULT NULL,
  cpu_sys double DEFAULT NULL,
  cpu_wio double DEFAULT NULL,
  free_mem double DEFAULT NULL,
  free_swap double DEFAULT NULL,
  run_queue double DEFAULT NULL,
  run_occ double DEFAULT NULL,
  read_cache double DEFAULT NULL,
  write_cache double DEFAULT NULL,
  pg_out_sec double DEFAULT NULL,
  ppg_out_sec double DEFAULT NULL,
  pg_free_sec double DEFAULT NULL,
  pg_scan_sec double DEFAULT NULL,
  atch_sec double DEFAULT NULL,
  pg_in_sec double DEFAULT NULL,
  ppg_in_sec double DEFAULT NULL,
  pflt_sec double DEFAULT NULL,
  vflt_sec double DEFAULT NULL,
  slock_sec double DEFAULT NULL,
  num_procs bigint(20) DEFAULT NULL,
  proc_read double DEFAULT NULL,
  proc_write double DEFAULT NULL,
  proc_block double DEFAULT NULL,
  dnlc double DEFAULT NULL,
  fork_sec double DEFAULT NULL,
  exec_sec double DEFAULT NULL,
  tcp_retrans bigint(20) DEFAULT NULL,
  worst_disk_usage bigint(20) DEFAULT NULL,
  worst_disk_busy bigint(20) DEFAULT NULL,
  used_swap_percent bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_cpu_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  cpu_id bigint(20) DEFAULT NULL,
  cpu_usr bigint(20) DEFAULT NULL,
  cpu_sys bigint(20) DEFAULT NULL,
  cpu_wio bigint(20) DEFAULT NULL,
  xcal bigint(20) DEFAULT NULL,
  intr bigint(20) DEFAULT NULL,
  smtx bigint(20) DEFAULT NULL,
  minf double DEFAULT NULL,
  mjf double DEFAULT NULL,
  ithr double DEFAULT NULL,
  csw double DEFAULT NULL,
  icsw double DEFAULT NULL,
  migr double DEFAULT NULL,
  srw double DEFAULT NULL,
  syscl double DEFAULT NULL,
  idle double DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FKF28C291960A224C3_PAR (sample_id)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_disk_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  disk_name varchar(255) DEFAULT NULL,
  pct_time_busy bigint(20) DEFAULT NULL,
  avg_queue_req bigint(20) DEFAULT NULL,
  rw_sec bigint(20) DEFAULT NULL,
  blocks_sec bigint(20) DEFAULT NULL,
  avg_wait_time bigint(20) DEFAULT NULL,
  avg_serv_time bigint(20) DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK5EF9544C60A224C3_PAR (sample_id)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_disk_total_par (
  sample_id bigint(20) NOT NULL AUTO_INCREMENT,
  pct_time_busy bigint(20) DEFAULT NULL,
  avg_queue_req bigint(20) DEFAULT NULL,
  rw_sec bigint(20) DEFAULT NULL,
  blocks_sec bigint(20) DEFAULT NULL,
  avg_wait_time bigint(20) DEFAULT NULL,
  avg_serv_time bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_esx3_workload_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  uuid varchar(255) DEFAULT NULL,
  instance_name varchar(255) DEFAULT NULL,
  cpu_usage_mhz bigint(20) DEFAULT NULL,
  memory bigint(20) DEFAULT NULL,
  disk_io_rate bigint(20) DEFAULT NULL,
  network_io_rate bigint(20) DEFAULT NULL,
  percent_ready double DEFAULT NULL,
  percent_used double DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FKC370C93E60A224C3 (sample_id)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_fscap_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  filesystem varchar(255) DEFAULT NULL,
  total_size bigint(20) DEFAULT NULL,
  space_used bigint(20) DEFAULT NULL,
  space_avail bigint(20) DEFAULT NULL,
  percent_used bigint(20) DEFAULT NULL,
  mount_point varchar(255) DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK8051B31660A224C3 (sample_id)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_lpar_workload_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  lpar_id bigint(20) DEFAULT NULL,
  instance_name varchar(255) DEFAULT NULL,
  entitlement double DEFAULT NULL,
  cpu_usage double DEFAULT NULL,
  used_memory bigint(20) DEFAULT NULL,
  network_io_rate bigint(20) DEFAULT NULL,
  disk_io_rate bigint(20) DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FKEF77CDF260A224C3 (sample_id)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_network_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  iface_name varchar(255) DEFAULT NULL,
  in_bytes bigint(20) DEFAULT NULL,
  out_bytes bigint(20) DEFAULT NULL,
  collisions bigint(20) DEFAULT NULL,
  in_errors bigint(20) DEFAULT NULL,
  out_errors bigint(20) DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK42F8E11F60A224C3 (sample_id)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_nrm_par (
  sample_id bigint(20) NOT NULL DEFAULT '0',
  work_to_do bigint(20) DEFAULT NULL,
  available_disk bigint(20) DEFAULT NULL,
  ds_thread_usage bigint(20) DEFAULT NULL,
  allocated_server_procs bigint(20) DEFAULT NULL,
  available_server_procs bigint(20) DEFAULT NULL,
  packet_receive_buffers bigint(20) DEFAULT NULL,
  available_ecbs bigint(20) DEFAULT NULL,
  lan_traffic bigint(20) DEFAULT NULL,
  connection_usage bigint(20) DEFAULT NULL,
  disk_throughput bigint(20) DEFAULT NULL,
  abended_thread_count bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_psinfo_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  pid bigint(20) DEFAULT NULL,
  ppid bigint(20) DEFAULT NULL,
  ps_uid varchar(255) DEFAULT NULL,
  gid varchar(255) DEFAULT NULL,
  mem_used bigint(20) DEFAULT NULL,
  rss bigint(20) DEFAULT NULL,
  cpu_usage double DEFAULT NULL,
  memory_usage double DEFAULT NULL,
  user_cpu_time bigint(20) DEFAULT NULL,
  sys_cpu_time bigint(20) DEFAULT NULL,
  start_time datetime DEFAULT NULL,
  proc_name varchar(255) DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK9AF8102060A224C3 (sample_id)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_vxvol_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  dg varchar(255) DEFAULT NULL,
  vol varchar(255) DEFAULT NULL,
  rd_ops bigint(20) DEFAULT NULL,
  wr_ops bigint(20) DEFAULT NULL,
  rd_blks bigint(20) DEFAULT NULL,
  wr_blks bigint(20) DEFAULT NULL,
  avg_rd bigint(20) DEFAULT NULL,
  avg_wr bigint(20) DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK8135BA0260A224C3 (sample_id)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE performance_who_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  username varchar(255) DEFAULT NULL,
  session_count bigint(20) DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FKF28C732F60A224C3 (sample_id)
)
<?php echo $partition_sample_time; ?>


CREATE TABLE erdc_decimal_data_par (
  erdc_int_data_id bigint(20) NOT NULL AUTO_INCREMENT,
  erdc_instance_id bigint(20) DEFAULT NULL,
  erdc_parameter_id bigint(20) DEFAULT NULL,
  value double DEFAULT NULL,
  sampletime DATETIME DEFAULT 0,
  PRIMARY KEY (erdc_int_data_id, sampletime),
  KEY IDX_SVC_METRICS_DEC (erdc_parameter_id,erdc_instance_id,sampletime)
)
<?php echo $partition_sampletime; ?>


CREATE TABLE erdc_int_data_par (
  erdc_int_data_id bigint(20) NOT NULL AUTO_INCREMENT,
  erdc_instance_id bigint(20) DEFAULT NULL,
  erdc_parameter_id bigint(20) DEFAULT NULL,
  value bigint(20) DEFAULT NULL,
  sampletime DATETIME DEFAULT 0,
  PRIMARY KEY (erdc_int_data_id, sampletime),
  KEY IDX_SVC_METRICS_INT_PAR (erdc_parameter_id,erdc_instance_id,sampletime)
)
<?php echo $partition_sampletime; ?>


CREATE TABLE erdc_string_data_par (
  erdc_int_data_id bigint(20) NOT NULL AUTO_INCREMENT,
  erdc_instance_id bigint(20) DEFAULT NULL,
  erdc_parameter_id bigint(20) DEFAULT NULL,
  value text,
  sampletime DATETIME DEFAULT 0,
  PRIMARY KEY (erdc_int_data_id, sampletime),
  KEY IDX_SVC_METRICS_STR (erdc_parameter_id,erdc_instance_id,sampletime)
)
<?php echo $partition_sampletime; ?>


CREATE TABLE ranged_object_value_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  ranged_object_id bigint(20) DEFAULT NULL,
  name varchar(255) DEFAULT NULL,
  value double DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK74D2E2E92362BFC (ranged_object_id),
  KEY RANGED_NAME_IDX (name),
  KEY RANGED_SAMPLE_TIME_IDX (sample_time)
)
<?php echo $partition_sample_time; ?>
