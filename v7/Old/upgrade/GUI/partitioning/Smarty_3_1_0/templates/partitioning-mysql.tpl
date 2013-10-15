{* include file="header.tpl" *}

<center>
<h1>{$title}</h1>
<p>Current Date/Time: {$currentDatetime}<p/>
<p>By default we'll setup enough partitions for the past year and 1 year into the future. All future partitions will be automatically created by the database.<p/>


<textarea cols='100' rows='35'>
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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


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
{$partition_sample_time}


CREATE TABLE performance_who_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  username varchar(255) DEFAULT NULL,
  session_count bigint(20) DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FKF28C732F60A224C3 (sample_id)
)
{$partition_sample_time}


CREATE TABLE erdc_decimal_data_par (
  erdc_int_data_id bigint(20) NOT NULL AUTO_INCREMENT,
  erdc_instance_id bigint(20) DEFAULT NULL,
  erdc_parameter_id bigint(20) DEFAULT NULL,
  value double DEFAULT NULL,
  sampletime DATETIME DEFAULT 0,
  PRIMARY KEY (erdc_int_data_id, sampletime),
  KEY IDX_SVC_METRICS_DEC (erdc_parameter_id,erdc_instance_id,sampletime)
)
{$partition_sampletime}


CREATE TABLE erdc_int_data_par (
  erdc_int_data_id bigint(20) NOT NULL AUTO_INCREMENT,
  erdc_instance_id bigint(20) DEFAULT NULL,
  erdc_parameter_id bigint(20) DEFAULT NULL,
  value bigint(20) DEFAULT NULL,
  sampletime DATETIME DEFAULT 0,
  PRIMARY KEY (erdc_int_data_id, sampletime),
  KEY IDX_SVC_METRICS_INT_PAR (erdc_parameter_id,erdc_instance_id,sampletime)
)
{$partition_sampletime}


CREATE TABLE erdc_string_data_par (
  erdc_int_data_id bigint(20) NOT NULL AUTO_INCREMENT,
  erdc_instance_id bigint(20) DEFAULT NULL,
  erdc_parameter_id bigint(20) DEFAULT NULL,
  value text,
  sampletime DATETIME DEFAULT 0,
  PRIMARY KEY (erdc_int_data_id, sampletime),
  KEY IDX_SVC_METRICS_STR (erdc_parameter_id,erdc_instance_id,sampletime)
)
{$partition_sampletime}


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
{$partition_sample_time}




