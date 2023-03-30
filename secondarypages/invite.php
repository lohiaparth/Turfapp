<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="invite.css">
    <script src="https://use.fontawesome.com/7fe15ee35c.js"></script>
    
    <title>INVITE</title>
</head>
<body>
<header>
   <a class="logo" href="/"><img src="images/logo.svg" alt="logo"></a>
      <nav>
         <ul class="nav__links">
            <li><a href="/Turfapp/Siddhi/Home.html">Home</a></li>
            <li><a href="#">About</a></li>
           <li><a href="/Turfapp/Siddhi/Review.html">Review</a></li>
         </ul>
      </nav>
</header>
    <div class="sort-row1">
        <h1 class="h1-invite">INVITE</h1>
        <h5 class="h5-invite">Invite your team members</h5>
        <div class="wrap">
            <div class="search">
                <input type="text" class="searchTerm" id="invitee" placeholder="Enter email of the person you want to invite">
                <button type="submit" id="submit" class="searchButton">
                    <i class="fa fa-search"></i>
                </button>
                
                
            </div>
        </div>

    </div>
    <div><center>
        <h1 class="h1-request">REQUESTS</h1>
        <h5 class="h5-request">You have your friends Request</h5>
    </center></div>
    <div class="sort-row2">
        <!-- <table style='border:solid 2px;'>
        <tr>
            <td>siddhi@gmail.com</td>
            <td>accept</td>
            <td>reject</td>
        </tr>
        
        </table> -->
        <div class="invite-class">
        <div class="invite">
            <div class="invite-ele"><h3>siddhidmahajan@gmail.com</h3></div>
            <div class="invite-accept"><button>Accept</button></div>
            <div class="invite-reject"><button>Reject</button></div>
        </div>
        </div>
        </div>
        <?php
        require_once('inviteprocess2.php');
        ?>
    </div>


	
	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
                <script>
                    $(function(){
                        $('#submit').click(function(e){
                            if($('#invitee').val() != ""){
                                var invitee = $('#invitee').val();

                                e.preventDefault();

                                $.ajax({
                                    type: 'POST',
                                    url: 'inviteprocess.php',
                                    data:{
                                        invitee: invitee
                                    },
                                    success : function(data){
                                        alert(data);
                                    },
                                    error : function(data){
                                        alert(data);
                                    }
                                })
                            }
                        })
                    })

                </script>


</body>
</html>