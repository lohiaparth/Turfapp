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
        echo "id: " . $row["id"]. " - Name: " . $row["name"]. " - Email: " . $row["email"]. "<br>";
    }
} else {
    echo "0 results";
}
?>