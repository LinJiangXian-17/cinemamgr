<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>影院</title>
    <base href="${pageContext.request.contextPath}/">
    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="inspinia/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="js/jquery-2.2.4.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
    <style>
        .table th{
            text-align: center;
            vertical-align: middle!important;

        }
        td{
            text-align: center;
        }
    </style>
<script>
$(function () {
    var p6 = document.querySelector('#p6');
    p6.setAttribute("class","active")

    //添加影院
    $("#addBtn").click(function () {

        //异步提交新增表单数据
        //异步提交请求
        const params = $("#addCinemaForm").serialize();
        //console.log('提交的数据：' + params); // x.jsp?ename=james&job=CLECK&

        // 在url 后加上一个随机参数来解决浏览器缓存的问题, 因为当请求的地址和参数无变化时浏览器不会发出新的请求，
        // 浏览器会直接使用本地缓存中的内容以提高响应速度
        $.post('cinema/addCinema?a=' + Math.random(),params,function (data) {
            if (data.resultCode) {
                //tips
                swal({
                    title: "Good job!",
                    text: "添加成功!",
                    type: "success"
                },function () { //点击关闭按钮的回调函数
                    //手动关闭模态框
                    $("#addModal").hide();

                    //3.或者刷新页面
                    location.reload();

                });
            }else {
                //tips
                swal({
                    title: "错误!",
                    text: "添加失败!",
                    type: "error"
                });
            }
        },'json');
    });

    //更新影院信息
    $("#updateBtn").click(function () {
        //序列化
        const params = $("#updateCinemaForm").serialize();
        //console.log(params)

        $.post('cinema/updateCinema',params,function (data) {
            console.log(data.resultCode)
            if (data.resultCode) {
                console.log(data.resultCode)
                //tips
                swal({
                    title: "Good job!",
                    text: "更新成功!",
                    type: "success"
                },function () { //点击关闭按钮的回调函数
                    //手动关闭模态框
                    $("#updateModal").hide();

                    //3.或者刷新页面
                    location.reload();

                });
            }else {
                //tips
                swal({
                    title: "错误!",
                    text: "更新失败!",
                    type: "error"
                },function () {
                    $("#updateModal").hide();
                });
            }
        },'json');
    });


});


//点击查看，异步请求数据，获得当前影院信息
function doFind(cinemaId) {
    $.get('cinema/findById',{"cinemaId":cinemaId},function (data) {
        $("#inputCinemaId").val(cinemaId)
        $("#inputName").val(data.name)
        $("#inputAddress").val(data.address)
        $("#inputTel").val(data.tel)
        document.querySelector("#cpic").src = data.pic
    },'json')
}

//点击上架，异步请求数据，获得未上架的电影
function doAdd(cinemaId) {
    $.get('cinema/findFilm',{"cinemaId":cinemaId},function (result) {
        $("#film").empty()
        $("#film").append("<input type='hidden' name='cinemaId' value='"+ cinemaId  +"'>")
        for(var i=0; i < result.length; i++ ){
            $("#film").append(
                "<label>"
                + "<input name='filmId' type='checkbox' value="
                + result[i].filmId
                + ">"
                + result[i].filmName
                +"</label>" + "&nbsp;&nbsp;"
            );

            //一个汉字占两个字符
            if(result[i].filmName.length == 2){
                $("#film").append("&nbsp;&nbsp;");
            }

            //每三个进行换行
            if( (i+1) % 5 == 0){
                $("#film").append("<br>");
            }
        }
    },'json')
}
//真实上架操作
function onPutFilm() {
    $.ajax({
        type: "POST",//方法类型
        url : "cinema/onShelves",
        data : $('#film').serialize(),
        success: function (result) {
            console.log(result.resultCode);//打印服务端返回的数据(调试用)
            console.log("打印服务端返回的数据(调试用)");//打印服务端返回的数据(调试用)
            swal({
                title: "Good job!",
                text: "上架成功!",
                type: "success"
            },function () { //点击关闭按钮的回调函数
                //手动关闭模态框
                $("#addFilm").hide();

                //3.或者刷新页面
                location.reload();

            });
            if (result.resultCode == true) {
                alert("SUCCESS");
                //tips
            }
            ;
        },
        error : function() {
            alert("异常！");
        }
    })
}

