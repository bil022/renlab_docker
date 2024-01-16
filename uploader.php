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
      $input = new stdClass();
      $input->json=json_decode(file_get_contents('local.json'));
    } else {
      //$input = array("content"=>file_get_contents('php://input'));
      $input = $_REQUEST;
    }

    print_r($input);

    $upload="NA";
    foreach ($input->json as $item) {
      if ($item->{'name'}=="thumb")
        $upload=$item->{'value'};
    }
    $input->status="OK";
    if ($upload!=$thumb) {
      $headers = @get_headers($thumb, 1); // @ to suppress errors. Remove when debugging.
      if (isset($headers['Content-Type'])) {
        if (strpos($headers['Content-Type'], 'image/png') === FALSE) {
          $input->status="Not a png image: ".$thumb;
        } else {
          // copy image & update thumb
          $content = file_get_contents($upload);
          $ret=file_put_contents('uploader/uploader.png', $content);
          if ($ret) {
            $input->json["thumb"]=$thumb;
          } else {
            $input->status="Cannot save file: ".$upload;
          }
        }
      }
    } else {
      $input->status="Unknown link: ".$thumb;
    }
  }
  print json_encode($input, JSON_PRETTY_PRINT);
?>

