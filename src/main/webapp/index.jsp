<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>首页</title>
    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="js/jquery-2.2.4.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <script>
        $(function () {
            var p1 = document.querySelector('#p1');
            p1.setAttribute("class","active")
        })
    </script>
</head>
<body>

<div class="container">
    <jsp:include page="top.jsp" />
    <div class="row clearfix" style="margin-top: 20px">
        <div class="col-md-12 column">
            <div class="jumbotron"
                 style="background-image: url('https://s3plus.meituan.net/v1/mss_e2821d7f0cfe4ac1bf9202ecf9590e67/cdn-prod/file:5788b470/banner_bg.f7fd103e3b8c16b6f449cce43fc57f45.png')">
                <h1 style="color: white">
                    Hello, ${loginAdmin.username}
                </h1>
                <p style="color: white">
                    欢迎登录影院后台
                </p>
                <p>
                    <a class="btn btn-primary btn-large" href="admin/logout">Log Out</a>
                </p>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        管理员信息
                    </h3>
                </div>
                <div class="panel-body">
                    TEL:${loginAdmin.tel}
                </div>
                <div class="panel-footer">
                    Email:${loginAdmin.email}
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
