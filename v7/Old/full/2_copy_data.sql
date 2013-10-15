INSERT INTO performance_sample_par SELECT * FROM performance_sample;
RENAME TABLE performance_sample TO performance_sample_ori;
RENAME TABLE performance_sample_par TO performance_sample;

INSERT INTO performance_aggregate_par SELECT p.*, ps.sample_time FROM performance_aggregate p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_aggregate TO performance_aggregate_ori;
DROP TABLE IF EXISTS performance_aggregate_ori;

INSERT INTO performance_cpu_par SELECT p.*, ps.sample_time FROM performance_cpu p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_cpu TO performance_cpu_ori;
DROP TABLE IF EXISTS performance_cpu_ori;

INSERT INTO performance_disk_par SELECT p.*, ps.sample_time FROM performance_disk p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_disk TO performance_disk_ori;
DROP TABLE IF EXISTS performance_disk_ori;

INSERT INTO performance_disk_total_par SELECT p.*, ps.sample_time FROM performance_disk_total p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_disk_total TO performance_disk_total_ori;
DROP TABLE IF EXISTS performance_disk_total_ori;

INSERT INTO performance_esx3_workload_par SELECT p.*, ps.sample_time FROM performance_esx3_workload p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_esx3_workload TO performance_esx3_workload_ori;
DROP TABLE IF EXISTS performance_esx3_workload_ori;

INSERT INTO performance_fscap_par SELECT p.*, ps.sample_time FROM performance_fscap p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_fscap TO performance_fscap_ori;
DROP TABLE IF EXISTS performance_fscap_ori;

INSERT INTO performance_lpar_workload_par SELECT p.*, ps.sample_time FROM performance_lpar_workload p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_lpar_workload TO performance_lpar_workload_ori;
DROP TABLE IF EXISTS performance_lpar_workload_ori;

INSERT INTO performance_network_par SELECT p.*, ps.sample_time FROM performance_network p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_network TO performance_network_ori;
DROP TABLE IF EXISTS performance_network_ori;

INSERT INTO performance_nrm_par SELECT p.*, ps.sample_time FROM performance_nrm p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_nrm TO performance_nrm_ori;
DROP TABLE IF EXISTS performance_nrm_ori;

INSERT INTO performance_psinfo_par SELECT p.*, ps.sample_time FROM performance_psinfo p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_psinfo TO performance_psinfo_ori;
DROP TABLE IF EXISTS performance_psinfo_ori;

INSERT INTO performance_vxvol_par SELECT p.*, ps.sample_time FROM performance_vxvol p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_vxvol TO performance_vxvol_ori;
DROP TABLE IF EXISTS performance_vxvol_ori;

INSERT INTO performance_who_par SELECT p.*, ps.sample_time FROM performance_who p, performance_sample ps WHERE p.sample_id = ps.id;
RENAME TABLE performance_who TO performance_who_ori;
DROP TABLE IF EXISTS performance_who_ori;

DROP TABLE IF EXISTS performance_sample_ori;


INSERT INTO erdc_decimal_data_par SELECT * FROM erdc_decimal_data;
RENAME TABLE erdc_decimal_data TO erdc_decimal_data_ori;
RENAME TABLE erdc_decimal_data_par TO erdc_decimal_data;
DROP TABLE IF EXISTS erdc_decimal_data_ori;

INSERT INTO erdc_int_data_par SELECT * FROM erdc_int_data;
RENAME TABLE erdc_int_data TO erdc_int_data_ori;
RENAME TABLE erdc_int_data_par TO erdc_int_data;
DROP TABLE IF EXISTS erdc_int_data_ori;

INSERT INTO erdc_string_data_par SELECT * FROM erdc_string_data;
RENAME TABLE erdc_string_data TO erdc_string_data_ori;
RENAME TABLE erdc_string_data_par TO erdc_string_data;
DROP TABLE IF EXISTS erdc_string_data_ori;

INSERT INTO ranged_object_value_par SELECT * FROM ranged_object_value;
RENAME TABLE ranged_object_value TO ranged_object_value_ori;
RENAME TABLE ranged_object_value_par TO ranged_object_value;
DROP TABLE IF EXISTS ranged_object_value_ori;


-- uptime 6 VMware tables

