<?php

/*
require_once('global.php');
$metaInfo["Keywords"]    = "Server Monitoring Capacity Planning Tools Utilities XML Generator DBCheck Uptime DataStore Sizing Calculator Agent System Agentless Monitor Alert Profiles CPU Usage Uptime Software Tutorials Install Installation Guide Documenatation Product Tour Solution Guides AIX Solaris Unix Linux Windows Monitoring virtualization server monitoring up.time";
$metaInfo["Description"] = "uptime Software | Free Tools and Utilities | XML Generator | Uptime DBCheck | DataStore Sizing Calculator";
$lore_system->te->assign('metainfo', $metaInfo);
*/
require_once('global.php');


$page_error = "";
$page_title     = "up.time - MySQL 'Create Table' Generator for Table Partitioning";
$templateFile   = "partitioning-mysql-creates.tpl";

$min_partitions = 2;

########################################################
## set vars
########################################################
    if (isset($_GET["partitions"])) {
        $num_of_partitions = $_GET["partitions"];
        // should not have less than $min_partitions partitions
        if ($num_of_partitions < $min_partitions) {
            $num_of_partitions = 12;
        }
        elseif ($num_of_partitions > 20) {
            $num_of_partitions = 20;
        }
    } else {
        $num_of_partitions = 12;
    }

########################################################
## build the create table string
########################################################
    $partition_sample_time = "PARTITION BY RANGE (TO_DAYS(sample_time)) (\n";
    $partition_sampletime = "PARTITION BY RANGE (TO_DAYS(sampletime)) (\n";
    $partition_timestamp = "PARTITION BY RANGE (TO_DAYS(timestamp)) (\n";
    for ($i = $num_of_partitions-1; $i >= -1; $i--) {
        // calculate new date
        // date format: 2010-09-01 00:00:00
        
        $interval = $i * -1;
        
        $newStamp = strtotime(date("Y-m", time()) . "-01 " . $interval . " months");
        $newStampPlus = strtotime(date("Y-m", time()) . "-01 " . ($interval+1) . " months");
        $year  = date("Y", $newStamp);
        $month = date("m", $newStamp);
        $partition_sample_time .= "PARTITION par_{$year}_{$month} VALUES LESS THAN (TO_DAYS('" . date("Y-m-d", $newStampPlus) . " 00:00:00')),\n";
        $partition_sampletime .= "PARTITION par_{$year}_{$month} VALUES LESS THAN (TO_DAYS('" . date("Y-m-d", $newStampPlus) . " 00:00:00')),\n";
        $partition_timestamp .= "PARTITION par_{$year}_{$month} VALUES LESS THAN (TO_DAYS('" . date("Y-m-d", $newStampPlus) . " 00:00:00')),\n";
    }
    $partition_sample_time .= "PARTITION par_max VALUES LESS THAN (MAXVALUE)\n);\n";
    $partition_sampletime .= "PARTITION par_max VALUES LESS THAN (MAXVALUE)\n);\n";
    $partition_timestamp .= "PARTITION par_max VALUES LESS THAN (MAXVALUE)\n);\n";



// SMARTY: Assign variables
$smarty->assign( 'currentDatetime', date("Y-m-d h:i:s", time()) );
$smarty->assign( 'title', $page_title );
$smarty->assign( 'num_of_partitions', $num_of_partitions );
$smarty->assign( 'partition_sample_time', $partition_sample_time );
$smarty->assign( 'partition_sampletime', $partition_sampletime );
$smarty->assign( 'partition_timestamp', $partition_timestamp );
$smarty->assign( 'min_partitions', $min_partitions );

// SMARTY: Display page
$smarty->display($templateFile);

/*
$lore_system->te->assign('req', $_GET);
$lore_system->te->assign('title', $page_title);
$lore_system->te->assign('num_of_partitions', $num_of_partitions);
$lore_system->te->assign('currentDatetime', date("Y-m-d h:i:s", time()));

$lore_system->te->assign('partition_sample_time', $partition_sample_time);

$lore_system->te->display($templateFile);
$lore_system->db->close();
*/

?>