//点击下架，异步请求获取已上架的电影
function doRemove(cinemaId) {
    $.get('cinema/searchFilm',{"cinemaId":cinemaId},function (result) {
        $("#allfilm").empty()
        $("#allfilm").append("<input type='hidden' name='cinemaId' value='"+ cinemaId  +"'>")
        for(var i=0; i < result.length; i++ ){
            $("#allfilm").append(
                "<label>"
                + "<input name='filmId' type='checkbox' value="
                + result[i].filmId
                + ">"
                + result[i].filmName
                +"</label>" + "&nbsp;&nbsp;"
            );

            //一个汉字占两个字符
            if(result[i].filmName.length == 2){
                $("#allfilm").append("&nbsp;&nbsp;");
            }

            //每三个进行换行
            if( (i+1) % 5 == 0){
                $("#allfilm").append("<br>");
            }
        }
    },'json')
}

//真实下架
function onRemoveFilm(){
    $.ajax({
        type: "POST",//方法类型
        url : "cinema/offShelves",
        data : $('#allfilm').serialize(),
        success: function (result) {
            console.log(result.resultCode);//打印服务端返回的数据(调试用)
            console.log("打印服务端返回的数据(调试用)");//打印服务端返回的数据(调试用)
            swal({
                title: "Good job!",
                text: "下架成功!",
                type: "success"
            },function () { //点击关闭按钮的回调函数
                //手动关闭模态框
                $("#removeFilm").hide();

                //3.或者刷新页面
                location.reload();

            });
        },
        error : function() {
            alert("异常！");
        }
    })
}
</script>
</head>
<body>
<div class="container">
    <jsp:include page="../top.jsp" />
    <div class="row clearfix">
        <div class="col-md-12 column">
            <blockquote>
                <h2 style="color: #2d98f3!important;">
                    影院列表
                    <form class="form-inline pull-right" action="cinema/all">
                        <div class="form-group">
                            <input type="text" class="form-control" id="exampleInputName2" name="name" placeholder="输入想查询的影院名称">
                        </div>
                        <button type="submit" class="btn btn-default">查询</button>
                    </form>
                    <a href="javascript:void(0)" class="btn btn-info pull-right"
                       data-toggle="modal"
                       data-backdrop="static"
                       data-target="#addCinemaModal"><span class="glyphicon glyphicon-plus"></span> 添加影院</a>
                </h2> <small>${page.getTotal()}家</small>
            </blockquote>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table table-hover table-striped">
                <thead>
                <tr>
                    <th>编号</th>
                    <th>影院</th>
                    <th>地址</th>
                    <th>电话</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="cinema" items="${page}">
                    <tr>
                        <td>
                            ${cinema.cinemaId}
                        </td>
                        <td>
                            ${cinema.name}
                        </td>
                        <td>
                            ${cinema.address}
                        </td>
                        <td>
                            ${cinema.tel}
                        </td>
                        <td>
                            <a href="javascript:void(0)" class="btn btn-success "
                               data-toggle="modal"
                               data-backdrop="static"
                               data-target="#updateModal" onclick="doFind(${cinema.cinemaId})">
                                查看
                            </a>
                            <a href="javascript:void(0)" class="btn btn-success "
                               data-toggle="modal"
                               data-backdrop="static"
                               data-target="#addFilm" onclick="doAdd(${cinema.cinemaId})">
                                上架
                            </a>
                            <a href="javascript:void(0)" class="btn btn-warning "
                               data-toggle="modal"
                               data-backdrop="static"
                               data-target="#removeFilm" onclick="doRemove(${cinema.cinemaId})">
                                下架
                            </a>
                            <button type="button" class="btn btn-default active btn-danger">删除</button>
                        </td>

                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
    <table style="margin-bottom: 20px">
        <!-- 分页栏 -->
        <tr class="page-nav">
            <td colspan='3'>
                总${page.getTotal()}条 &nbsp;&nbsp; 第${page.getPageNum()}页/共${page.getPages()}页
                &nbsp;&nbsp; &nbsp;&nbsp;
                <c:if test="${page.getPageNum() gt 1}">
                    <a href="cinema/all?pageNum=1">第一页</a> &nbsp;
                </c:if>
                <c:if test="${page.getPageNum() gt 1}">
                    <a href="cinema/all?pageNum=${page.getPageNum()-1}">上一页</a>&nbsp;
                </c:if>
                <c:if test="${page.getPageNum() lt page.getPages()}">
                    <a href="cinema/all?pageNum=${page.getPageNum()+1}">下一页</a>&nbsp;
                </c:if>
                <c:if test="${page.getPageNum() lt page.getPages()}">
                    <a href="cinema/all?pageNum=${page.getPages()}">末页</a>&nbsp;
                </c:if>
            </td>
        </tr>
    </table>
