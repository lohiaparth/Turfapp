<?php

require_once('config.php');

require_once('jslogin.php')

?>
<?php

$sql = "SELECT * FROM invites WHERE invitee = ?";
    $email = $_SESSION['user_email'];
    $stmt = $db->prepare($sql);

    $result = $stmt->execute([$email]);

    // process result set
    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
        echo "<table style='border:solid 2px;'>
        <tr>
            <td>".$row["inviter"]."</td>
            <td>accept</td>
            <td>reject</td>
        </tr>
        
        </table>";
    }