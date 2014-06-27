<?php
$ret = shell_exec('ifconfig | grep 192.');
$ip_ad = preg_replace('/^.*addr:(192\S*) .*$/', '$1', trim($ret));
?>
<!doctype html>
<html lang="ja">
<head>
	<meta charset="UTF-8">
	<title>tamvagrant</title>
	<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.3/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container">
<h1><?= $_SERVER['HTTP_HOST'] ?></h1>

<hr/>

<ul>
<?php
foreach (glob('*') as $filename) {
	if (! is_dir($filename)) {
		continue;
	}

	$url = "http://{$filename}.{$ip_ad}.xip.io";
	echo '<li><a href="' . $url . '">' . $filename . '</a></li>';
}
?>
</ul>

<hr/>

<ul>
	<li><a href="#">phpMyAdmin</a></li>
	<li><a href="info.php">phpinfo()</a></li>
</ul>

</div>
</body>
</html>
