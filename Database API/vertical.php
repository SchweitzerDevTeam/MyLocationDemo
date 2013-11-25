<?php

ini_set('display_errors', 'On');

function __autoload($class_name) {
  require_once $class_name . '.php';
}

$api = new SchweitzerMobileAppAPI();
$api-> postUserData();
?>