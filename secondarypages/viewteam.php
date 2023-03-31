<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="viewteam.css">
</head>
<body>
    <header>
            <!-- <a class="logo" href="/"><img src="images/logo.svg" alt="logo"></a> -->
            <nav>
                <ul class="nav__links">
                <li><a href="/Turfapp/Siddhi/Home.html">Home</a></li>
                <li><a href="/Turfapp/Siddhi/Home.html#about">About</a></li>
                <li><a href="/Turfapp/Siddhi/Home.html#review">Review</a></li>
                </ul>
            </nav>
            <!-- <a class="cta" href="/Turfapp/Siddhi/Review.html">Review</a> -->
        </header>
        <div class="view">
          <div class="left-view">
            <div class="about-view">
            <center><h1 class="h1-view">VIEW</h1></center>
            <center><h5 class="h5-view">See who is in your team</h5></center>
            </div>
          </div>
          <div class="right-view">
            <div class="view-text">
              
                <?php
                require_once('viewteamprocess.php');
                ?>
                <!-- <div>
                  <h2 class="view-name">SIDDHI</h2>
                </div>
                <div>
                  <h6 class="view-email">siddhidmahajan</h6>
                </div>
                <div>
                  <h6 class="view-numb">8668674185</h6>
                </div> -->
              <!-- </div> -->
            </div>
          </div>
        </div>
        <?php
        // require_once("viewteamprocess.php");
        ?>
</body>
</html>