<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
    <link rel="stylesheet" href="./css/gongji_search.css">
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>Document</title>

    <script>
        function search() {
            let search_title = $("#search").val();
            if (search_title.replace(/\s/g,"").length == 0) {
                alert("검색 내용을 입력해주세요")
            } else {
                window.location="gongji_search.jsp?search_title=" + search_title + "";
            }
            
        }
    </script>
</head>
<body>

    <%
        request.setCharacterEncoding("utf-8");
        String title = request.getParameter("search_title");
        
        Class.forName("com.mysql.cj.jdbc.Driver"); 
        Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.76:3306/kopo37", "root" , "kopoctc");
        Statement stmt = conn.createStatement();

        ResultSet rset2 = stmt.executeQuery("select count(*) from gongji where title like '%" + title +"%';");
        Integer search_is = 0;
        
        while (rset2.next()) {
            search_is = rset2.getInt(1);
        }
        rset2.close();

        if (search_is == 0) {

    %>
    <div id="container">
        <div id="successImg">
            <i class="far fa-times-hexagon"></i>
        </div>
        <div id="successMsg">
            <p>검색된 내용이 없습니다.</p>
        </div>
        <div id="btnArea">
            <button id="goToListBtn" onclick="location.href='gongji_list.jsp'">리스트보기</button>
        </div>
        <input type="text" id="search" name="search" placeholder="제목 검색"><button onclick="search()">검색</button>
    </div>
    <%
        } else {
            ResultSet rset = stmt.executeQuery("select * from gongji where title like '%" + title +"%' order by id desc;");
    %>
    <div class="table-outer">
    <table width=650 cellspacing=0 cellpadding=5>
        <tr id="tr_id">
            <th>번호</th>
            <th>제목</th>
            <th>등록일</th>
        </tr>
    <%
            while(rset.next()) {
                out.println("<tr align=center>");
                out.println("<td width=300>" + rset.getInt(1) + "</td>");
                out.println("<td width=500><a href='gongji_view.jsp?id="+rset.getInt(1)+"'>" + rset.getString(2) + "</td>");
                out.println("<td width=500>" + rset.getString(3) + "</td>");
                out.println("</tr>");
            }

            rset.close();
    %>

    </table>
    <div id="btnArea2">
        <button id="goToListBtn2" onclick="location.href='gongji_list.jsp?current_page=1'">전체목록보기</button>
    </div>
    <input type="text" id="search" name="search" placeholder="제목 검색"><button onclick="search()">검색</button>

    <%
        }

        

        stmt.close();
        conn.close();
    %>
    
</div>
</body>
</html>