INSERT INTO vmware_perf_sample_par SELECT * FROM vmware_perf_sample;
RENAME TABLE vmware_perf_sample TO vmware_perf_sample_ori;
RENAME TABLE vmware_perf_sample_par TO vmware_perf_sample;


INSERT INTO vmware_perf_aggregate_par SELECT p.*, ps.sample_time FROM vmware_perf_aggregate p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_aggregate;

INSERT INTO vmware_perf_cluster_par SELECT p.*, ps.sample_time FROM vmware_perf_cluster p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_cluster;

INSERT INTO vmware_perf_datastore_usage_par SELECT p.*, ps.sample_time FROM vmware_perf_datastore_usage p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_datastore_usage;

INSERT INTO vmware_perf_datastore_vm_usage_par SELECT p.*, ps.sample_time FROM vmware_perf_datastore_vm_usage p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_datastore_vm_usage;

INSERT INTO vmware_perf_disk_rate_par SELECT p.*, ps.sample_time FROM vmware_perf_disk_rate p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_disk_rate;

INSERT INTO vmware_perf_entitlement_par SELECT p.*, ps.sample_time FROM vmware_perf_entitlement p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_entitlement;

INSERT INTO vmware_perf_host_cpu_par SELECT p.*, ps.sample_time FROM vmware_perf_host_cpu p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_host_cpu;

INSERT INTO vmware_perf_host_disk_io_par SELECT p.*, ps.sample_time FROM vmware_perf_host_disk_io p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_host_disk_io;

INSERT INTO vmware_perf_host_disk_io_adv_par SELECT p.*, ps.sample_time FROM vmware_perf_host_disk_io_adv p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_host_disk_io_adv;

INSERT INTO vmware_perf_host_network_par SELECT p.*, ps.sample_time FROM vmware_perf_host_network p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_host_network;

INSERT INTO vmware_perf_host_power_state_par SELECT p.*, ps.sample_time FROM vmware_perf_host_power_state p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_host_power_state;

INSERT INTO vmware_perf_mem_par SELECT p.*, ps.sample_time FROM vmware_perf_mem p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_mem;

INSERT INTO vmware_perf_mem_advanced_par SELECT p.*, ps.sample_time FROM vmware_perf_mem_advanced p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_mem_advanced;

INSERT INTO vmware_perf_network_rate_par SELECT p.*, ps.sample_time FROM vmware_perf_network_rate p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_network_rate;

INSERT INTO vmware_perf_vm_cpu_par SELECT p.*, ps.sample_time FROM vmware_perf_vm_cpu p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_vm_cpu;

INSERT INTO vmware_perf_vm_disk_io_par SELECT p.*, ps.sample_time FROM vmware_perf_vm_disk_io p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_vm_disk_io;

INSERT INTO vmware_perf_vm_network_par SELECT p.*, ps.sample_time FROM vmware_perf_vm_network p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_vm_network;

INSERT INTO vmware_perf_vm_power_state_par SELECT p.*, ps.sample_time FROM vmware_perf_vm_power_state p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_vm_power_state;

INSERT INTO vmware_perf_vm_storage_usage_par SELECT p.*, ps.sample_time FROM vmware_perf_vm_storage_usage p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_vm_storage_usage;

INSERT INTO vmware_perf_vm_vcpu_par SELECT p.*, ps.sample_time FROM vmware_perf_vm_vcpu p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_vm_vcpu;

INSERT INTO vmware_perf_watts_par SELECT p.*, ps.sample_time FROM vmware_perf_watts p, vmware_perf_sample ps WHERE p.sample_id = ps.sample_id;
DROP TABLE IF EXISTS vmware_perf_watts;

DROP TABLE IF EXISTS vmware_perf_sample_ori;


-- uptime 7 Network Device tables

INSERT INTO net_device_perf_sample_par SELECT * FROM net_device_perf_sample;
RENAME TABLE net_device_perf_sample TO net_device_perf_sample_ori;
RENAME TABLE net_device_perf_sample_par TO net_device_perf_sample;

INSERT INTO net_device_perf_ping_par SELECT p.*, ps.sample_time FROM net_device_perf_ping p, net_device_perf_sample ps WHERE p.sample_id = ps.id;
DROP TABLE IF EXISTS net_device_perf_ping;

