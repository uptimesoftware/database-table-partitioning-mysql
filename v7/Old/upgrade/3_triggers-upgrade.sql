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


-- uptime 7 Network Device tables

CREATE TRIGGER trig_nd_ping BEFORE INSERT ON net_device_perf_ping_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM net_device_perf_sample ps WHERE ps.id = NEW.sample_id);

CREATE TRIGGER trig_nd_port BEFORE INSERT ON net_device_perf_port_par
FOR EACH ROW SET NEW.sample_time = 
(SELECT sample_time FROM net_device_perf_sample ps WHERE ps.id = NEW.sample_id);
