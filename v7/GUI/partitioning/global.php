<?php
$cur_dir = str_replace('\\', '/', getcwd());
chdir("./Smarty_3_1_0/");
$smarty_dir = getcwd() . '/';
chdir($cur_dir);

define('SMARTY_DIR', $smarty_dir . 'libs/');
ini_set('include_path', ini_get('include_path') . PATH_SEPARATOR . $smarty_dir . 'libs/');


require_once(SMARTY_DIR . 'Smarty.class.php');

$smarty = new Smarty();
$smarty->template_dir = $smarty_dir . 'templates/';
$smarty->compile_dir  = $smarty_dir . 'templates_c/';
$smarty->config_dir   = $smarty_dir . 'configs/';
$smarty->cache_dir    = $smarty_dir . 'cache/';

//** un-comment the following line to show the debug console
//$smarty->debugging = true;

?>
