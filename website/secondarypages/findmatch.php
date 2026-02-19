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
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <!-- <script>
        $(document).ready(function(){
            $.ajax({
                url: 'teammatchprocess.php',
                type: 'post',
                data: {turfName: }
            })
        })
    </script> -->

    

    
</body>
</html>