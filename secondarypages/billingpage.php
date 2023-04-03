<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="billing.css">
    <title>Document</title>
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
</header>
    
    <div class="sort-row1">
        <h1 class="h1-invite">BILLING</h1>
        <h5 class="h5-invite">Please pay your bill</h5>
        <div class="wrap">
            <div class="view-text">
                <?php
                require_once("billingpageprocess.php");
                ?>
                <!-- <div class="view-fri">
                    <div>
                  <h2 class="view-name">siddhidmahajan@gmail.com</h2>
                </div>
                <div>
                  <h6 class="view-numb">₹200</h6>
                </div>
            </div> -->
            <button class="total">payment</button>
            </div>
        </div>
    </div>


</body>
</html>