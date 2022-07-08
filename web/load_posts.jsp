<%@page import="com.blog.entities.User"%>
<%@page import="com.blog.dao.likeDao"%>
<%@page import="com.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.blog.helper.ConnectionProvider"%>
<%@page import="com.blog.dao.PostDao"%>
<div class="row">
    <%
        //Thread.sleep(1000);

        User uuu = (User) session.getAttribute("currentuser");
        PostDao d = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));
        List<Post> posts = null;
        if (cid == 0) {

            posts = d.getAllPosts();
        } else {
            posts = d.getPostByCatId(cid);
        }
        if (posts.size() == 0) {
            out.println("<h6 text-center '>No posts related to this....You can Add your blog post by yourself, just go to add your blog section in menu bar, select category and add your blog.</h6>");
            return;
        }
        for (Post p : posts) {
    %>
    <div class="col-md-4 " style="margin-bottom: 20px;">
        <div class="card m-2 ">
            <img src="blog_pics/<%= p.getPpic()%>" class="card-img-top" alt="..." style="height:150px;width: 100%;">
            <div class="card-body " style=" display: block;
                 white-space: nowrap;
                 width: 100%;
                 overflow: hidden;
                 text-overflow: ellipsis;">
                <b><%= p.getPtitle()%></b>
                <p><%= p.getPcontent()%></p>
                


            </div>
            <div class="card-footer primary-background text-center">

                <%
                    likeDao ld = new likeDao(ConnectionProvider.getConnection());


                %>


                <a href="#!" onclick="doLike(<%= p.getPid()%>,<%=uuu.getId()%>)" class="btn btn-outline-light btn-small" ><i class="fa fa-thumbs-o-up"><span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></i></a>
                <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>" class="btn btn-outline-light btn-small" >Read More...</a>
                <a href="#!" class="btn btn-outline-light btn-small" ><i class="fa fa-commenting-o"><span>20</span></i></a>


                <a href="#!"></a>
            </div>
        </div>
    </div>

    <%
        }

    %>
</div>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js" integrity="sha384-7+zCNj/IqJ95wo16oMtfsKbZ9ccEh31eOz1HGyDuCQ6wgnyJNSYdrPa03rtR1zdB" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js" integrity="sha384-QJHtvGhmr9XOIpI6YVutG+2QOK9T+ZnN4kzFN1RtK3zEFEIsxhlmWl5/YESvpZ13" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
        integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
crossorigin="anonymous"></script>
<script src="js/myjs.js"></script>
