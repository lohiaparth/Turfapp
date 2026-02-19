<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet" href="slots.css">
    <title>Document</title>
    <style></style>
</head>
<body>
    <header>
        <nav>
            <ul class="nav__links">
                <li><a href="/Turfapp/Siddhi/Home.html">Home</a></li>
                <li><a href="/Turfapp/Siddhi/Home.html#about">About</a></li>
                <li><a href="/Turfapp/Siddhi/Home.html#review">Review</a></li>
            </ul>
        </nav>
    </header>

    <div class="sort-row1">
        <h1 class="h1-invite">DATE AND TIME</h1>
        <h5 class="h5-invite">Please select a date and time</h5>
        <div class="wrap">
            <div class="view-text">
                <?php
                $turfname = $_GET['turfname'];
                echo $turfname;
                ?>
            <form action="#" method="post" id="selectForm">
                
                <input type="hidden" name="turfname" id="turfname" value="<?php echo $turfname; ?>">

                <input type="date" id="date" name="date">

                <label for="time">Choose a time slot:</label>

                <select name="time" id="time">
                    <option value="morning">Morning(6:00 am - 12:00 pm)</option>
                    <option value="afternoon">Afternoon(12:00 pm - 4:00 pm)</option>
                    <option value="evening">Evening(4:00 pm - 8:00 pm)</option>
                    <option value="night">Night(8:00 pm - 3:00 am)</option>
                </select>
                <input type="submit">
                
            </form>
            </div>
        </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script type="text/javascript">
        $(function() {
            $("#selectForm").submit(function(e) {
                e.preventDefault(); // Prevent the default form submission
                
                var date = $("#date").val();
                var time = $("#time").val();
                var turfname = $("#turfname").val();
                
                $.ajax({
                    type: 'POST',
                    url: 'teammatchprocess.php',
                    data: {
                        date: date,
                        time: time,
                        turfname: turfname
                    },
                    success: function(data) {
                        // Display the response in an alert
                        alert(data);
                        
                        // Log the response to the console
                        console.log(data);
                    }
                });
            });
        });
    </script>
</body>
</html>