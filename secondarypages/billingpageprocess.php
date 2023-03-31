<?php
require_once("config.php");
require_once("jslogin.php");

$inviter_email = $_SESSION['user_email'];
// echo $inviter_email;




$sql = "SELECT * FROM team WHERE inviter = ?";
$stmt = $db->prepare($sql);
$result = $stmt->execute([$inviter_email]);

  




if($stmt->rowCount() > 0){
     echo $stmt->rowCount();
        $price = (2000/($stmt->rowcount()+1));
        echo "<div class='view-fri'>
                    <div>
                  <h2 class='view-name'>".$inviter_email."</h2>
                </div>
                <div>
                  <h6 class='view-numb'>₹".$price."</h6>
                </div>
                </div>";
        // echo $inviter_email;
        // echo "<hr>";
    while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
        echo "<div class='view-fri'>
                    <div>
                  <h2 class='view-name'>".$row["invitee"]."</h2>
                </div>
                <div>
                  <h6 class='view-numb'>₹".$price."</h6>
                </div>
                </div>";
        
    }
    echo "<div class='view-fri'>
                    <div>
                  <h2 class='view-name'>TOTAL</h2>
                </div>
                <div>
                  <h6 class='view-numb'>₹2000</h6>
                </div>
                </div>";

}
