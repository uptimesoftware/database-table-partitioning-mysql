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
