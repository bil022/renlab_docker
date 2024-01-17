<?php
#phpinfo();
  ini_set('display_errors',1);  error_reporting(E_ALL);
  
  $method="post_or_local";
  if (isset($_SERVER['REQUEST_METHOD'])) {
    $method=$_SERVER['REQUEST_METHOD'];
  }

  function ID($json) {
    print($json['fname']);
  }

  function publications($json) {
    $year = date("Y");
    print("--\nlayout:	page\ntitle:	\”".$json['title']."\"\n");
    print("breadcrumb: true\ncategories:\n- publication\npub:\n");
    print("authors: ".$json['authors']."\n");
    print("journal: \"".$json['journal']."\"\n");
    print("date: ".$year."\n");
    print("doi: ".$json['doi']."\n");
    print("abstract: ".$json['abstract']."\n--\n");
  }

  function news() {
    print("---\nlayout:	page\nsubheadline:	Congratulations!\n");
    print("title: \"".$json['title']."\"\n");
    print("teaser: \"".$json['teaser']."\"\n");
    print("breadcrumb: true\ntags:\n");	
    print("- paper accepted\n");
    print("categories:\n");
    print("    - news\n");
    print("image:\n");
    print("    thumb: 	".$json['fname'].".png\n");
    print("    title:	".$json['fname'].".png\n");
    print("    caption_url: 	http://unsplash.com\n");
    print("---\n\n");
    print("<b>Abstract</b>:\n");	
    print($json['abstract']."\n");
    print("> Full text can be accessed from the following [link](".$json['full_text_link'].")\n");
  }

  $thumb='https://renlab.sdsc.edu/renlab_docker/uploader/uploader.png';
  if ($method == "GET") {
    $json=file_get_contents('uploader/data.json', true);
    if (isset($_REQUEST["publications"])) {
      print(publications($json)); exit;
    } elseif (isset($_REQUEST["news"])) {
      print(news($json)); exit;
    } elseif (isset($_REQUEST["ID"])) {
      print(ID($json)); exit;
    } else {
      $input = json_decode('{"json":'.$json.', "thumb":"'.$thumb.'"}');
    }
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
  header('Content-Type: application/json');
  print json_encode($input, JSON_PRETTY_PRINT);
?>

