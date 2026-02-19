<?php
require_once("config.php");
?>

<?php

if(isset($_POST['searchTerm'])){
    $keyword = $_POST['searchTerm'];
    $sql = "SELECT * FROM turfs WHERE name LIKE '%$keyword%' OR address LIKE '%$keyword%' OR sport LIKE '%$keyword%'";
} else{
    $sql = "SELECT * FROM turfs";
    // echo "Bye";
}

// if (isset($_POST['sort']) && $_POST['sort'] == 'names') {
//     $ordersql = " ORDER BY name ASC";
//     $sql = $sql.$ordersql;
//     echo $sql;
//   } 

$result = $db->query($sql);

// Check if there are any rows in the result
if ($result->rowCount() > 0) {
    // Output data of each row
    while($row = $result->fetch(PDO::FETCH_ASSOC)) {

        

        $imageData = base64_decode(substr($row["images"], strpos($row["images"], ",")+1));
        

        

        echo "<div class='turf-box'>
        <!-- <div class='img'>
            <img src='Bg4.webp' alt='' class='img_size'> turf image -->
        <!-- </div> -->
        <div class='turf-details'>
            <div class='img'>
                <img src='data:image/jpeg;base64,".base64_encode($imageData)."' alt='' class='img_size'> <!-- turf image -->
            </div> 
            <div class='turf-name'>
                <h2 class='h2-invite'>".$row["name"]."</h2>
            </div>
            <div class='turf-address'>
                <!-- turf address -->
                <h3 class='h3-invite'>".$row["address"]."</h3>
            </div>
            <div class='turf-contact'>
                <!-- turf contacts -->
                <h3 class='h3-invite'>".$row["contact1"]."</h3><h3 class='h3-invite'>".$row["contact2"]."</h3>
            </div>
            <div class='turf-sports'>
                <!-- turf sports -->
                <h4 class='h4-invite'>".$row["sport"]."</h4>
            </div>
            <div class='turf-sports-money'>
                <!-- turf sports -->
                <h4 class='h3-invite' style='font-weight:bold;'>₹2000</h4>
            </div>
            <div class='turf-sports'>
                <!-- selection button -->
                
                <button class='selection' id='selectButton'><a href='slots.php?turfname=".$row["name"]."'>Select</a></button>
                </a>
            </div>
        </div>
    </div>
    <br>";
    }
} else {
    echo "0 results";
}
?>