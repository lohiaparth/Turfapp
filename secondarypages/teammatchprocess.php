<?php

require_once('config.php'); 
    //For database connection

require_once('jslogin.php'); 
    //For Session variables


if(isset($_POST)){
    $date = $_POST['date'];
    
    $turfname = $_POST['turfname'];
    
    $time = $_POST['time'];
    

}

$email = $_SESSION['user_email'];



// require("slots.php";);





$sql = "SELECT * FROM matches 
        WHERE turf = ?
        AND date = ?
        AND slot = ?";
$stmtselect = $db->prepare($sql);
$result = $stmtselect->execute([$turfname,$date,$time]);


// CASE 1: INVITER1 IS WAITING FOR MATCH
if($stmtselect->rowCount() > 0){

    $row = $stmtselect->fetch(PDO::FETCH_ASSOC);
    $inviter1 = $row['inviter1'];

    if($inviter1 != $email){                                    //So that inviter is not matched with himself
    
    // echo "hello";
        $new_sql = "UPDATE matches
                    SET inviter2 = '$email'
                    WHERE turf = '$turfname'
                    AND date = '$date'
                    AND slot = '$time'";
        echo $new_sql;   

        $stmtselect = $db->prepare($new_sql);
        $result = $stmtselect->execute();
            
    }
    else{
        echo "match request already exists";
    }            
}
// CASE 2: NO TEAM HAS SELECTED THIS TURF BEFORE
else{
    // echo "bye";
    $new_sql = "INSERT INTO matches (turf,date,slot,inviter1) 
                VALUES (?,?,?,?)";
    echo $new_sql;

    $stmtselect = $db->prepare($new_sql);
    $result = $stmtselect->execute([$turfname,$date,$time,$email]); 
}

