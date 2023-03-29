<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="Siddhi/HomeStyles.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:500&display=swap" rel="stylesheet">
    <title>HOME</title>
</head>
<body style="background-color: #0c2605;">
        <header>
            <a class="logo" href="/"><img src="images/logo.svg" alt="logo"></a>
            <nav>
                <ul class="nav__links">
                    <li><a href="#">Services</a></li>
                    <li><a href="#">Projects</a></li>
                    <li><a href="#">About</a></li>
                </ul>
            </nav>
            <a class="cta" onclick="window.location.href='Siddhi/Home.html'">Log Out</a>
        </header>

        <script src="slider-script.js"></script>

        <div class="row">
            <div class="slider">
                <div id="img" class="fade-in">
                    <img  src="football-slider.jpeg"/>
                </div>
            </div>
        </div>




        <div class="row">
            <div class="page-buttons">
	            <div class="container">
	                <div class="column">
		                <p> This is first column of our grid system</p>
                        <button  onclick="window.location.href='secondarypages/invite.php'" class="invite-players">Invite Players</button>
	                </div>
	                
                    <div class="column">
		                <p> This is second column of our grid system</p>
                        <button  onclick="window.location.href='secondarypages/viewteam.php'" class="view-team">View Team</button>
	                </div>

	                <div class="column">
		                <p> This is third column of our grid system</p>
                        <button  onclick="window.location.href='secondarypages/findmatch.php'" class="find-match">Find Match</button>
                    </div>
	            </div>      
            </div>
        </div>
</body>
</html>