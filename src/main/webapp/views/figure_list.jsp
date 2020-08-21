<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>手办</title>
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
    var p7 = document.querySelector('#p7');
    p7.setAttribute("class","active")
});

//添加手办
function saveFigure() {
    $.ajax({
        type : "POST",
        url : "figure/save",
        data : $("#figure").serialize(),
        success : function (result) {
            console.log(result.resultCode);//打印服务端返回的数据(调试用)
            console.log("打印服务端返回的数据(调试用)");//打印服务端返回的数据(调试用)
            swal({
                title: "Good job!",
                text: "添加成功!",
                type: "success"
            },function () { //点击关闭按钮的回调函数
                //手动关闭模态框
                $("#addFigureModal").hide();

                //3.或者刷新页面
                location.reload();

            });
        },error : function () {
            alert("异常")
        }
    })
}

//删除
function deleteFigure(figureId) {
    $.get('figure/del',{"figureId":figureId},function (result) {
        if (result.resultCode) {
            swal({
                title: "Good job!",
                text: "手办已下架!",
                type: "success"
            },function () { //点击关闭按钮的回调函数
                //刷新页面
                location.reload();

            });
        }
    },'json')
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
                    手办列表
                    <form class="form-inline pull-right" action="figure/all">
                        <div class="form-group">
                            <input type="text" class="form-control" id="exampleInputName2" name="figureName" placeholder="输入想查询的手办名称">
                        </div>
                        <button type="submit" class="btn btn-default">查询</button>
                    </form>
                    <a href="javascript:void(0)" class="btn btn-info pull-right"
                       data-toggle="modal"
                       data-backdrop="static"
                       data-target="#addFigureModal"><span class="glyphicon glyphicon-plus"></span> 添加手办</a>
                </h2> <small>${page.getTotal()}件</small>
            </blockquote>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">
            <table class="table">
                <thead>
                <tr>
                    <th>图片</th>
                    <th>编号</th>
                    <th>名称</th>
                    <th>价格</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="figure" items="${page}">
                <tr>
                    <td>
                        <div class="row clearfix">
                            <div class="col-md-12 column">
                                <img alt="140x140" width="100px" height="50px" src="${figure.figureImg}" class="img-thumbnail" />
                            </div>
                        </div>
                    </td>
                    <td>
                        ${figure.figureId}
                    </td>
                    <td>
                        ${figure.figureName}
                    </td>
                    <td>
                        ￥ ${figure.figurePrice}
                    </td>
                    <td>
                        <!-- href="figure/del?figureId=${figure.figureId}" -->
                        <a class="btn btn-danger" onclick="deleteFigure(${figure.figureId})">下架</a>
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
                    <a href="figure/all?pageNum=1">第一页</a> &nbsp;
                </c:if>
                <c:if test="${page.getPageNum() gt 1}">
                    <a href="figure/all?pageNum=${page.getPageNum()-1}">上一页</a>&nbsp;
                </c:if>
                <c:if test="${page.getPageNum() lt page.getPages()}">
                    <a href="figure/all?pageNum=${page.getPageNum()+1}">下一页</a>&nbsp;
                </c:if>
                <c:if test="${page.getPageNum() lt page.getPages()}">
                    <a href="figure/all?pageNum=${page.getPages()}">末页</a>&nbsp;
                </c:if>
            </td>
        </tr>
    </table>
</div>

<!-- 添加手办 -->
<div class="modal fade" id="addFigureModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe">请选填写以下信息</h4>
            </div>
            <div class="modal-body">
                <form id="figure"  method="post">
                    <div class="form-group">
                        <label for="inputFigureId" class="col-sm-2 control-label">手办编号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control"  id="inputFigureId" placeholder="自动生成"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputFigureName" class="col-sm-2 control-label">手办名称</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="figureName" id="inputFigureName" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputFigureImg" class="col-sm-2 control-label">图片</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="figureImg" id="inputFigureImg" />
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputFigurePrice" class="col-sm-2 control-label">价格</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" name="figurePrice" id="inputFigurePrice" />
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" id="saveFigure" onclick="saveFigure()" class="btn btn-primary">添加</button>
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
