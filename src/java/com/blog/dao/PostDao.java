/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.blog.dao;

/**
 *
 * @author DELL
 */
import com.blog.entities.Category;
import com.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class PostDao {
    
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    
    public ArrayList<Category> getAllCategories()
    {
        ArrayList<Category> list= new ArrayList<>();
        try{
            
            String q="select * from categories";
            
            Statement st=this.con.createStatement();
            ResultSet set=st.executeQuery(q);
            
            while(set.next())
            {
                int cid=set.getInt("cid");
                String name=set.getString("name");
                String description=set.getString("description");
                
                Category c=new Category(cid,name,description);
                
                list.add(c);
                
                
            }
            
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
            
        
        
        return list;
    }
    
    public boolean savePost(Post p)
    {
       boolean f=false;
       
       try
       {
           String q="insert into posts(ptitile,pcontent,pcode,ppic,catid,userid) values(?,?,?,?,?,?)";
           PreparedStatement pstmt=con.prepareStatement(q);
           
           pstmt.setString(1,p.getPtitle());
           pstmt.setString(2,p.getPcontent());
           pstmt.setString(3,p.getPcode());
           pstmt.setString(4, p.getPpic());
           pstmt.setInt(5,p.getCatid());
           pstmt.setInt(6,p.getUserid());
           
           pstmt.executeUpdate();
           f=true;
           
       }
       catch(Exception e)
       {
           e.printStackTrace();
       }
       
       
       
       return f;
    }
    
    
    // get all posts
    public List<Post> getAllPosts()
    {
        
        List<Post> list=new ArrayList<>();
        // fetching all posts
        try{
            PreparedStatement p= con.prepareStatement("select * from posts order by pid desc");
            
            ResultSet set=p.executeQuery();
            
            while(set.next())
            {
                int pid=set.getInt("pid");
                String pTitle=set.getString("ptitile");
                String pContent=set.getString("pcontent");
                String pCode= set.getString("pcode");
                String pPic=set.getString("ppic");
                Timestamp date=set.getTimestamp("pdate");
                int catId=set.getInt("catid");
                int userId=set.getInt("userid");
                
                Post post=new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
                
                list.add(post );
                
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        return list;
        
    }
    
    public List<Post> getPostByCatId(int catid)
    {
         List<Post> list=new ArrayList<>();
        // fetching all posts by Category
         
         try{
            PreparedStatement p= con.prepareStatement("select * from posts where catid=?");
            p.setInt(1, catid);
            
            ResultSet set=p.executeQuery();
            
            while(set.next())
            {
                int pid=set.getInt("pid");
                String pTitle=set.getString("ptitile");
                String pContent=set.getString("pcontent");
                String pCode= set.getString("pcode");
                String pPic=set.getString("ppic");
                Timestamp date=set.getTimestamp("pdate");
               // int catId=set.getInt("catid");
                int userId=set.getInt("userid");
                
                Post post=new Post(pid, pTitle, pContent, pCode, pPic, date, catid, userId);
                
                list.add(post );
                
            }
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        
        return list;
    }
    
    public Post getPostByPostId(int postId)
    {
        Post post=null;
        String q="select * from posts where pid=?";
        try{
        PreparedStatement p=this.con.prepareStatement(q);
        
        p.setInt(1, postId);
        
        ResultSet set=p.executeQuery();
        
        if(set.next())
        {
            int pid=set.getInt("pid");
                String pTitle=set.getString("ptitile");
                String pContent=set.getString("pcontent");
                String pCode= set.getString("pcode");
                String pPic=set.getString("ppic");
                Timestamp date=set.getTimestamp("pdate");
                int catId=set.getInt("catid");
                int userId=set.getInt("userid");
                
                post=new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userId);
           
            
        }
        }
        catch(Exception e)
        {
            e.printStackTrace(); 
        }
        
        return post;
    }
}
