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
            location.href="gongji_view.jsp?id=" +  $("#id").val();
        });
    </script>
</head>
<body>
    <%
        request.setCharacterEncoding("utf-8");
        
        Integer postid =  Integer.parseInt(request.getParameter("postid"));
        String co_user = request.getParameter("comments_user");
        String co_content = request.getParameter("comments_content");
       
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.76:3306/kopo37",                  
                        "root" , "kopoctc");
        Statement stmt = conn.createStatement();
        stmt.execute("update gongji set viewCnt = viewCnt-1 where id=" + postid + ";");
        stmt.execute("insert into comments(postid, user, content, date) values(" + 
        postid + ", '" + co_user + "', '" + co_content + "', (select now()));");

        stmt.close();
        conn.close();
    %>
    <input type="hidden" name="id" id="id" value="<%=postid%>">
</body>
</html>