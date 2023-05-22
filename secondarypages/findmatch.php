<?php
require_once("config.php");
?>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link rel="stylesheet" href="findmatch.css">
    <script src="https://use.fontawesome.com/7fe15ee35c.js"></script>
    
    <title>Find Match</title>
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
    <div class="sort-row">
        <h1 class="h1-invite">FIND</h1>
        <h5 class="h5-invite">Find your Turf</h5>
        <div class="wrap">
            <div class="search">
                <input type="text" class="searchTerm" id="searchTerm" placeholder="What are you looking for?">
                <button type="submit" class="searchButton" id="searchButton">
                    <i class="fa fa-search"></i>
                </button>
                <button type="" class="searchButton" id="sortButton" style="margin-left: 4px; border-radius: 5px;">
                    <i class="fa fa-sort"></i>
                    
                </button>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
                <script>
                    $(document).ready(function(){
                        $('#searchButton').click(function(){
                            $.ajax({
                                url: 'findmatchprocess.php',
                                type: 'post',
                                data: { searchTerm: $('#searchTerm').val() },
                                success: function(response){
                                    // Replace the existing content of the turf-container div with the updated results
                                    $('#turf-container').html(response);

                                }

                            })
                        })
                    })
                </script>
                <script>
                    $(document).ready(function() {
                        $('#sortButton').click(function() {
                            $.ajax({
                                url: 'findmatchprocess.php',
                                type: 'post',
                                data: {sort: 'names'},
                                success: function(response) {
                                    // Replace the existing content of the turf-container div with the updated results
                                    $('#turf-container').html(response);
                                }
                            });
                        });
                    });
                </script>
            </div>
        </div>

    </div>

    <div id="turf-container">
        <?php
            require("findmatchprocess.php");
        ?>
    </div>
    <div class="turf-box">
        <!-- <div class="img">
            <img src="Bg4.webp" alt="" class="img_size"> turf image -->
        <!-- </div> -->
        <div class="turf-details">
            <div class="img">
                <img src="Bg4.webp" alt="" class="img_size"> <!-- turf image -->
            </div> 
            <div class="turf-name">
                <h2 class="h2-invite">Orlem lawn</h2>
            </div>
            <div class="turf-address">
                <!-- turf address -->
                <h3 class="h3-invite">Orlem, malad , mumbai</h3>
            </div>
            <div class="turf-contact">
                <!-- turf contacts -->
                <h3 class="h3-invite">9000001234</h3><h3 class="h3-invite">9000005678</h3>
            </div>
            <div class="turf-sports">
                <!-- turf sports -->
                <h4 class="h4-invite">basketball & football</h4>
            </div>
            <div class="turf-sports-money">
                <!-- turf sports -->
                <h4 class="h3-invite" style="font-weight:bold;">₹2000</h4>
            </div>
            <div class="turf-sports">
                <!-- selection button -->
                <button class="selection">Select</button>
            </div>
        </div>
    </div>

    
</body>
</html>