<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>演员</title>
    <base href="${pageContext.request.contextPath}/">
    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <!-- Sweet Alert -->
    <link href="inspinia/css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="js/jquery-2.2.4.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
<script>
$(function () {
    var p5 = document.querySelector('#p5');
    p5.setAttribute("class","active")
});

//点击添加作品，异步请求返回电影列表
function doFindWork(actorId) {
    $.get('actor/findWork',{"actorId":actorId},function (result) {
        $("#work").empty()
        $("#work").append("<input type='hidden' name='actorId' value='"+ actorId  +"'>")
        for(var i=0; i < result.length; i++ ){
            $("#work").append(
                "<label>"
                + "<input name='filmId' type='checkbox' value="
                + result[i].filmId
                + ">"
                + result[i].filmName
                +"</label>" + "&nbsp;&nbsp;"
            );

            //一个汉字占两个字符
            if(result[i].filmName.length == 2){
                $("#work").append("&nbsp;&nbsp;");
            }

            //每三个进行换行
            if( (i+1) % 5 == 0){
                $("#work").append("<br>");
            }
        }
    },'json')
}
function addWork() {
    $.ajax({
        type : "POST",
        url : "actor/addWork",
        data : $("#work").serialize(),
        success: function (result) {
            console.log(result.resultCode);//打印服务端返回的数据(调试用)
            console.log("打印服务端返回的数据(调试用)");//打印服务端返回的数据(调试用)
            swal({
                title: "Good job!",
                text: "添加成功!",
                type: "success"
            },function () { //点击关闭按钮的回调函数
                //手动关闭模态框
                $("#addWork").hide();

                //3.或者刷新页面
                location.reload();

            });
        },
        error : function() {
            alert("异常！");
        }
    })
}

//添加演员
function saveActor() {
    $.ajax({
        type : "POST",
        url : "actor/save",
        data : $("#actor").serialize(),
        success: function (result) {
            console.log(result.resultCode);//打印服务端返回的数据(调试用)
            console.log("打印服务端返回的数据(调试用)");//打印服务端返回的数据(调试用)
            swal({
                title: "Good job!",
                text: "添加成功!",
                type: "success"
            },function () { //点击关闭按钮的回调函数
                //手动关闭模态框
                $("#addActorModal").hide();

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
                <h3>
                    演员
                    <form class="form-inline pull-right" action="actor/all">
                        <div class="form-group">
                            <input type="text" class="form-control" id="exampleInputName2" name="actorName" placeholder="输入想查询的演员名称">
                        </div>
                        <button type="submit" class="btn btn-default">查询</button>
                    </form>
                    <a href="javascript:void(0)" class="btn btn-info pull-right"
                       data-toggle="modal"
                       data-backdrop="static"
                       data-target="#addActorModal"><span class="glyphicon glyphicon-plus"></span> 添加演员</a>
                </h3> <small>Someone famous</small>
            </blockquote>
            <table class="table">
                <thead>
                <tr>
                    <th> 图片</th>
                    <th>编号</th>
                    <th> 名字</th>
                    <th> 操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="actor" items="${page}">
                <tr>
                    <td>
                        <div class="row clearfix">
                            <div class="col-md-12 column">
                                <img alt="140x140" src="${actor.actorImg}" class="img-circle" />
                            </div>
                        </div>
                    </td>
                    <td>${actor.actorId}</td>
                    <td>${actor.actorName}</td>
                    <td>
                        <a href="javascript:void(0)" class="btn btn-success "
                           data-toggle="modal"
                           data-backdrop="static"
                           data-target="#addWork" onclick="doFindWork(${actor.actorId})">
                            添加作品
                        </a>
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
                    <a href="actor/all?pageNum=1">第一页</a> &nbsp;
                </c:if>
                <c:if test="${page.getPageNum() gt 1}">
                    <a href="actor/all?pageNum=${page.getPageNum()-1}">上一页</a>&nbsp;
                </c:if>
                <c:if test="${page.getPageNum() lt page.getPages()}">
                    <a href="actor/all?pageNum=${page.getPageNum()+1}">下一页</a>&nbsp;
                </c:if>
                <c:if test="${page.getPageNum() lt page.getPages()}">
                    <a href="actor/all?pageNum=${page.getPages()}">末页</a>&nbsp;
                </c:if>
            </td>
        </tr>
    </table>
</div>
<div class="modal fade" id="addWork" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe">请选择作品</h4>
            </div>
            <div class="modal-body">
                <form id="work"  method="post">

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" id="addWorks" onclick="addWork()" class="btn btn-primary">添加</button>
            </div>
        </div>
    </div>
</div>

<!-- 添加演员 -->
<div class="modal fade" id="addActorModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe2">请选择作品</h4>
            </div>
            <div class="modal-body">
                <form id="actor"  method="post">
                    <div class="form-group">
                        <label for="inputActorId" class="col-sm-2 control-label">演员编号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control"  id="inputActorId" placeholder="自动生成"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputActorName" class="col-sm-2 control-label">演员名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="actorName" id="inputActorName" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputActorImg" class="col-sm-2 control-label">图片</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="actorImg" id="inputActorImg" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" id="saveActor" onclick="saveActor()" class="btn btn-primary">添加</button>
            </div>
        </div>
    </div>
</div>
</body>
<!-- Custom and plugin javascript -->
<script src="inspinia/js/inspinia.js"></script>

<!-- Sweet alert -->
<script src="inspinia/js/plugins/sweetalert/sweetalert.min.js"></script>
</html>
