<?php
require_once("config.php");
require_once("jslogin.php");

$inviter_email = $_SESSION['user_email'];
// echo $inviter_email;




$sql = "SELECT * FROM team WHERE inviter = ?";
$stmt = $db->prepare($sql);
$result = $stmt->execute([$inviter_email]);

  




if($stmt->rowCount() > 0){
        echo $inviter_email;
        echo "<hr>";
    while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        echo $row["invitee"];
    }

}
