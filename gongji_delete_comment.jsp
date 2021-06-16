<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
        $(document).ready(function(){
            location.href="gongji_view.jsp?id=" +  $("#postid").val();
        });
        
    </script>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
        
        Integer commentId =  Integer.parseInt(request.getParameter("commentId"));
        Integer postid =  Integer.parseInt(request.getParameter("postid"));

        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.76:3306/kopo37",                  
                        "root" , "kopoctc");
        Statement stmt = conn.createStatement();
        stmt.execute("update gongji set viewCnt = viewCnt-1 where id=" + postid + ";");
        stmt.execute("delete from comments where id=" + commentId + ";");

        out.println("<input type='hidden' name='postid' id='postid' value='" + postid + "'>");
        stmt.close();
        conn.close();
    %>
</body>
</html>