INSERT INTO net_device_perf_port_par SELECT p.*, ps.sample_time FROM net_device_perf_port p, net_device_perf_sample ps WHERE p.sample_id = ps.id;
DROP TABLE IF EXISTS net_device_perf_port;

DROP TABLE IF EXISTS net_device_perf_sample_ori;





-- Create views for special (_par) tables

CREATE OR REPLACE VIEW performance_aggregate AS
SELECT sample_id, cpu_usr, cpu_sys, cpu_wio, free_mem, free_swap,
 run_queue, run_occ, read_cache, write_cache, pg_out_sec, ppg_out_sec,
 pg_free_sec, pg_scan_sec, atch_sec, pg_in_sec, ppg_in_sec, pflt_sec,
 vflt_sec, slock_sec, num_procs, proc_read, proc_write, proc_block,
 dnlc, fork_sec, exec_sec, tcp_retrans, worst_disk_usage, worst_disk_busy,
 used_swap_percent
FROM performance_aggregate_par;

CREATE OR REPLACE VIEW performance_cpu AS
SELECT id, cpu_id, cpu_usr, cpu_sys, cpu_wio, xcal, intr, smtx, minf,
 mjf, ithr, csw, icsw, migr, srw, syscl, idle, sample_id
FROM performance_cpu_par;

CREATE OR REPLACE VIEW performance_disk AS
SELECT id, disk_name, pct_time_busy, avg_queue_req, rw_sec, blocks_sec,
 avg_wait_time, avg_serv_time, sample_id
FROM performance_disk_par;

CREATE OR REPLACE VIEW performance_disk_total AS
SELECT sample_id, pct_time_busy, avg_queue_req, rw_sec, blocks_sec,
 avg_wait_time, avg_serv_time
FROM performance_disk_total_par;

CREATE OR REPLACE VIEW performance_esx3_workload AS
SELECT id, uuid, instance_name, cpu_usage_mhz, memory, disk_io_rate,
 network_io_rate, percent_ready, percent_used, sample_id
FROM performance_esx3_workload_par;

CREATE OR REPLACE VIEW performance_fscap AS
SELECT id, filesystem, total_size, space_used, space_avail, percent_used,
 mount_point, sample_id
FROM performance_fscap_par;

CREATE OR REPLACE VIEW performance_lpar_workload AS
SELECT id, lpar_id, instance_name, entitlement, cpu_usage, used_memory,
 network_io_rate, disk_io_rate, sample_id
FROM performance_lpar_workload_par;

CREATE OR REPLACE VIEW performance_network AS
SELECT id, iface_name, in_bytes, out_bytes, collisions, in_errors, out_errors, sample_id
FROM performance_network_par;

CREATE OR REPLACE VIEW performance_nrm AS
SELECT sample_id, work_to_do, available_disk, ds_thread_usage, allocated_server_procs,
 available_server_procs, packet_receive_buffers, available_ecbs, lan_traffic,
 connection_usage, disk_throughput, abended_thread_count
FROM performance_nrm_par;

CREATE OR REPLACE VIEW performance_psinfo AS
SELECT id, pid, ppid, ps_uid, gid, mem_used, rss, cpu_usage, memory_usage,
 user_cpu_time, sys_cpu_time, start_time, proc_name, sample_id
FROM performance_psinfo_par;

CREATE OR REPLACE VIEW performance_vxvol AS
SELECT id, dg, vol, rd_ops, wr_ops, rd_blks, wr_blks, avg_rd, avg_wr, sample_id
FROM performance_vxvol_par;

CREATE OR REPLACE VIEW performance_who AS
SELECT id, username, session_count, sample_id
FROM performance_who_par;


-- uptime 6 VMware views

CREATE OR REPLACE VIEW vmware_perf_aggregate AS
SELECT sample_id, cpu_reservation, cpu_usage, cpu_total, disk_usage, memory_reservation,
memory_usage, memory_total, network_usage
FROM vmware_perf_aggregate_par;


CREATE OR REPLACE VIEW vmware_perf_cluster AS
SELECT sample_id, failover
FROM vmware_perf_cluster_par;


CREATE OR REPLACE VIEW vmware_perf_datastore_usage AS
SELECT sample_id, capacity, provisioned, usage_total, usage_vm_disk, usage_snapshot,
usage_swap, usage_other_vm, usage_other
FROM vmware_perf_datastore_usage_par;


