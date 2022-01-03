<?php
include 'db.php';
include 'xml.php';
$req = file_get_contents('php://input');
$req = json_decode($req);

switch ($req->operation) {
  case 'getNews':
    echo json_encode(getNews(), JSON_UNESCAPED_UNICODE);
    break;
  case 'updateNews':
    $xml = Xml::createArray(file_get_contents('../xml/news.xml'));
    updateNews($xml['Xml']['post']);
    break;
  case 'cleanNews':
    cleanNews();
    break;
}
