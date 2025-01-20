#!/usr/bin/env php
<?php 

/*
 * @Author: Cloudflying
 * @Date: 2023-04-06 00:01:09
 * @LastEditTime: 2023-04-06 00:24:51
 * @LastEditors: Cloudflying
 * @Description: 纯文本特殊字符过滤
 */

$filename = realpath($argv[1]);
$file = fopen($filename, "r");
$root_path = dirname(__DIR__);
// $save = $root_path . "/dists/filter-cookie.txt";
// $save = dirname(__DIR__) . '/' . $argv[2];
$save = $argv[2];
@unlink($save);
file_put_contents($save,"\n");

// echo $filename . PHP_EOL;
// echo $save . PHP_EOL;
// exit;

while (!feof($file)) {
	$str = fgets($file);
	$str = trim($str);
	file_put_contents($save,$str . "\n",FILE_APPEND);
	// var_dump($str);
	// echo $str;
	// exit;
}
fclose($file);

echo "==> Done" . PHP_EOL;