<%-- 
    Document   : login
    Created on : 24 Jan, 2022, 10:59:02 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta name="viewport" content="width=500, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=5.0, minimum-scale=0.86">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Register</title>
    </head>
    <body>
        <!-- navbar -->
        <%@include file="navbar.jsp" %>

    <main class="d-flex align-items-center p-5 " style="height: 100vh;margin-bottom: 20px;margin-top: 40px;">
        <div class="container">
            <div class="col-md-6 offset-md-3">
                <div class="card">
                    <div class="card-header text-center primary-background text-white" >
                        <span class="fa fa-2x fa-user-circle"></span>
                        <br/>
                        Register here
                    </div>
                    <div class="card-body">
                        <form action="RegisterServlet" method="post" id="reg-form">
                            <div class="mb-3">
                                <label for="user_name" class="form-label">User Name</label>
                                <input name="user_name" type="text" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Your name">
                                <div id="username" class="form-text">We'll never share your email with anyone else.</div>
                            </div>

                            <div class="mb-3">
                                <label for="exampleInputEmail1" class="form-label">Email address</label>
                                <input name="user_email" type="email" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" placeholder="Enter Your Email">
                                <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                            </div>

                            <div class="mb-3">
                                <label for="exampleInputPassword1" class="form-label">Password</label>
                                <input name="user_password" type="password" class="form-control" id="exampleInputPassword1" placeholder="Enter Your Password">
                            </div>


                            <div class="mb-3">
                                <label for="gender" class="form-label">Gender <b>:</b> &nbsp;</label>
                                <input type="radio"   aria-describedby="emailHelp" name="gender" value="male" >&nbsp;male&nbsp;
                                <input type="radio"   aria-describedby="emailHelp" name="gender" value="female" >&nbsp;female
                                <div id="emailHelp" class="form-text">We'll never share your email with anyone else.</div>
                            </div>

                            <div class="mb-3">
                                <label for="about" class="form-label">About&nbsp;</label>
                                <textarea name="about" class="form-control" placeholder="Enter About yourself"></textarea>
                            </div>

                            <div class="mb-3 form-check">
                                <input name="check" type="checkbox" class="form-check-input" id="exampleCheck1">
                                <label class="form-check-label" for="exampleCheck1">Terms and Conditions</label>
                            </div>

                            <button type="submit" class="btn btn-primary primary-background" id="submitbutton">Submit</button>
                            &nbsp; &nbsp; &nbsp;
                            <div class="container text-center" id="loader" style="display:none;">
                                <span class="fa fa-refresh fa-spin fa-x"></span>
                                <p>Please wait.....</p>
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>
    </main>



    <!--   JavaScripts   --->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
    crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js" integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA==" 
    crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script>
                $(document).ready(function() {
        console.log("loaded.....")

                $('#reg-form').on('submit', function(event)
        {
        event.preventDefault();
                let form = new FormData(this);
                $("#submitbutton").hide();
                $("#loader").show();
                // send to register servlet


                $.ajax({
                url: "RegisterServlet",
                        type: 'POST',
                        data: form,
                        success: function(data, textStatus, jqXHR) {
                        console.log(data);
                                $("#submitbutton").show();
                                $("#loader").hide();
                                if (data.trim() === 'done')
                                {
                                    swal("Registered!", "Thankyou for Registration, Redirecting to login page", "success")
                                            .then((value) => {
                                            window.location = "login.jsp"
                                            });
                                }
                                else
                                {
                                swal(data);
                                }
                        },
                        error: function(jqXHR, textStatus, errorThrown) {
                        $("#submitbutton").show();
                                $("#loader").hide();
                                swal("something went wrong .... Try again");
                        },
                        processData: false,
                        contentType: false

                });
        });
        });
    </script>
</body>
</html>