</div>

<!-- Add Modal -->
<div class="modal fade" id="addCinemaModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加影院信息</h4>
            </div>
            <div class="modal-body">
                <form id="addCinemaForm" class="form-horizontal">
                    <div class="form-group">
                        <label for="inputCinemaId1" class="col-sm-2 control-label">编号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="cinemaId" id="inputCinemaId1" placeholder="影院编号" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputName1" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" id="inputName1" placeholder="影院名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddress1" class="col-sm-2 control-label">地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="address" id="inputAddress1" placeholder="影院地址" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputTel1" class="col-sm-2 control-label">电话</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="tel" id="inputTel1" placeholder="影院电话" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPic1" class="col-sm-2 control-label">图片URL</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="pic" id="inputPic1" placeholder="图片链接" required>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="addBtn" class="btn btn-primary">添加</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- Update Modal -->
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel1">影院信息</h4>
            </div>
            <div class="modal-body">
                <div class="row clearfix text-center"
                     style="background-image: url('https://s3plus.meituan.net/v1/mss_e2821d7f0cfe4ac1bf9202ecf9590e67/cdn-prod/file:5788b470/banner_bg.f7fd103e3b8c16b6f449cce43fc57f45.png')">
                    <div class="col-md-12 column">
                        <img alt="140x140" id="cpic" src="" class="img-thumbnail" />
                    </div>
                </div>
                <form id="updateCinemaForm" class="form-horizontal">
                    <div class="form-group">
                        <label for="inputCinemaId" class="col-sm-2 control-label">编号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="cinemaId" id="inputCinemaId" placeholder="影院编号" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputName" class="col-sm-2 control-label">名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="name" id="inputName" placeholder="影院名称" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputAddress" class="col-sm-2 control-label">地址</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="address" id="inputAddress" placeholder="影院地址" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputTel" class="col-sm-2 control-label">电话</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="tel" id="inputTel" placeholder="影院电话" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPic" class="col-sm-2 control-label">图片URL</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="pic" id="inputPic" placeholder="图片链接" required>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="updateBtn" class="btn btn-primary">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>

<!-- 电影上架 -->
<div class="modal fade" id="addFilm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe">以下电影未在该电影院上映</h4>
            </div>
            <div class="modal-body">
                <form id="film"  method="post">

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" id="onPut" onclick="onPutFilm()" class="btn btn-primary">上架</button>
            </div>
        </div>
    </div>
</div>

<!-- 电影下架 -->
<div class="modal fade" id="removeFilm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe2">该电影院现有以下电影在上映</h4>
            </div>
            <div class="modal-body">
                <form id="allfilm"  method="post">

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" id="onRemove" onclick="onRemoveFilm()" class="btn btn-primary">下架</button>
            </div>
        </div>
    </div>
</div>
<!-- Custom and plugin javascript -->
<script src="inspinia/js/inspinia.js"></script>

<!-- Sweet alert -->
<script src="inspinia/js/plugins/sweetalert/sweetalert.min.js"></script>
</body>
</html>
