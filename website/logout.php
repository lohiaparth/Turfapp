
<?php
session_start(); // Start the session

// Perform session cleanup
session_unset(); // Unset all session variables
session_destroy(); // Destroy the session

// Redirect the user to the login page or any desired page
header("Location: /Turfapp/Siddhi/Home.html");
exit();
?>