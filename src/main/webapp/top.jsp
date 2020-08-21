<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <base href="${pageContext.request.contextPath}/">
    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="js/jquery-2.2.4.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
<script>
function doActive(obj) {
    //var $obj = $(obj);
    obj.setAttribute("class","active");
}

function showTips() {
    alert("敬请期待~")
}
</script>
</head>
<body>
<div class="row clearfix" style="margin-bottom: 20px;margin-top: 20px;">
    <div class="col-md-12 column">
        <ul class="nav nav-pills nav-justified">
            <li id="p1"><a href="index.jsp">Home</a></li>
            <li id="p2"><a href="film/all">正在热映</a></li>
            <li id="p3"><a href="film/upComing">即将上映</a></li>
            <li id="p4"><a href="film/hit">热播电影</a></li>
            <li id="p5"><a href="actor/all">演员信息</a></li>
            <li id="p6"><a href="cinema/all">影院管理</a></li>
            <li id="p7"><a href="figure/all">手办商城</a></li>
            <li id="p8"><a href="javascript:void(0)" onclick="showTips()">用户管理</a></li>
            <li id="p9"><a href="javascript:void(0)" onclick="showTips()">管理员</a></li>
        </ul>
    </div>
</div>
</body>
</html>
