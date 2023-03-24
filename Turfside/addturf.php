<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Turf</title>
    <link rel="stylesheet" href="/Turfapp/Siddhi/HomeStyles.css">

</head>
<body>
    <form action="#" method="post" enctype="multipart/form-data">
        <!-- Name of Turf -->
        <label for="name">Name</label>
        <input type="text" id="name" name="name" class="name" required>
        <!-- Name of Turf -->

        <!-- E-mail -->
        <label for="email">E-mail</label>
        <input type="email" name="email" id="email" class="email" required>
        <!-- E-mail -->

        <!-- Contact details -->
        <label for="contact1">Primary Contact</label>
        <input type="text" name="contact1" id="contact1" class="contact1" >
        <label for="contact2">Secondary Contact</label>
        <input type="text" name="contact2" id="contact2" class="contact2" >
        <!-- Contact details -->

        <!-- Address -->
        <label for="address">Address</label>
        <input type="text" id="address" name="address" class="address" >
        <!-- Address -->

        <!-- Sports -->
        <label for="sport">Select a sport:</label>
            <select id="sport" name="sport" class="sport" multiple>
                <option value="football">Football</option>
                <option value="basketball">Basketball</option>
                <option value="cricket">Cricket</option>
            </select>
        
        <!-- Sports -->

        <!-- Images -->
        <label for="images">Images: </label>
        <input type="file" accept="image/*" id="images" name="images" class="images" >
        <!-- Images -->

        <!-- Submit -->
        <input type="submit" value="List Turf" id="submit" name="create">
        <!-- Submit -->
        

    </form>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type= "text/javascript">
               $(function(){
                  $('#submit').click(function(e){
                     var valid = this.form.checkValidity();

                     if(valid){

                        var name        = $('#name').val();
                        var email       = $('#email').val();
                        var contact1    = $('#contact1').val();
                        var contact2    = $('#contact2').val();
                        var address     = $('#address').val();
                        var sport       = $('#sport').val();
                        console.log(sport);
                        var images      = $('#images').val();
                        

                        e.preventDefault();

                        $.ajax({
                           type : 'POST',
                           url : 'addturfprocess.php',
                           data : {name: name,email: email,contact1: contact1,contact2: contact2,address: address,sport: sport,images: images},

                           success : function(data){
                              Swal.fire({
                                 'title': 'Successful',
                                 'text': data,
                                 'icon':'success'
                              })
                              setTimeout(function(){
                                //  window.location.href = "/Turfapp/index.php"; //ADD REDIRECT ADDRESS
                              },2000);
                           },
                           error : function(data){
                              Swal.fire({
                                 'title': 'ERROR',
                                 'text': 'There were errors while saving the data.',
                                 'icon':'error'

                              })
                           }
                        });

                        alert('true');   
                     }else{
                        alert('false');
                     }
                  });
               });





            </script>
    
</body>
</html>