CREATE TABLE vmware_perf_sample_par (
  sample_id bigint(20) NOT NULL AUTO_INCREMENT,
  vmware_object_type varchar(255) DEFAULT NULL,
  vmware_object_id bigint(20) DEFAULT NULL,
  virtual_center_id bigint(20) DEFAULT NULL,
  datacenter_id bigint(20) DEFAULT NULL,
  cluster_id bigint(20) DEFAULT NULL,
  host_system_id bigint(20) DEFAULT NULL,
  resource_pool_id bigint(20) DEFAULT NULL,
  sample_time datetime DEFAULT NULL,
  PRIMARY KEY (sample_id, sample_time),
  KEY VM_PERF_SAMPLE_VMOID_TIME (vmware_object_id,sample_time),
  KEY VM_PERF_SAMPLE_TIME (sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_aggregate_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  cpu_reservation bigint(20) DEFAULT NULL,
  cpu_usage bigint(20) DEFAULT NULL,
  cpu_total bigint(20) DEFAULT NULL,
  disk_usage bigint(20) DEFAULT NULL,
  memory_reservation bigint(20) DEFAULT NULL,
  memory_usage bigint(20) DEFAULT NULL,
  memory_total bigint(20) DEFAULT NULL,
  network_usage bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_cluster_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  failover bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_datastore_usage_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  capacity bigint(20) DEFAULT NULL,
  provisioned bigint(20) DEFAULT NULL,
  usage_total bigint(20) DEFAULT NULL,
  usage_vm_disk bigint(20) DEFAULT NULL,
  usage_snapshot bigint(20) DEFAULT NULL,
  usage_swap bigint(20) DEFAULT NULL,
  usage_other_vm bigint(20) DEFAULT NULL,
  usage_other bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_datastore_vm_usage_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  sample_id bigint(20) DEFAULT NULL,
  virtual_machine_id bigint(20) DEFAULT NULL,
  usage_total bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FKDVMUPERFSAMPLE (sample_id)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_disk_rate_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  read_rate bigint(20) DEFAULT NULL,
  write_rate bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_entitlement_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  cpu bigint(20) DEFAULT NULL,
  memory bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_host_cpu_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  sample_id bigint(20) DEFAULT NULL,
  cpu_id bigint(20) DEFAULT NULL,
  cpu_percent_usage bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK_HOST_CPU_SAMPLE (sample_id)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_host_disk_io_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  sample_id bigint(20) DEFAULT NULL,
  disk_id varchar(255) DEFAULT NULL,
  read_latency bigint(20) DEFAULT NULL,
  write_latency bigint(20) DEFAULT NULL,
  total_latency bigint(20) DEFAULT NULL,
  read_rate bigint(20) DEFAULT NULL,
  write_rate bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK_HOST_DISK_SAMPLE (sample_id)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_host_disk_io_adv_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  sample_id bigint(20) DEFAULT NULL,
  disk_id varchar(255) DEFAULT NULL,
  bus_resets bigint(20) DEFAULT NULL,
  commands_aborted bigint(20) DEFAULT NULL,
  device_latency bigint(20) DEFAULT NULL,
  device_read_latency bigint(20) DEFAULT NULL,
  device_write_latency bigint(20) DEFAULT NULL,
  kernel_latency bigint(20) DEFAULT NULL,
  kernel_read_latency bigint(20) DEFAULT NULL,
  kernel_write_latency bigint(20) DEFAULT NULL,
  queue_latency bigint(20) DEFAULT NULL,
  queue_read_latency bigint(20) DEFAULT NULL,
  queue_write_latency bigint(20) DEFAULT NULL,
  read_count bigint(20) DEFAULT NULL,
  write_count bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK_HOST_DISK_ADV_SAMPLE (sample_id)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_host_network_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  sample_id bigint(20) DEFAULT NULL,
  nic_id varchar(255) DEFAULT NULL,
  receive_rate bigint(20) DEFAULT NULL,
  receive_dropped bigint(20) DEFAULT NULL,
  transmit_rate bigint(20) DEFAULT NULL,
  transmit_dropped bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK_HOST_NETWORK_SAMPLE (sample_id)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_host_power_state_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  powered_on int(11) DEFAULT NULL,
  powered_off int(11) DEFAULT NULL,
  maintenance int(11) DEFAULT NULL,
  standby int(11) DEFAULT NULL,
  unknown int(11) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_mem_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  active bigint(20) DEFAULT NULL,
  ballooned bigint(20) DEFAULT NULL,
  granted bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_mem_advanced_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  overhead bigint(20) DEFAULT NULL,
  shared bigint(20) DEFAULT NULL,
  shared_common bigint(20) DEFAULT NULL,
  swap_rate_in bigint(20) DEFAULT NULL,
  swap_rate_out bigint(20) DEFAULT NULL,
  swap_used bigint(20) DEFAULT NULL,
  zero bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_network_rate_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  receive_rate bigint(20) DEFAULT NULL,
  transmit_rate bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_vm_cpu_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  ready bigint(20) DEFAULT NULL,
  wait bigint(20) DEFAULT NULL,
  cpu_percent_usage bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_vm_disk_io_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  sample_id bigint(20) DEFAULT NULL,
  disk_id varchar(255) DEFAULT NULL,
  bus_resets bigint(20) DEFAULT NULL,
  commands_aborted bigint(20) DEFAULT NULL,
  read_count bigint(20) DEFAULT NULL,
  read_rate bigint(20) DEFAULT NULL,
  write_count bigint(20) DEFAULT NULL,
  write_rate bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK_VM_DISK_SAMPLE (sample_id)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_vm_network_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  sample_id bigint(20) DEFAULT NULL,
  nic_id varchar(255) DEFAULT NULL,
  receive_rate bigint(20) DEFAULT NULL,
  transmit_rate bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK_VM_NETWORK_SAMPLE (sample_id)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_vm_power_state_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  powered_on int(11) DEFAULT NULL,
  powered_off int(11) DEFAULT NULL,
  suspended int(11) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_vm_storage_usage_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  provisioned bigint(20) DEFAULT NULL,
  disk bigint(20) DEFAULT NULL,
  snapshot bigint(20) DEFAULT NULL,
  swap bigint(20) DEFAULT NULL,
  other bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_vm_vcpu_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  sample_id bigint(20) DEFAULT NULL,
  cpu_id bigint(20) DEFAULT NULL,
  cpu_usage bigint(20) DEFAULT NULL,
  system bigint(20) DEFAULT NULL,
  wait bigint(20) DEFAULT NULL,
  used bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK_VM_VCPU_SAMPLE (sample_id)
)
{$partition_sample_time}


CREATE TABLE vmware_perf_watts_par (
  sample_id bigint(20) NOT NULL DEFAULT 0,
  watts bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (sample_id, sample_time)
)
{$partition_sample_time}


CREATE TABLE net_device_perf_sample_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  entity_id bigint(20) DEFAULT NULL,
  sample_time datetime DEFAULT NULL,
  PRIMARY KEY (id, sample_time)
)
{$partition_sample_time}

CREATE TABLE net_device_perf_ping_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  average_time double DEFAULT NULL,
  percent_loss double DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK_NET_DEV_PERF_PING_SAMPLE (sample_id)
)
{$partition_sample_time}

CREATE TABLE net_device_perf_port_par (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  if_index bigint(20) DEFAULT NULL,
  if_oper_status bigint(20) DEFAULT NULL,
  kbps_in_rate bigint(20) DEFAULT NULL,
  kbps_out_rate bigint(20) DEFAULT NULL,
  kbps_total_rate bigint(20) DEFAULT NULL,
  discards_in_rate bigint(20) DEFAULT NULL,
  discards_out_rate bigint(20) DEFAULT NULL,
  discards_total_rate bigint(20) DEFAULT NULL,
  errors_in_rate bigint(20) DEFAULT NULL,
  errors_out_rate bigint(20) DEFAULT NULL,
  errors_total_rate bigint(20) DEFAULT NULL,
  usage_in_percent int(11) DEFAULT NULL,
  usage_out_percent int(11) DEFAULT NULL,
  usage_percent int(11) DEFAULT NULL,
  sample_id bigint(20) DEFAULT NULL,
  sample_time DATETIME DEFAULT 0,
  PRIMARY KEY (id, sample_time),
  KEY FK_NET_DEV_PERF_PORT_SAMPLE (sample_id)
)
{$partition_sample_time}
</textarea>

</center>

{* include file="footer.tpl" *}
