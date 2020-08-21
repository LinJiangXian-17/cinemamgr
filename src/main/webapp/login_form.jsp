<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="js/jquery-2.2.4.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <style>
        body {
            background-image: url("http://www.huajunhk.com/uploads/allimg/190829/2-1ZR9152AQ91.jpg");
            background-size: cover;
        }
        h1,label{
           color: white;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row clearfix" style="margin-top: 200px">
        <div class="col-md-12 column">
            <div class="row clearfix">
                <div class="col-md-2 column">
                </div>
                <div class="col-md-8 column">
                    <h1 class="text-center">
                        影院后台登录
                    </h1>
                    <form class="form-horizontal" role="form" action="admin/login">
                        <div class="form-group">
                            <label for="username" class="col-sm-2 control-label">用户名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="username" id="username" value="admin"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">密码</label>
                            <div class="col-sm-10">
                                <input type="password" class="form-control" name="password" id="password" value="admin"/>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">
                                <button type="submit" class="btn btn-primary">Sign in</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-2 column">
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
