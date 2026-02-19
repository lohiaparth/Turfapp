<?php
session_start();
require_once('config.php');
//error_reporting(E_ERROR | E_PARSE);

$loginemail = $_POST['loginemail'];
//echo $loginemail;
$loginpassword = $_POST['loginpassword'];
//echo $loginpassword;

$sql = "SELECT * FROM users WHERE email = ? AND password = ? LIMIT 1"; //try db names of fields if doesnt work
$stmtselect  = $db->prepare($sql);
$result = $stmtselect->execute([$loginemail, $loginpassword]);

if($result){
	$user = $stmtselect->fetch(PDO::FETCH_ASSOC);
	if($stmtselect->rowCount() > 0){
		$_SESSION['userlogin'] = $user;
		$_SESSION['user_email'] = $user['email'];
		// echo $_SESSION['user_email'];
		echo '1';
	}else{
		// echo 'There no user for that combo';		
	}
}else{
	echo 'There were errors while connecting to database.';
}