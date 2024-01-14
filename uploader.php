<?php
#phpinfo();
  ini_set('display_errors',1);  error_reporting(E_ALL);
  header('Content-Type: application/json');

  if (php_sapi_name() == "cli") {
    $input = json_decode(file_get_contents('local.json'));
  } else {
    $input = json_decode(file_get_contents('php://input')); 
  }

  print json_encode($input, JSON_PRETTY_PRINT);
?>

