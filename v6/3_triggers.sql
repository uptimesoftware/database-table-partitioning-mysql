CREATE TRIGGER trig_p_aggregate BEFORE INSERT ON performance_aggregate_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_cpu BEFORE INSERT ON performance_cpu_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_disk BEFORE INSERT ON performance_disk_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_disk_total BEFORE INSERT ON performance_disk_total_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_esx3_workload BEFORE INSERT ON performance_esx3_workload_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_fscap BEFORE INSERT ON performance_fscap_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_lpar_workload BEFORE INSERT ON performance_lpar_workload_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_network BEFORE INSERT ON performance_network_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_nrm BEFORE INSERT ON performance_nrm_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_psinfo BEFORE INSERT ON performance_psinfo_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_vxvol BEFORE INSERT ON performance_vxvol_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);

CREATE TRIGGER trig_p_who BEFORE INSERT ON performance_who_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time from performance_sample ps where ps.id = NEW.sample_id);


-- uptime 6 VMware tables

CREATE TRIGGER trig_vp_aggregate BEFORE INSERT ON vmware_perf_aggregate_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_cluster BEFORE INSERT ON vmware_perf_cluster_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_datastore_usage BEFORE INSERT ON vmware_perf_datastore_usage_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_datastore_vm_usage BEFORE INSERT ON vmware_perf_datastore_vm_usage_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_disk_rate BEFORE INSERT ON vmware_perf_disk_rate_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_entitlement BEFORE INSERT ON vmware_perf_entitlement_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_host_cpu BEFORE INSERT ON vmware_perf_host_cpu_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_host_disk_io BEFORE INSERT ON vmware_perf_host_disk_io_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_host_disk_io_adv BEFORE INSERT ON vmware_perf_host_disk_io_adv_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_host_network BEFORE INSERT ON vmware_perf_host_network_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_host_power_state BEFORE INSERT ON vmware_perf_host_power_state_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_mem BEFORE INSERT ON vmware_perf_mem_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_mem_advanced BEFORE INSERT ON vmware_perf_mem_advanced_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_network_rate BEFORE INSERT ON vmware_perf_network_rate_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_vm_cpu BEFORE INSERT ON vmware_perf_vm_cpu_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_vm_disk_io BEFORE INSERT ON vmware_perf_vm_disk_io_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_vm_network BEFORE INSERT ON vmware_perf_vm_network_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_vm_power_state BEFORE INSERT ON vmware_perf_vm_power_state_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_vm_storage_usage BEFORE INSERT ON vmware_perf_vm_storage_usage_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_vm_vcpu BEFORE INSERT ON vmware_perf_vm_vcpu_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);

CREATE TRIGGER trig_vp_watts BEFORE INSERT ON vmware_perf_watts_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM vmware_perf_sample ps WHERE ps.sample_id = NEW.sample_id);
