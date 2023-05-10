<?php
require_once('config.php');




?> 




<?php  


if(isset($_POST)){
        

    
   //print_r($_POST);
    $name       = $_POST['name'];
    echo $name;
    $email      = $_POST['email'];
    echo $email;

    echo $email;
    $contact1   = $_POST['contact1'];
    echo $contact1;
    $contact2   = $_POST['contact2'];
    echo $contact2;
    $address    = $_POST['address'];
    echo $address;
    $sport      = $_POST['sport'];
    echo $sport;
    $sportstring = implode(',',$sport);
    echo $sportstring;
    $images     = $_POST['images'];
    // echo $images;

    // $base64_image = base64_encode(file_get_contents($image));

    // echo $base64_image;


    // if(move_uploaded_file($images, 'temp') ===  true){
    //     $getimg = base64_encode(file_get_contents('temp'));
    //     $insert = "INSERT INTO tablename(images) VALUES('$getimg')";
        
    // }
    

$sql = "INSERT INTO turfs (name, email, contact1, contact2, address, sport, images) VALUES(?,?,?,?,?,?,?)";
$stmtinsert = $db->prepare($sql);
$result = $stmtinsert->execute([$name, $email, $contact1, $contact2, $address, $sportstring, $images ]);
echo $result;

}

    


//     // // $sql = "INSERT INTO turfs (name, email, contact1, contact2, address, sport ) VALUES(?,?,?,?,?,?)";
//     // $stmtinsert = $db->prepare($sql);

//     // $result = $stmtinsert->execute([$name, $email, $contact1, $contact2, $address, $sport]);

    if($result){
        echo 'Successfully saved!';

    }else{
        echo 'There were errors while saving the data.';
    }
    
    
// }else{
//     echo 'NO DATA';
// } 
?>