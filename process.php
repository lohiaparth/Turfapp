<?php
require_once('config.php');


?> 

 <?php

if(isset($_POST)){

        

    
        
    $fullname      = $_POST['fullname'];
    $email       = $_POST['email'];
    $phone          = $_POST['phone'];
    $aadhar    = $_POST['aadhar'];
    $password       = $_POST['password'];

    


    $sql = "INSERT INTO users (fullname, email, phone, aadhar, password ) VALUES(?,?,?,?,?)";
    $stmtinsert = $db->prepare($sql);

    $result = $stmtinsert->execute([$fullname, $email, $phone, $aadhar, $password]);

    if($result){
 

        echo 'Successfully saved!';

    }else{
        echo 'There were errors while saving the data.';
    }
    
    
}else{
    echo 'NO DATA';
} 
?>