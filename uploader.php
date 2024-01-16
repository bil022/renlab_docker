<?php
#phpinfo();
  ini_set('display_errors',1);  error_reporting(E_ALL);
  header('Content-Type: application/json');
  
  $method="post_or_local";
  if (isset($_SERVER['REQUEST_METHOD'])) {
    $method=$_SERVER['REQUEST_METHOD'];
  }

  $thumb='https://renlab.sdsc.edu/renlab_docker/uploader/uploader.png';
  if ($method == "GET") {
    $json=file_get_contents('uploader/data.json');
    $input = json_decode('{"json":'.$json.', "thumb":"'.$thumb.'"}');
  } else {
    if (php_sapi_name()=="cli") {
      $input=json_decode(file_get_contents('local.json'), true);
    } else {
      //$input = array("content"=>file_get_contents('php://input'));
      $input=json_decode($_POST['json'], true);
    }

    $upload="NA";
    foreach ($input as $item) {
      if ($item['name']=="thumb")
        $upload=$item['value'];
    }
    $status="OK";
    if ($upload!=$thumb) {
      $headers = @get_headers($thumb, 1); // @ to suppress errors. Remove when debugging.
      if (isset($headers['Content-Type'])) {
        if (strpos($headers['Content-Type'], 'image/png') === FALSE) {
          $status="Not a png image: ".$thumb;
        } else {
          // copy image & update thumb
          $content = file_get_contents($upload);
          $ret=file_put_contents('uploader/uploader.png', $content);
          if (!$ret) {
            $status="Cannot save file: ".$upload;
          }
        }
      }
    } else {
      $status="Unknown link: ".$thumb;
    }
    // update json file
    if ($status=="OK") {
      $ret=file_put_contents('uploader/data.json', json_encode($input));
      if (!$ret) {
        $status="Cannot save json file";
      }
    }
    $input='{"status":"'.$status.'"}';
  }
  print json_encode($input, JSON_PRETTY_PRINT);
?>