CREATE OR REPLACE VIEW vmware_perf_datastore_vm_usage AS
SELECT id, sample_id, virtual_machine_id, usage_total
FROM vmware_perf_datastore_vm_usage_par;


CREATE OR REPLACE VIEW vmware_perf_disk_rate AS
SELECT sample_id, read_rate, write_rate
FROM vmware_perf_disk_rate_par;


CREATE OR REPLACE VIEW vmware_perf_entitlement AS
SELECT sample_id, cpu, memory
FROM vmware_perf_entitlement_par;


CREATE OR REPLACE VIEW vmware_perf_host_cpu AS
SELECT id, sample_id, cpu_id, cpu_percent_usage
FROM vmware_perf_host_cpu_par;


CREATE OR REPLACE VIEW vmware_perf_host_disk_io AS
SELECT id, sample_id, disk_id, read_latency, write_latency, total_latency,
read_rate, write_rate
FROM vmware_perf_host_disk_io_par;


CREATE OR REPLACE VIEW vmware_perf_host_disk_io_adv AS
SELECT id, sample_id, disk_id, bus_resets, commands_aborted, device_latency,
device_read_latency, device_write_latency, kernel_latency, kernel_read_latency,
kernel_write_latency, queue_latency, queue_read_latency, queue_write_latency,
read_count, write_count
FROM vmware_perf_host_disk_io_adv_par;


CREATE OR REPLACE VIEW vmware_perf_host_network AS
SELECT id, sample_id, nic_id, receive_rate, receive_dropped, transmit_rate, transmit_dropped
FROM vmware_perf_host_network_par;


CREATE OR REPLACE VIEW vmware_perf_host_power_state AS
SELECT sample_id, powered_on, powered_off, maintenance, standby, unknown
FROM vmware_perf_host_power_state_par;


CREATE OR REPLACE VIEW vmware_perf_mem AS
SELECT sample_id, active, ballooned, granted
FROM vmware_perf_mem_par;


CREATE OR REPLACE VIEW vmware_perf_mem_advanced AS
SELECT sample_id, overhead, shared, shared_common, swap_rate_in, swap_rate_out,
swap_used, zero
FROM vmware_perf_mem_advanced_par;


CREATE OR REPLACE VIEW vmware_perf_network_rate AS
SELECT sample_id, receive_rate, transmit_rate
FROM vmware_perf_network_rate_par;


CREATE OR REPLACE VIEW vmware_perf_vm_cpu AS
SELECT sample_id, ready, wait, cpu_percent_usage
FROM vmware_perf_vm_cpu_par;


CREATE OR REPLACE VIEW vmware_perf_vm_disk_io AS
SELECT id, sample_id, disk_id, bus_resets, commands_aborted, read_count, read_rate,
write_count, write_rate
FROM vmware_perf_vm_disk_io_par;


CREATE OR REPLACE VIEW vmware_perf_vm_network AS
SELECT id, sample_id, nic_id, receive_rate, transmit_rate
FROM vmware_perf_vm_network_par;


CREATE OR REPLACE VIEW vmware_perf_vm_power_state AS
SELECT sample_id, powered_on, powered_off, suspended
FROM vmware_perf_vm_power_state_par;


CREATE OR REPLACE VIEW vmware_perf_vm_storage_usage AS
SELECT sample_id, provisioned, disk, snapshot, swap, other
FROM vmware_perf_vm_storage_usage_par;


CREATE OR REPLACE VIEW vmware_perf_vm_vcpu AS
SELECT id, sample_id, cpu_id, cpu_usage, system, wait, used
FROM vmware_perf_vm_vcpu_par;


CREATE OR REPLACE VIEW vmware_perf_watts AS
SELECT sample_id, watts
FROM vmware_perf_watts_par;


-- uptime 7 Network Device views

CREATE OR REPLACE VIEW net_device_perf_ping AS
SELECT id, average_time, percent_loss, sample_id
FROM net_device_perf_ping_par;

CREATE OR REPLACE VIEW net_device_perf_port AS
SELECT id, if_index, if_oper_status,
kbps_in_rate, kbps_out_rate, kbps_total_rate,
discards_in_rate, discards_out_rate, discards_total_rate,
errors_in_rate, errors_out_rate, errors_total_rate,
usage_in_percent, usage_out_percent, usage_percent, sample_id
FROM net_device_perf_port_par;
