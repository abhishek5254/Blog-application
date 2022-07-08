<%@page import="com.blog.entities.User"%>
<%@page import="com.blog.dao.likeDao"%>
<%@page import="com.blog.entities.Category"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="com.blog.entities.Post"%>
<%@page import="com.blog.dao.PostDao"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
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
        <style>
            .banner-background
            {
                
                clip-path: polygon(0% 0%, 100% 0%, 100% 94%, 75% 94%, 75% 100%, 50% 94%, 0 94%);
            }
        </style>
        <title>

            Blog | Read, Write, Explore</title>
    </head>
    <body>
        <%@include file="navbar.jsp" %>

        <div class="container-fluid p-0 m-0">
            <div class="jumbotron primary-background text-white banner-background " style="min-height: 400px;">
                <div class="container p-5 ">
                    <h3 class="display-5">Welcome to AbhiBlog</h3>
                    <p>Programming is the process of creating a set of instructions that tell a computer how to perform a task. 
                        Programming can be done using a variety of computer programming languages, such as JavaScript, Python, and C++.</p>
                    <p>Programming is the process of creating a set of instructions that tell a computer how to perform a task. 
                        Programming can be done using a variety of computer programming languages, such as JavaScript, Python, and C++.</p>
                    <a class="btn btn-outline-light btn-md" href="register.jsp"><span class="fa fa-user-plus">&nbsp;</span>Start ! its Free</a>
                    <a  href="login.jsp" class="btn btn-outline-light btn-md"><span class="fa fa-user-circle fa-spin">&nbsp;</span>Login</a>
                </div>
            </div>

        </div>
        <!-- cards -->

        <div class="container-fluid mt-5 ">
            <div class="row">
                <div class="col-md-2  text-center" style="min-height: 500px;margin-left: 20px;">
                    <h3 style="font-weight: 600; color:#945ae7;" >Blog Topics </h3>
                    <div class="col-md-2 mt-2" >
                        <!-- categories  -->
                        <div class="list-group" style="width:200px;padding: 5px;" >


                            <%
                                PostDao d = new PostDao(ConnectionProvider.getConnection());
                                ArrayList<Category> list1 = d.getAllCategories();

                                for (Category cc : list1) {
                            %>
                            <a onclick="myFunction()" class="c-link list-group-item list-group-item-action" style="font-weight: 500;cursor: pointer;"><%= cc.getName()%></a>

                            <% } %>


                        </div>

                    </div>
                </div>
                <div class="col-md-9   text-center" style="box-shadow: 5px 5px 5px #945ae7 ;min-height: 500px;margin-left:40px;">
                    <h1 class="mt-2" style="font-weight: 600; color:#945ae7;" >Blogs</h1>
                    <div class="row">
                        <%
                            //Thread.sleep(1000);
                            int start = 0, end = 6;
                            int total = 0;
                            int i = 0;
                            int pgno = request.getParameter("pgno") == null ? 0 : Integer.parseInt(request.getParameter("pgno"));
                            start = pgno * end;
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            // creating connection

                            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/blogwithabhi", "root", "abhi123");

                            //List<Post> posts = null;
                            String posts = "select * from posts limit ?,?";
                            PreparedStatement smt = con.prepareStatement(posts);
                            smt.setInt(1, start);
                            smt.setInt(2, end);
                            ResultSet p = smt.executeQuery();
                            while (p.next()) {

                        %>
                        <div class="col-md-4 " style="margin-bottom: 20px;">
                            <div class="card m-2 ">
                                <img src="blog_pics/<%= p.getString("ppic")%>" class="card-img-top" alt="..." style="height:150px;width: 100%;">
                                <div class="card-body " style=" display: block;
                                     white-space: nowrap;
                                     width: 100%;
                                     overflow: hidden;
                                     text-overflow: ellipsis;">
                                    <b><%= p.getString("ptitile")%></b>
                                    <p><%= p.getString("pdate")%></p>

                                </div>
                                <!--read more option enabling-->
                                <div class="card-footer primary-background text-center">

                                    <a onclick="myFunction()" class="btn btn-outline-light btn-small" >Read More...</a>



                                    <!--                                    <a href="#!"></a>-->
                                </div>
                                <!--read more option enabling-->

                            </div>
                        </div>

                        <%

                            }
                            String totalPosts = "select count(*) from posts";
                            PreparedStatement smt2 = con.prepareStatement(totalPosts);
                            ResultSet rs = smt2.executeQuery();

                            if (rs.next()) {
                                total = rs.getInt(1);
                            }

                        %>

                        <nav aria-label="Page navigation example" class="mt-5">
                            <ul class="pagination" >
                               
                                <li class="page-item activelist"    >
                                    <%for (i = 0; i < total / end; i++) {%>
                                    <a href="index.jsp?pgno=<%= i%>" class="page-link activepage" style="display:inline-block;"> <%=i + 1%></a>
                                    <% }%>
                                </li>
                                


                            </ul>
                        </nav>
                    </div>

                </div>


            </div>
        </div>

        <footer>
            <div class="footer">
                <span>Created By <a href="#"> Abhishek Upadhyay</a> | <span class="fa fa-copyright"></span> 2022 All Rights Reserved. </span>
            </div>
        </footer>




        <!--   JavaScripts   --->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"  ></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" ></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" ></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"
        ></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
                                function myFunction() {
                                    swal({
                                        position: 'top-end',
                                        icon: 'warning',
                                        title: 'Login to read and add blogs..',
                                        showConfirmButton: false,
                                        timer: 5000
                                    })
                                }
        </script>
        <script>
            $(window).on('unload', function() {
                $(window).scrollTop(0);
            });

            window.onunload = function() {
                window.scrollTo(0, 0);
            }

            if ('scrollRestoration' in history) {
                history.scrollRestoration = 'manual';
            }
        </script>
        <script>
            $(window).on('unload', function() {
                $(window).scrollTop(0);
            });

            window.onunload = function() {
                window.scrollTo(0, 0);
            }

            if ('scrollRestoration' in history) {
                history.scrollRestoration = 'manual';
            }
        </script>
    </body>
</html>
