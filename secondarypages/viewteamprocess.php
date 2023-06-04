<?php

require_once('config.php');
require_once('jslogin.php');

// For invitee to see his team

$sql = "SELECT team.invitee, users.fullname, users.phone 
        FROM team 
        INNER JOIN users ON team.invitee = users.email
        WHERE inviter = ?";
$inviter_email = $_SESSION['user_email'];

$stmt = $db->prepare($sql);
$result = $stmt->execute([$inviter_email]);
// echo $stmt->rowCount;

if($stmt->rowCount() > 0){
   $count = 1;
    while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
      $count = $count + 1;

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
    echo $count;
}else{

      // For inviter to see his team --- !!!
      $invitee_email = $_SESSION['user_email'];
      $sql = "SELECT team.inviter, users.fullname, users.phone FROM team INNER JOIN users ON team.inviter = users.email WHERE invitee = '$invitee_email'";
      // echo $sql;
      
      $stmt = $db->prepare($sql);
      
      $result = $stmt->execute();
      
      if($stmt->rowCount() > 0){
            while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
              $main_inviter = $row["inviter"];
              // Displays inviter details --- !!!
                echo "<div class='view-fri'>
                <div>
                  <h2 class='view-name'>".$row["fullname"]."</h2>
                </div>
                <div>
                  <h6 class='view-email'>".$row["inviter"]."</h6>
                </div>
                <div>
                  <h6 class='view-numb'>".$row["phone"]."</h6>
                </div>
                </div>";
            }
              // Displays other invitees --- !!!
            $sql = "SELECT team.invitee, users.fullname, users.phone 
                    FROM team 
                    INNER JOIN users ON team.invitee = users.email
                    WHERE inviter = ?";
            $inviter_email = $main_inviter;
            // echo $inviter_email;

            $stmt = $db->prepare($sql);
            $result = $stmt->execute([$inviter_email]);
            // echo $stmt->rowCount();

            if($stmt->rowCount() > 0){
              $count = 1;
                while($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                  $count = $count + 1;
                  if($row["invitee"] == $_SESSION["user_email"]){
                    continue;
                  }
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
                echo $count;
              }    

        }else{
            echo "no records";
        }
  
}

// if invitee already exists in a row it should display already part of a team





// if invitee exist display inviter and then display all other invitees of that inviter