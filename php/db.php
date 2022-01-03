<?php
const HOST = '199.203.232.76';
const USER = 'dev1xbeta';
const PASS  = 'iwN8g7vHLA+g';
const DATABASE = 'dev1xbet_data';
$sql = new mysqli(HOST, USER, PASS, DATABASE);

function getNews()
{
  global $sql;

  $query = "SELECT `id`,`title`,`description`,`date` FROM `news`";

  $result = $sql->query($query);
  return $result->fetch_all(MYSQLI_ASSOC);
}

function updateNews($news)
{
  global $sql;

  $query = "INSERT INTO `news` (`id`,`title`,`description`) VALUES (";
  foreach ($news as $element) {
    ['id' => $id, 'title' => $title, 'description' => $description] = $element;

    $query .= "$id, '$title', '$description'),(";
  }

  $query = rtrim($query, ',(');
  $query .= "ON DUPLICATE KEY UPDATE
  `title` = VALUES(title),
  `description` = VALUES(description)";

  $sql->query($query);
}

function cleanNews()
{
  global $sql;
  $query = "TRUNCATE `news`";
  $sql->query($query);
}
