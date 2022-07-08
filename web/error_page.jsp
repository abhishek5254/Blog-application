<%-- 
    Document   : error_page
    Created on : 28 Jan, 2022, 7:12:54 PM
    Author     : DELL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page isErrorPage="true"%>
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
        <title>S O R R Y</title>
    </head>
    <body>
        <div class="container text-center mt-5">
            
            <img src="image/error.png" alt="..." class="img-fluid" height="500" width="360"/>
            <h4 class="mt-1" style="font-family:Arial Rounded MT; color:red;">Oops, Something went wrong!..</h4> 
            <%= exception %>
            <a href="index.jsp" class="btn primary-background btn-lg text-white mt-3">Home</a>
        </div>
    </body>
</html>
