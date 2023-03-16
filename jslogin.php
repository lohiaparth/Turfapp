<?php
session_start();
require_once('config.php');


$loginemail = $_POST['loginemail'];
$loginpassword = $_POST['loginpassword'];

$sql = "SELECT * FROM users WHERE loginemail = ? AND loginpassword = ? LIMIT 1"; //try db names of fields if doesnt work
$stmtselect  = $db->prepare($sql);
$result = $stmtselect->execute([$loginemail, $loginpassword]);

if($result){
	$user = $stmtselect->fetch(PDO::FETCH_ASSOC);
	if($stmtselect->rowCount() > 0){
		$_SESSION['userlogin'] = $user;
		echo '1';
	}else{
		echo 'There no user for that combo';		
	}
}else{
	echo 'There were errors while connecting to database.';
}