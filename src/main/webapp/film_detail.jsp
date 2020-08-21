<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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

    $("#addBtn").click(function () {

        //异步提交新增表单数据
        //异步提交请求
        const params = $("#addFilmForm").serialize();
        //console.log('提交的数据：' + params); // x.jsp?ename=james&job=CLECK&

        // 在url 后加上一个随机参数来解决浏览器缓存的问题, 因为当请求的地址和参数无变化时浏览器不会发出新的请求，
        // 浏览器会直接使用本地缓存中的内容以提高响应速度
        $.post('film/insertFilm?a=' + Math.random(),params,function (data) {
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

    //更新
    $("#updateBtn").click(function () {

        //序列化
        const params = $("#updateFilmForm").serialize();
        console.log(params)
        $.post('film/UpdateFilm',params,function (data) {
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
                    $("#addImg").hide();

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
//异步获取电影信息和图集以及演员
function doUpdate(filmId) {
    $.get('film/findByFilmId',{"filmId":filmId},function (data) {
        $("#inputFilmId").val(filmId)
        $("#inputFilmName").val(data.filmName)
        $("#inputSummary").val(data.summary)
        $("#inputScore").val(data.score)
        $("#inputType").val(data.type)
        $("#inputWish").val(data.wish)
    },'json');

    //电影图集
    $.get('album/findImagesForFilm',{"filmId":filmId},function (data) {
        console.log(data)
        var ileft = document.querySelector("#ileft");
        var iright = document.querySelector("#iright");
        $('#images').empty();
        if (data.length > 0) {
            ileft.setAttribute("href","#carousel-549474");
            iright.setAttribute("href","#carousel-549474");
            for(var i=0; i < data.length; i++ ){
                if (i == 0){
                    $('#images').append(
                        "<div class='item active'>"+
                        "<img src=" + data[i].imgUrl + " />"+
                        "</div>"
                    )
                } else {
                    $('#images').append(
                        "<div class='item'>"+
                        "<img src=" + data[i].imgUrl + " />"+
                        "</div>"
                    )
                }

            }
        }else {
            ileft.removeAttribute("href");
            iright.removeAttribute("href");
        }
    },'json');

    //演员
    $.get('actor/findActors',{"filmId":filmId},function (data) {
        console.log(data)
        var aleft = document.querySelector("#aleft");
        var aright = document.querySelector("#aright");
        $("#actors").empty();
        if (data.length > 0) {
            aleft.setAttribute("href","#carousel-549475");
            aright.setAttribute("href","#carousel-549475");
            for (var j=0; j < data.length; j++ ){
                if (j == 0){
                    $('#actors').append(
                        "<div class='item active'>"+
                        "<img width='150px' height='190px' src=" + data[j].actorImg + " />"+
                        "<div class='carousel-caption' style='padding-bottom: 0px'>"+
                            "<p>"+
                                data[j].actorName+
                            "</p>"+
                        "</div>" +
                        "</div>"
                    )
                } else {
                    $('#actors').append(
                        "<div class='item'>"+
                        "<img width='150px' height='190px' src=" + data[j].actorImg + " />"+
                        "<div class='carousel-caption' style='padding-bottom: 0px'>"+
                            "<p>"+
                                data[j].actorName+
                            "</p>"+
                        "</div>" +
                        "</div>"
                    )
                }
            }
        }else {
            aleft.removeAttribute("href");
            aright.removeAttribute("href");
        }
    },'json');
}

//点击图集，设置电影ID
function setFilmId(filmId) {
    $("#filmId").val(filmId);
}

//提交图集
function addImages() {
    $.ajax({
        type : "POST",
        url : "album/addImgages",
        data : $("#filmImg").serialize(),
        success : function (result) {
            console.log(result.resultCode);//打印服务端返回的数据(调试用)
            console.log("打印服务端返回的数据(调试用)");//打印服务端返回的数据(调试用)
            swal({
                title: "Good job!",
                text: "图集已添加!",
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
<!-- Add Modal -->
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">影片详情</h4>
            </div>
            <div class="modal-body">
                <form id="addFilmForm" class="form-horizontal">
                    <div class="form-group">
                        <label for="inputFilmId" class="col-sm-2 control-label">编号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="filmId" id="inputFilmId1" placeholder="电影编号" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputFilmName1" class="col-sm-2 control-label">片名</label>
                        <div class="col-sm-10">
                            <input type="text" name="filmName" class="form-control" id="inputFilmName1" placeholder="请输入片名" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputSummary1" class="col-sm-2 control-label">简介</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="3" name="summary" id="inputSummary1" placeholder="请输入电影简介" required></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputType1" class="col-sm-2 control-label">类型</label>
                        <div class="col-sm-10">
                            <input type="text" name="type" class="form-control" id="inputType1" placeholder="请输入类型" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputType1" class="col-sm-2 control-label">上映类型</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="hit" id="inlineHit1" value="0"> 正在热映
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="hit" id="inlineHit2" value="1"> 热播电影
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="upComing" id="inlineRadio3" value="1"> 即将上映
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputCover" class="col-sm-2 control-label">封面</label>
                        <div class="col-sm-10">
                            <input type="text" name="cover" class="form-control" id="inputCover" placeholder="封面链接" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputScore1" class="col-sm-2 control-label">评分</label>
                        <div class="col-sm-10">
                            <input type="number" name="score" class="form-control" id="inputScore1" placeholder="请输入评分" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputTime1" class="col-sm-2 control-label">上映时间</label>
                        <div class="col-sm-10">
                            <input type="date" name="time" class="form-control" id="inputTime1">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputWish1" class="col-sm-2 control-label">想看数</label>
                        <div class="col-sm-10">
                            <input type="number" name="wish" class="form-control" id="inputWish1" placeholder="请输入想看数">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" id="addBtn" class="btn btn-primary">保存</button>
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
                <h4 class="modal-title" id="myModalLabel1">影片详情</h4>
            </div>
            <div class="container">
                <div class="row clearfix">
                    <div class="col-md-6 column">
                        <div class="carousel slide" id="carousel-549474">
                            <ol class="carousel-indicators">
                                <li class="active" data-slide-to="0" data-target="#carousel-549474">
                                </li>
                                <li data-slide-to="1" data-target="#carousel-549474">
                                </li>
                                <li data-slide-to="2" data-target="#carousel-549474">
                                </li>
                            </ol>
                            <%-- 此处修改 --%>
                            <div class="carousel-inner" id="images" align="center">

                            </div> <a class="left carousel-control" id="ileft" href="#carousel-549474" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> <a class="right carousel-control" id="iright" href="#carousel-549474" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
                        </div>
                    </div>
                    <div class="col-md-6 column">
                    </div>
                </div>
            </div>
            <div class="modal-body">
                <form id="updateFilmForm" class="form-horizontal">
                    <div class="form-group">
                        <label for="inputFilmId" class="col-sm-2 control-label">编号</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="filmId" id="inputFilmId" placeholder="电影编号" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputFilmName" class="col-sm-2 control-label">片名</label>
                        <div class="col-sm-10">
                            <input type="text" name="filmName" class="form-control" id="inputFilmName" placeholder="请输入片名" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputSummary" class="col-sm-2 control-label">简介</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="3" name="summary" id="inputSummary" placeholder="请输入电影简介" required></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputType" class="col-sm-2 control-label">类型</label>
                        <div class="col-sm-10">
                            <input type="text" name="type" class="form-control" id="inputType" placeholder="请输入类型">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputScore" class="col-sm-2 control-label">评分</label>
                        <div class="col-sm-10">
                            <input type="number" name="score" class="form-control" id="inputScore" placeholder="请输入评分">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputTime" class="col-sm-2 control-label">上映时间</label>
                        <div class="col-sm-10">
                            <input type="date" name="time" class="form-control" id="inputTime">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputWish" class="col-sm-2 control-label">想看数</label>
                        <div class="col-sm-10">
                            <input type="number" name="wish" class="form-control" id="inputWish" placeholder="请输入想看数">
                        </div>
                    </div>
                </form>
            </div>
            <div class="text-center">
                <h4>演职人员</h4>
            </div>
            <div class="container">
                <div class="row clearfix">
                    <div class="col-md-6 column">
                        <div class="carousel slide" id="carousel-549475">

                            <%-- 此处修改 --%>
                            <div class="carousel-inner" id="actors" align="center">

                            </div> <a class="left carousel-control" id="aleft"  href="#carousel-549475" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a> <a class="right carousel-control" id="aright"  href="#carousel-549475" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
                        </div>
                    </div>
                    <div class="col-md-6 column">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="updateBtn" class="btn btn-primary">保存</button>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            </div>
        </div>
    </div>
</div>
<!-- 添加图集 -->
<div class="modal fade" id="addImg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabe">为电影添加图集</h4>
            </div>
            <div class="modal-body">
                <form id="filmImg"  method="post">
                    <input type="hidden" class="form-control" id="filmId" name="filmId">
                    <div class="form-group">
                        <label for="exampleInputImg1">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg1" name="imgUrl" placeholder="图片链接">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputImg2">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg2" name="imgUrl" placeholder="图片链接">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputImg3">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg3" name="imgUrl" placeholder="图片链接">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputImg4">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg4" name="imgUrl" placeholder="图片链接">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputImg5">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg5" name="imgUrl" placeholder="图片链接">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputImg6">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg6" name="imgUrl" placeholder="图片链接">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputImg7">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg7" name="imgUrl" placeholder="图片链接">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputImg8">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg8" name="imgUrl" placeholder="图片链接">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputImg9">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg9" name="imgUrl" placeholder="图片链接">
                    </div>
                    <div class="form-group">
                        <label for="exampleInputImg10">图片链接</label>
                        <input type="text" class="form-control" id="exampleInputImg10" name="imgUrl" placeholder="图片链接">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" id="addImages" onclick="addImages()" class="btn btn-primary">添加</button>
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
