<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>电影</title>
    <base href="${pageContext.request.contextPath}/">
    <!-- Bootstrap -->
    <link href="bootstrap/css/bootstrap.css" rel="stylesheet">
    <!-- jQuery -->
    <script src="js/jquery-2.2.4.js"></script>
    <script src="bootstrap/js/bootstrap.min.js"></script>
<script>
$(function () {
    var p3 = document.querySelector('#p3');
    p3.setAttribute("class","active")
});

//点击转热映
function moveToHit0(filmId) {
    $(".filmId").remove()
    $("#hit0").append("<input type='hidden' class='filmId' name='filmId' value='" + filmId + "'>")
}

//转热映
function doMoveHit0() {
    $.ajax({
        type : "POST",
        url : "film/moveToHit",
        data : $("#hit0").serialize(),
        success: function (result) {
            console.log(result.resultCode);//打印服务端返回的数据(调试用)
            console.log("打印服务端返回的数据(调试用)");//打印服务端返回的数据(调试用)
            swal({
                title: "Good job!",
                text: "影片已移至热映!",
                type: "success"
            },function () { //点击关闭按钮的回调函数
                //手动关闭模态框
                $("#moveToHit0").hide();

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
                    即将上映
                    <form class="form-inline pull-right" action="film/upComing">
                        <div class="form-group">
                            <input type="text" class="form-control" id="exampleInputName2" name="filmName" placeholder="输入想查询的电影名称">
                        </div>
                        <button type="submit" class="btn btn-default">查询</button>
                    </form>
                    <a href="javascript:void(0)" class="btn btn-info pull-right"
                       data-toggle="modal"
                       data-backdrop="static"
                       data-target="#addModal"><span class="glyphicon glyphicon-plus"></span> 添加影片</a>
                </h2> <small>${page.getTotal()}部</small>
            </blockquote>
        </div>
    </div>
    <div class="row clearfix">
        <div class="col-md-12 column">
            <div class="row">
                <c:forEach var="film" items="${page}">
                <div class="col-md-4">
                    <div class="thumbnail"
                         style="background-image: url('https://s3plus.meituan.net/v1/mss_e2821d7f0cfe4ac1bf9202ecf9590e67/cdn-prod/file:5788b470/banner_bg.f7fd103e3b8c16b6f449cce43fc57f45.png')">
                        <img width="174px" height="250px" src="${film.cover}" />
                        <div class="caption">
                            <h3 class="text-center" style="color: white">
                                ${film.filmName}<br>
                            </h3>
                            <p style="color: white">
                                    ${film.summary.substring(0,50)}......
                            </p>
                            <p style="margin-top: 30px">
                                <span style="color: white">&nbsp;上映时间：<fmt:formatDate value="${film.time}" pattern="yyyy-MM-dd"/></span><br>
                                <a href="javascript:void(0)" class="btn btn-primary "
                                   data-toggle="modal"
                                   data-backdrop="static"
                                   data-target="#updateModal" onclick="doUpdate(${film.filmId})">
                                    查看
                                </a>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#addImg" onclick="setFilmId(${film.filmId})">
                                    图集
                                </button>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#moveToHit0" onclick="moveToHit0(${film.filmId})">
                                    转热映
                                </button>
                                <a class="btn btn-danger" href="#">删除</a>
                            </p>
                        </div>
                    </div>
                </div>
                </c:forEach>

            </div>
        </div>
    </div>
    <table style="margin-bottom: 20px">
        <!-- 分页栏 -->
        <tr class="page-nav">
            <td colspan='3'>
                总${page.getTotal()}条 &nbsp;&nbsp; 第${page.getPageNum()}页/共${page.getPages()}页
                &nbsp;&nbsp; &nbsp;&nbsp;
                <c:if test="${page.getPageNum() gt 1}">
                    <a href="film/all?pageNum=1">第一页</a> &nbsp;
                </c:if>
                <c:if test="${page.getPageNum() gt 1}">
                    <a href="film/all?pageNum=${page.getPageNum()-1}">上一页</a>&nbsp;
                </c:if>
                <c:if test="${page.getPageNum() lt page.getPages()}">
                    <a href="film/all?pageNum=${page.getPageNum()+1}">下一页</a>&nbsp;
                </c:if>
                <c:if test="${page.getPageNum() lt page.getPages()}">
                    <a href="film/all?pageNum=${page.getPages()}">末页</a>&nbsp;
                </c:if>
            </td>
        </tr>
    </table>
</div>
<jsp:include page="../film_detail.jsp" />
<!-- 移到正在热映 -->
<div class="modal fade" id="moveToHit0" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe2">请输入评分</h4>
            </div>
            <div class="modal-body">
                <form id="hit0"  method="post">
                    <div class="form-group">
                        <label for="inputScore" class="col-sm-2 control-label">评分</label>
                        <div class="col-sm-10">
                            <input type="number" class="form-control" name="score" id="inputScore" placeholder="影片评分"/>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" id="doMoveHit0" onclick="doMoveHit0()" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
