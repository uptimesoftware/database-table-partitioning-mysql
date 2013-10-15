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
