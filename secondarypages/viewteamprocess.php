<?php

require_once('config.php');
require_once('jslogin.php');

$sql = "SELECT team.invitee, users.fullname, users.phone 
        FROM team 
        INNER JOIN users ON team.invitee = users.email
        WHERE inviter = ?";
$inviter_email = $_SESSION['user_email'];

$stmt = $db->prepare($sql);
$result = $stmt->execute([$inviter_email]);
echo $stmt->rowCount;

if($stmt->rowCount() > 0){
    while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "<div class='view-fri'>
        <div>
          <h2 class='view-name'>".$row["fullname"]."</h2>
        </div>
        <div>
          <h6 class='view-email'>".$row["invitee"]."</h6>
        </div>
        <div>
          <h6 class='view-numb'>".$row["phone"]."</h6>
        </div>
        </div>";
    }
}else{
    echo "no records";
}