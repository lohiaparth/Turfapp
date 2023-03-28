<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Turf</title>
    <meta name="viewport" content="width=device-width, initial-scale=1"><link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/css/bootstrap.min.css'>
    <link rel="stylesheet" href="addturf.css">

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
   <div class="container">
      <div class="row">
         <section id="formHolder">

            <!-- Brand Box -->
            <div class="col-sm-6 brand">
               <a href="#" class="logo">Welcome.<span></span></a>

               <div class="heading">
                  <h2>Turf</h2>
                  <p>Find your turf</p>
               </div>

               <div class="success-msg">
                  <p>Great! You are one of our members now</p>
                  <a href="#" class="profile">Your Profile</a>
               </div>
            </div>

            <div class="col-sm-6 form">

               <div class="signup form-peice">
                  <form class="signup-form" action="#" method="post" enctype="multipart/form-data">
                    
                     <div class="form-group">
                        <!-- Name of Turf -->
                        <label for="name">Name</label>
                        <input type="text" id="name" name="name" class="name" required>
                        <span class="error"></span>
                        <!-- Name of Turf -->
                     </div>

                     <div class="form-group">
                        <!-- E-mail -->
                        <label for="email">E-mail</label>
                        <input type="email" name="email" id="email" class="email" required>
                        <span class="error"></span>
                        <!-- E-mail -->
                     </div>

                     <!-- Contact details -->
                     <div class="form-group">
                        <label for="contact1">Primary Contact</label>
                        <input type="text" name="contact1" id="contact1" class="contact1" required>
                        <span class="error"></span>
                     </div>

                     <div class="form-group">
                        <label for="contact2">Secondary Contact</label>
                        <input type="text" name="contact2" id="contact2" class="contact2" >
                        <span class="error"></span>
                     </div>
                     <!-- Contact details -->

                     <div class="form-group">
                        <!-- Address -->
                        <label for="address">Address</label>
                        <input type="text" id="address" name="address" class="address" required>
                        <span class="error"></span>
                        <!-- Address -->
                     </div>

                     <!-- Sports -->
                     <div class="form-group">
                        <label for="sport">Select a sport:</label>
                     </div>  
                              <select id="sport" name="sport" class="sport" multiple required style="margin-left: 145px;">
                                 <option value="football">Football</option>
                                 <option value="basketball">Basketball</option>
                                 <option value="cricket">Cricket</option>
                              </select>
                         
                     
                     <!-- Sports -->

                     <!-- Images -->
                     <div class="form-group"></div>
                        <label for="images">Images: </label>
                        <input type="file" accept="image/*" id="images" name="images" class="images" style="margin-left: 100px; border:none; " >
                     </div>
                     <!-- Images -->

                     
                     <!-- Submit -->
                     <input type="submit" value="List Turf" id="submit" name="create">
                     <!-- Submit -->
                    


                  </form>
               </div>

            </div>

         </section>
      </div>   
    </div>
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
            var images      = $('#images').prop('files')[0];

            e.preventDefault();

            var reader = new FileReader();
            reader.readAsDataURL(images);
            reader.onload = function () {
                var base64Image = reader.result;

                $.ajax({
                    type : 'POST',
                    url : 'addturfprocess.php',
                    data : {
                        name: name,
                        email: email,
                        contact1: contact1,
                        contact2: contact2,
                        address: address,
                        sport: sport,
                        images: base64Image
                    },
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
            };
        }else{
            alert('false');
        }
    });
});

            </script>

   <script src='https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/3.3.7/js/bootstrap.min.js'></script>
   <script src='https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.0/jquery.min.js'></script>
   <script  src="./addturf.js"></script>
    
</body>
</html>