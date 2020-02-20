<?php
require('vendor/autoload.php');
$telegram = new \Zyberspace\Telegram\Cli\Client('tcp://127.0.0.1:3345');

$chat = '$05000000afa8e9494b80ac1ddd181bdb';

$limit = 50;
$offset = 0;

function save($msg)
{
    var_dump($msg);
}

function download($telegram, $msg)
{
    $response = $telegram->exec('load_' . $msg->media->type, $msg->id);
    $msg->media->path = $response->result;
}

$last = 0;

while (true) {
    $msgList = $telegram->getHistory($chat, $limit, $offset);
    if (!$msgList) {
        sleep(1);
        continue;
    };
    $offset += $limit;
    foreach ($msgList as $msg) {
        if (isset($msg->media)) {
            //download($telegram, $msg, $msg->media->type);
            continue;
        }
        if ($msg->date > $last) {
            $last = $msg->date;
            save($msg);
        }
    }
}
