<?php
require_once("config.php");
?>

<?php

$sql = "SELECT * FROM turfs";

$result = $db->query($sql);

// Check if there are any rows in the result
if ($result->rowCount() > 0) {
    // Output data of each row
    while($row = $result->fetch(PDO::FETCH_ASSOC)) {
        echo "<div class='turf-box'>
        <!-- <div class='img'>
            <img src='Bg4.webp' alt='' class='img_size'> turf image -->
        <!-- </div> -->
        <div class='turf-details'>
            <div class='img'>
                <img src='Bg4.webp' alt='' class='img_size'> <!-- turf image -->
            </div> 
            <div class='turf-name'>
                <h1>".$row["name"]."</h1>
            </div>
            <div class='turf-address'>
                <!-- turf address -->
                <h3>".$row["address"]."</h3>
            </div>
            <div class='turf-contact'>
                <!-- turf contacts -->
                <h3>".$row["contact1"]."</h3><h3>".$row["contact2"]."</h3>
            </div>
            <div class='turf-sports'>
                <!-- turf sports -->
                <h4>".$row["sport"]."</h4>
            </div>
        </div>
    </div>
    <br>";
    }
} else {
    echo "0 results";
}
?>