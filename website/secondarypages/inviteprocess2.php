<?php

require_once('config.php');
require_once('jslogin.php');

if (isset($_POST['delete'])) {
    $id = $_POST['id'];
    $sql = "DELETE FROM invites WHERE id = ?";
    $stmt = $db->prepare($sql);
    $stmt->execute([$id]);
}

if (isset($_POST['accept'])) {
    $inviter = $_POST['inviter'];
    $invitee = $_POST['invitee'];
    $sql = "INSERT INTO team (inviter, invitee) VALUES (?, ?)";
    $stmt = $db->prepare($sql);
    $stmt->execute([$inviter, $invitee]);
    // You may also want to delete the original invitation from the invites table
}

$sql = "SELECT * FROM invites WHERE invitee = ?";
$email = $_SESSION['user_email'];
$stmt = $db->prepare($sql);
$result = $stmt->execute([$email]);

// process result set
while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
    $inviter = $row["inviter"];
    $invitee = $row["invitee"];
    // Check if the invitation has been accepted already
    $sql2 = "SELECT COUNT(*) as count FROM team WHERE inviter = ? AND invitee = ?";
    $stmt2 = $db->prepare($sql2);
    $result2 = $stmt2->execute([$inviter, $invitee]);
    $count = $stmt2->fetch(PDO::FETCH_ASSOC)['count'];
    if ($count == 0) {
        // Invitation has not been accepted yet, display it
        echo "<div class='invite-class'>
        <div class='invite'>
            <div class='invite-ele'><h3>" .$inviter. "</h3></div>
            <div class='invite-accept'>
                <form method='POST'>
                    <input type='hidden' name='inviter' value='" . $inviter . "'>
                    <input type='hidden' name='invitee' value='" . $invitee . "'>
                    <button type='submit' name='accept' value='accept'>Accept</button>
                </form>
            </div>
            <div class='invite-reject'>
                <form method='POST'>
                    <input type='hidden' name='id' value='" . $row['id'] . "'>
                    <button type='submit' name='delete' value='delete'>Reject</button>
                </form>
            </div>
        </div>
    </div>";
    }
}

?>