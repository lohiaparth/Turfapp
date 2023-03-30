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
                    <li><a href="/Turfapp/Turfside/addturf.php">List Turf</a></li>
                    <li><a href="">About</a></li>
                </ul>
            </nav>
            <!-- <a class="cta" href="/Turfapp/Siddhi/Review.html">Review</a> -->
        </header>
    <div class="sort-row1">

        <div class="wrap">
            <div class="search">
                <input type="text" class="searchTerm" id="invitee" placeholder="Enter email of the person you want to invite">
                <button type="submit" id="submit" class="searchButton">
                    <i class="fa fa-search"></i>
                </button>
                
                
            </div>
        </div>

    </div>

    <div class="sort-row2">
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