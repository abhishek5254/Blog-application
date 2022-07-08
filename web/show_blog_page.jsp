<%-- 
    Document   : show_blog_page
    Created on : 19 Feb, 2022, 3:02:36 PM
    Author     : DELL
--%>
<%@page import="com.blog.dao.likeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.blog.dao.UserDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.blog.entities.Category"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="com.blog.entities.Post"%>
<%@page import="com.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%
    User user = (User) session.getAttribute("currentuser");

    if (user == null) {
        response.sendRedirect("login.jsp");
    }
%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao d = new PostDao(ConnectionProvider.getConnection());

    Post p = d.getPostByPostId(postId);

%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">



        <link href="css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <meta name="viewport" content="width=500, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=0.86, maximum-scale=5.0, minimum-scale=0.86">
        <meta name="viewport" content="initial-scale=1, maximum-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .post-title{
                font-weight: 100;
                font-size: 29px;
            }
            .post-content
            {
                font-weight: 100;
                font-size: 25px;
            }
            .post-date{
                font-style: italic;
                font-weight: bold;
            }
            .post-user a{
                font-size: 18px;
                text-decoration: none;
            }
            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }

            body{
               
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
</head>
<body>

    <div id="fb-root"></div>
    <script async defer
    src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v13.0" ></script>



    <!-- <div id="fb-root"></div>
     <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v13.0" nonce="Fyexhn9M"></script> -->


    <!--- navbar  -->
    <nav class="navbar navbar-expand-lg navbar-dark primary-background">
        <div class="container-fluid">
            
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" href="profile.jsp" style="font-size: 19px;font-weight: 600;">Home</a>
                    </li>
                    
                    <li class="nav-item">
                        <a class="nav-link active" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal" style="font-size: 18px;" >Add Your Blog</a>
                    </li>




                </ul>
                <ul class="navbar-nav mr-right">
                    <li class="nav-item">
                        <a class="nav-link" href="#!" data-bs-toggle="modal" data-bs-target="#profile_modal">
                            <span class="fa fa-user"  style="font-size: 18px;margin-top: 5px;"><%= user.getName()%></span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet" style="font-size: 18px;">Logout</a>
                    </li>

                </ul>
            </div>
        </div>
    </nav>

    <!-- end of navbar  -->

    <!-- main content of body to show post details-->

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-8 offset-md-2">

                <div class="card p-5">
                    <div class="card-header primary-background text-white">

                        <h4 class="post-title"><%= p.getPtitle()%></h4>


                    </div>
                    <div class="card-body">
                        <img src="blog_pics/<%= p.getPpic()%>" class="card-img-top" alt="..." style="height:250px;width: 100%;">

                        <div class="row my-3 row-user">
                            <div class="col-md-8">
                                <%
                                    UserDao ud = new UserDao(ConnectionProvider.getConnection());
                                %>
                                <p class="post-user"><a href="#"><%= ud.getUserByUserId(p.getUserid()).getName()%> </a> has posted</p>
                            </div>
                            <div class="col-md-4">
                                <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getPdate())%></p>
                            </div>
                        </div>

                        <p class=" post-content mt-4">  <%= p.getPcontent()%></p>

                        <br/>
                        <br/>
                        <div class="post-code">
                            <pre>
                                <%= p.getPcode()%>
                            </pre>
                        </div>
                    </div>
                    <div class="card-footer primary-background">

                        <%
                            likeDao ld = new likeDao(ConnectionProvider.getConnection());

                        %>

                        <a href="#!" onclick="doLike(<%= p.getPid()%>,<%=user.getId()%>)" class="btn btn-outline-light btn-small" ><i class="fa fa-thumbs-o-up"><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></i></a>

                        <a href="#!" class="btn btn-outline-light btn-small" ><i class="fa fa-commenting-o"><span>20</span></i></a>
                    </div>

                        <div class="card-footer">
                            <div class="fb-comments" 
                                 data-href="http://localhost:8044/BlogwithAbhi/show_blog_page.jsp?post_id=4<%= p.getPid() %>" 
                                 data-width="" data-numposts="10"></div>
                        </div>

                </div>
            </div>
        </div>
    </div>


    <!-- end of  main content of body to show post details-->





    <!-- Modal -->
    <div class="modal fade" id="profile_modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header primary-background text-white ">
                    <h5 class="modal-title" id="exampleModalLabel">Profile</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <img src="profile/<%=user.getProfile()%>" class="image-fluid" style="max-width: 200px;"/>
                        <h5 class="modal-title" id="exampleModalLabel">
                            <%= user.getName()%>

                        </h5>
                        <div id="profile-details">
                            <table class="table table-bordered">

                                <tbody>
                                    <tr>
                                        <th scope="row">ID :</th>
                                        <td><%=user.getId()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Email :</th>
                                        <td><%=user.getEmail()%></td>

                                    </tr>
                                    <tr>
                                        <th scope="row">Gender :</th>
                                        <td><%= user.getGender()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Status :</th>
                                        <td><%= user.getAbout()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Registered on :</th>
                                        <td><%= user.getDateTime().toString()%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!-- Profile edit  -->

                        <div id="profile-edit" style="display: none;">
                            <h2 class="mt-2">Edit Carefully</h2>
                            <form action="EditServlet" method="post" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID :</td>
                                        <td><%=user.getId()%></td>                                                   
                                    </tr>
                                    <tr>
                                        <td>Email :</td>
                                        <td><input type="email" class="form-control" name="user_email" value="<%=user.getEmail()%>" /></td>                                                   
                                    </tr>
                                    <tr>
                                        <td>Name :</td>
                                        <td><input type="text" class="form-control" name="user_name" value="<%=user.getName()%>" /></td>                                                   
                                    </tr>
                                    <tr>
                                        <td>Password :</td>
                                        <td><input type="password" class="form-control" name="user_password" value="<%=user.getPassword()%>" /></td>                                                   
                                    </tr>
                                    <tr>
                                        <td>Gender :</td>
                                        <td><%=user.getGender().toUpperCase()%></td>                                                   
                                    </tr>
                                    <tr>
                                        <td>About :</td>
                                        <td>
                                            <textarea class="form-control" name="user_about" rows="3">
                                                <%=user.getAbout()%>
                                            </textarea>
                                        </td>                                                   
                                    </tr>
                                    <tr>
                                        <td>Profile  pic:</td>
                                        <td><input type="file" class="form-control" name="image" /></td>                                                   
                                    </tr>
                                </table>
                                <div class="container">
                                    <button type="submit" class="btn btn-outline-success">Save</button>
                                </div>
                            </form>


                        </div>


                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button id="edit-profile-button" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>

    <!-- End of profile Modal -->

    <!-- add post modal-->



    <!-- Modal -->
    <div class="modal fade" id="add-post-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Add Post Details</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">


                    <form id="add-post-form" action="AddPostServlet" method="post" enctype="multipart/form-data">

                        <div class="form-group">
                            <select class="form-control" name="cid">
                                <option selected disabled>--- Select Category ---</option>
                                <%
                                    PostDao postd = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = postd.getAllCategories();

                                    for (Category c : list) {


                                %>
                                <option value="<%= c.getCid()%>"><%= c.getName()%></option>


                                <% }%>
                            </select>
                        </div>
                        <div class="form-group mt-2">
                            <label>Title</label>
                            <br/>
                            <input name="ptitle" type="text" class="form-control" placeholder="Enter post title" />
                        </div>
                        <div class="form-group mt-2">
                            <label>Content</label>
                            <br/>
                            <textarea name="pcontent" class="form-control" placeholder="Enter Your content" rows="3"></textarea>
                        </div>
                        <div class="form-group mt-2">
                            <label>Code</label>
                            <br/>
                            <textarea name="pcode" class="form-control" placeholder="Enter Your Code (If any)" rows="3"></textarea>
                        </div>
                        <div class="form-group mt-2">
                            <label>Select Your Picture</label>
                            <br/>
                            <input type="file" name="pic"/>
                        </div>
                        <div class="container mt-2 text-center">
                            <button type="submit" class="btn btn-outline-primary">Post</button>
                        </div>
                    </form>


                </div>

            </div>
        </div>
    </div>



    <!--   JavaScripts   --->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
    crossorigin="anonymous"></script>

    <script>
                                    $(document).ready(function() {
                            let editStatus = false;
                                    $('#edit-profile-button').click(function() {
                            //               alert("button-clicked")
                            if (editStatus == false)
                            {
                            $("#profile-details").hide()

                                    $("#profile-edit").show();
                                    editStatus = true;
                                    $(this).text("Back");
                            }
                            else
                            {
                            $("#profile-details").show()

                                    $("#profile-edit").hide();
                                    editStatus = false;
                                    $(this).text("Edit");
                            }
                            })

                            });</script>

    <!-- Add post js  -->

    <script>

                $(document).ready(function(e){

        $("#add-post-form").on("submit", function(event){

        // function gets called when form is submitted
        event.preventDefault();
                console.log("You have clicked on submit")
                let form = new FormData(this);
                // requesting to server

                $.ajax({
                url: "AddPostServlet",
                        type: 'POST',
                        data: form,
                        success: function (data, textStatus, jqXHR) {
                        //success
                        //console.log(data);
                        if (data.trim() == 'saved')
                        {
                        swal("Error", "Something went wrong, try again", "error");
                        }
                        else
                        {
                        swal("Good job!", "Saved Successfully", "success");
                        }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                        //errorr
                        swal("Good job!", "Saved Successfully", "success");
                        },
                        processData: false,
                        contentType: false
                })

        })

        })
    </script>

    <script src="js/myjs.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"
            integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
    crossorigin="anonymous"></script>

</body>
</html>
