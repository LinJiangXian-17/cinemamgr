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
    var p2 = document.querySelector('#p2');
    p2.setAttribute("class","active")
});

//转热播
function moveToHit1(filmId) {
    $.get('film/moveToHit',{"filmId":filmId},function (data) {
        console.log(data.resultCode)
        if (data.resultCode) {
            console.log(data.resultCode)
            //tips
            swal({
                title: "Good job!",
                text: "影片已移至热播!",
                type: "success"
            },function () { //点击关闭按钮的回调函数
                //3.或者刷新页面
                location.reload();

            })
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
                <h2 style="color: #ef4238!important;">
                    正在热映
                    <form class="form-inline pull-right" action="film/all">
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
                                    ${film.filmName}
                            </h3>
                            <p style="color: white">
                                    ${film.summary.substring(0,50)}......
                            </p>
                            <p style="margin-top: 30px">
                                <a href="javascript:void(0)" class="btn btn-primary "
                                   data-toggle="modal"
                                    data-backdrop="static"
                                    data-target="#updateModal" onclick="doUpdate(${film.filmId})">
                                    查看
                                </a>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#addImg" onclick="setFilmId(${film.filmId})">
                                    图集
                                </button>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#moveToHit1" onclick="moveToHit1(${film.filmId})">
                                    转热播
                                </button>
                                <a class="btn btn-danger" href="#">删除</a>
                                <span style="color: white">&nbsp;评分：${film.score}</span>
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
<!-- Update Modal -->
<jsp:include page="../film_detail.jsp" />
</body>
</html>
