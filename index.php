<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="Siddhi/HomeStyles.css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:500&display=swap" rel="stylesheet">
    <title>Document</title>
</head>
<body style="background-color: #030c1f;">
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

                <button  onclick="window.location.href='secondarypages/invite.php'">Invite Players</button>
                <button  onclick="window.location.href='secondarypages/viewteam.php'">View Team</button>
                <button  onclick="window.location.href='secondarypages/findmatch.php'">Find Match</button>
            </div>

        </div>
</body>
</html>