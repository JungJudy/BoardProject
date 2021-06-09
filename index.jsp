<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*, java.net.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="./css/index.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <title>Judy</title>

    <script>
        function checkPW() {
            location.href="gongji_list.jsp";
        }
    </script>
</head>

<body>
    <div id="container">
        <p>Judy's 게시판</p>
        <!-- <label for="password">비밀번호</label><input type="password" name="pw" id="pw" maxlength="15" minlength="4" placeholder="내생일"/> -->
        <div id="Btn"><button id="goBtn" onclick="checkPW()">접속하기</button></div>
    </div>
</body>
</html>