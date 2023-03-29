<?php
session_start();

require_once('config.php');

require_once('jslogin.php');
?>

<?php

$invitee = $_POST['invitee'];
// echo $_SESSION['user_email'];

$sql = "SELECT * FROM users WHERE email = ?";
$stmtselect = $db->prepare($sql);
$result = $stmtselect->execute([$invitee]);

if($stmtselect->rowCount() > 0){
    // echo $stmtselect->rowCount() > 0;
    $new_sql = "INSERT INTO invites (inviter, invitee) VALUES(?,?)";
    $stmtinsert = $db->prepare($new_sql);
    $final_result = $stmtinsert->execute([$_SESSION['user_email'], $invitee]);
    echo 'invite sent';

    // if($final_result){
    //     echo 'invite sent';
    // }else{
    //     echo 'invite not sent';
    // }
}else{
    echo 'invitee not found';
}