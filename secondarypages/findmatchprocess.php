<?php
require_once("config.php");
?>

<?php

if (isset($_POST['sort']) && $_POST['sort'] == 'names') {
    $sql = "SELECT * FROM turfs ORDER BY name ASC";
  } else {
    $sql = "SELECT * FROM turfs";
  }

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
            <div class='turf-sports'>
                <!-- selection button -->
                <a href='billingpage.php'>
                <button class='selection' >Select</button>
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