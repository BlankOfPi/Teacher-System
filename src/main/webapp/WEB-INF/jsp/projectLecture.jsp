<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
<head>
<meta charset="utf-8">
<title>教师信息系统</title>
<meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">

<script src="lib/jquery-1.11.1.min.js" type="text/javascript"></script>
<link rel="stylesheet" type="text/css"
	href="lib/bootstrap/css/bootstrap-datetimepicker.min.css">
<script type="text/javascript" src="lib/bootstrap/js/bootstrap-datetimepicker.js" charset="UTF-8"></script>

<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700'
	rel='stylesheet' type='text/css'>
<link rel="stylesheet" type="text/css"
	href="lib/bootstrap/css/bootstrap.css">
<link rel="stylesheet" href="lib/font-awesome/css/font-awesome.css">



<script src="lib/jQuery-Knob/js/jquery.knob.js" type="text/javascript"></script>
<script type="text/javascript">
        $(function() {
            $(".knob").knob();
        });
    </script>


<link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
<link rel="stylesheet" type="text/css" href="stylesheets/premium.css">

<link href="stylesheets/toastr.min.css" rel="stylesheet" />
<script src="js/toastr.min.js"></script>

</head>
<body class=" theme-blue">

	<!-- Demo page code -->

	<script type="text/javascript">
		toastr.options.positionClass = 'toast-bottom-center';
		var baseurl  = "${pageContext.request.contextPath}/goProjectLecture.action";
        $(function() {
            var match = document.cookie.match(new RegExp('color=([^;]+)'));
            if(match) var color = match[1];
            if(color) {
                $('body').removeClass(function (index, css) {
                    return (css.match (/\btheme-\S+/g) || []).join(' ')
                })
                $('body').addClass('theme-' + color);
            }

            $('[data-popover="true"]').popover({html: true});
            
        });
       
        function up(){
        	var name = $("#searchName").val();
        	var url  = baseurl+"?page=${currentPage-1}";
        	var teacherName = $("#searchTName").val();
        	if(teacherName != null && teacherName != ""){
        		url += "&tName="+encodeURI(encodeURI(teacherName));
        	}
        	if(name != null && name != ""){
        		url += "&name="+encodeURI(encodeURI(name));
        	}
        	if("${currentPage-1}">0){
        		window.location.href= url;	
        	}
        	
        }
        
        function down(){
        	debugger
        	var name = $("#searchName").val();
        	var url = baseurl+"?page=${currentPage+1}";
        	var max = eval("${pageTimes}");
        	var teacherName = $("#searchTName").val();
        	if(teacherName != null && teacherName != ""){
        		url += "&tName="+encodeURI(encodeURI(teacherName));
        	}
        	if(name != null && name != ""){
        		url += "&name="+encodeURI(encodeURI(name));
        	}
        	if(eval("${currentPage+1}") <= max){
        		window.location.href=url;	
        	}
        	
        }
        
        function search(){
        	var num =  eval($("#searchPage").val());
        	var url = baseurl+"?page="+num;
        	var max = eval("${pageTimes}");
        	var name = $("#searchName").val();
        	var teacherName = $("#searchTName").val();
        	if(teacherName != null && teacherName != ""){
        		url += "&tName="+encodeURI(encodeURI(teacherName));
        	}
        	if(name != null && name != ""){
        		url += "&name="+encodeURI(encodeURI(name));
        	}
        	if(num>0  && num <= max){
        		window.location.href=url;
        	}else{
        		toastr.warning("请输入正确的页码");
        		$("#searchPage").val("${currentPage}");
        	}
        }
        function setRecordId(id){
        	
        	$("#recordId").val(id);
            $('#myModal').modal('show');    
        }
        function showCreateModel(){
        	$('#myModal1').modal('show');   
        }
        function delRecord(){
        	debugger
        	var id= $("#recordId").val();
        	$.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/delProjectLecture.do", 
                data: {id:id},
                dataType: "json",
                success: function(data){
                	if(data.errcode == "-1"){
                		toastr.error(data.errmsg);
                	}else{
                		window.location.href=baseurl+"?page=${currentPage}";
                	}
                	
                }
            });
        }
        function insert(){
        	var id = $("#id").val();
        	if(id != null && id != ""){
        		$("#form1").attr('action',"${pageContext.request.contextPath}/editProjectLecture.action"); 
        	}
        	$("#form1").submit();
        }
        function reset(){
        	$("#searchName").val("");
        	$("#searchTName").val("");
        	$("#searchTime").val("");
        }
        function resetForm(){
        	document.getElementById("form1").reset();
        	$("#time").attr("value","");
        }
        function searchByName(){
        	var name = $("#searchName").val();
        	var teacherName = $("#searchTName").val();
        	var url = baseurl+"?name="+encodeURI(encodeURI(name));
        	if(teacherName != undefined){
        		url=url+"&tName="+encodeURI(encodeURI(teacherName));
        	}
        	var time = $("#searchTime").val();
        	if(time != undefined && time != ""){
        		time += "-01-01";
        		url =url+ "&time="+encodeURI(encodeURI(time));
        	}
			
        	window.location.href=url;
        	
        }
        
        
        Date.prototype.Format = function (fmt) { //author: meizz   
            var o = {  
                "M+": this.getMonth() + 1, //月份   
                "d+": this.getDate(), //日   
                "h+": this.getHours(), //小时   
                "m+": this.getMinutes(), //分   
                "s+": this.getSeconds(), //秒   
                "q+": Math.floor((this.getMonth() + 3) / 3), //季度   
                "S": this.getMilliseconds() //毫秒   
            };  
            if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
            for (var k in o)  
            if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));  
            return fmt;  
        }  
        
        
        function editTaskInfo(id){
        	
        	$.ajax({
                type: "post",
                url: "${pageContext.request.contextPath}/selectProjectLectureById.action", 
                data: {id:id},
                dataType: "json",
                success: function(data){
                	if(data.errcode == "-1"){
                		toastr.error(data.errmsg);
                	}else{
                		$("#id").val(data.data.id);
                		$("#name").val(data.data.name);

                		var date = data.data.time;
                		var time = new Date(date).Format("yyyy-MM-dd");    
                		$("#time").attr("value",time);
                		$("#academics").val(data.data.name);
                		
                		$('#myModal1').modal('show');   
                	}
                	
                }
            });
        }
        
        function excel(){
        	var url = "${pageContext.request.contextPath}/ProjectLectureExcel.action";
        	var name = $("#searchName").val();
        	
        	if(name != null && name != ""){
        		url += "?name="+encodeURI(encodeURI(name));
        	}else{
        		url += "?name=";
        	}
        	var teacherName = $("#searchTName").val();
        	if(teacherName != null && teacherName != ""){
        		url += "&tName="+encodeURI(encodeURI(teacherName));
        	}
        	var time = $("#searchTime").val();
        	if(time != undefined && time != ""){
        		time += "-01-01";
        		url =url+ "&time="+encodeURI(encodeURI(time));
        	}
        	window.location.href = url;
        }

        function downfile(filename){
                	
                	window.location.href = "${pageContext.request.contextPath}/down.action"+"?attach="+encodeURI(encodeURI(filename));
                }

        function listAttach(id){
                	$("#instanceId").val(id);
                	$.ajax({
                        type: "post",
                        url: "${pageContext.request.contextPath}/selectAllAttach.do", 
                        data: {instanceId:id},
                        dataType: "json",
                        success: function(data){
                        	if(data.errcode == "-1"){
                        		toastr.error(data.errmsg);
                        	}else{
        						console.log(data.listAttach);
        						$("#listAttach").html("");
        						for(var a=0;a<data.listAttach.length;a++){
        							$("#listAttach").append("<tr><td>"+data.listAttach[a].fileName+"</td><td>"+data.listAttach[a].type+"</td><td>"+"<a onclick='downfile(&quot;"+data.listAttach[a].fileName+"&quot;)'><i  class='glyphicon glyphicon-save'></i></a>"+"</td></tr>");
        							/* "<tr><td>"+${item1.fileName}+"</td><td>"+${item1.type}+'</td><td><a  onclick="downfile(&quot;${item1.fileName}&quot;)"><i  class="glyphicon glyphicon-save"></i></a></td></tr>') */
        						}
                        		$('#myModal2').modal('show');   
                        	}
                        	
                        }
                    });
                	
                }
    </script>
	<style type="text/css">
#main {
	margin-left: auto;
	margin-right: auto;
	width: 800px;
	height: 500px;
	border: 1px solid black;
}

.input-group {
	width: 100px;
	float: left;
}

#but1 {
	float: left;
}

#but2 {
	float: left;
}
#total{
	margin-left:50px;
}
#searchName{
	width:100px;
	float:right;
}
#searchTName{
	width:100px;
	float:right;
}
#toSearch{
	float:right;
}
#reset {
	float:right;
}
.seaName{
	font-size:16px;
	margin-top:5px;
	margin-right:10px;
	float:right;
}
#searchTimeDiv{
	float:right;
}
#searchTime{
	width:100px;
	float:right;
}
.navbar-default .navbar-brand,.navbar-default .navbar-brand:hover {
	color: #fff;
}
</style>

	<script type="text/javascript">
        $(function() {
            var uls = $('.sidebar-nav > ul > *').clone();
            uls.addClass('visible-xs');
            $('#main-menu').append(uls.clone());
        });
    </script>

	<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
	<!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

	<!-- Le fav and touch icons -->
	<link rel="shortcut icon" href="../assets/ico/favicon.ico">
	<link rel="apple-touch-icon-precomposed" sizes="144x144"
		href="../assets/ico/apple-touch-icon-144-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="114x114"
		href="../assets/ico/apple-touch-icon-114-precomposed.png">
	<link rel="apple-touch-icon-precomposed" sizes="72x72"
		href="../assets/ico/apple-touch-icon-72-precomposed.png">
	<link rel="apple-touch-icon-precomposed"
		href="../assets/ico/apple-touch-icon-57-precomposed.png">


	<!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
	<!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
	<!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
	<!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
	<!--[if (gt IE 9)|!(IE)]><!-->

	<!--<![endif]-->

	<%@include file="menu.jsp"%>
	
	<div class="sidebar-nav">
    <ul>
    <li><a href="#" data-target=".dashboard-menu" class="nav-header" data-toggle="collapse"><i class="fa fa-fw fa-dashboard"></i> 个人信息<i class="fa fa-collapse"></i></a></li>
    <li><ul class="dashboard-menu nav nav-list collapse">
            <li ><a href="${pageContext.request.contextPath}/goShowInfoPage.action"><span class="fa fa-caret-right"></span> 个人信息展示</a></li>
            <c:if test='${openAuthor == "true"}'>
            	 <li><a href="${pageContext.request.contextPath}/goShowAllTeacherInfoPage.action"><span class="fa fa-caret-right"></span> 教师信息展示</a></li>
            </c:if>
     <li><a href="${pageContext.request.contextPath}/goEditPwd.action"><span class="fa fa-caret-right"></span> 修改密码</a></li> 
    </ul></li>

    <li><a href="#" data-target=".premium-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-fw fa-fighter-jet"></i> 教学<i class="fa fa-collapse"></i></a></li>        <li><ul class="premium-menu nav nav-list collapse">
                <li class="visible-xs visible-sm"><a href="#">- Premium features require a license -</a></span>
            <li ><a href="${pageContext.request.contextPath}/goTeachingTask.action"><span class="fa fa-caret-right"></span> 教学任务</a></li>
            <li ><a href="${pageContext.request.contextPath}/goTaskCompany.action"><span class="fa fa-caret-right"></span> 校企合作任务</a></li>
            <li ><a href="${pageContext.request.contextPath}/goTaskGraduation.action"><span class="fa fa-caret-right"></span> 毕业综合实践项目</a></li>
            <li ><a href="${pageContext.request.contextPath}/goTaskDirectortournament.action"><span class="fa fa-caret-right"></span> 学科竞赛指导任务</a></li>
            <li ><a href="${pageContext.request.contextPath}/goTaskTutor.action"><span class="fa fa-caret-right"></span> 学业导师任务</a></li>
    </ul></li>

        <li><a href="#" data-target=".accounts-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-fw fa-briefcase"></i> 科研 <i class="fa fa-collapse"></i></a></li>
        <li><ul class="accounts-menu nav nav-list collapse in">
            <li ><a href="${pageContext.request.contextPath}/goProjectPublish.action"><span class="fa fa-caret-right"></span> 发表文献</a></li>
            <li ><a href="${pageContext.request.contextPath}/goProjectPerson.action"><span class="fa fa-caret-right"></span> 人才工程项目</a></li>
            <li ><a href="${pageContext.request.contextPath}/goProjectSocialservice.action"><span class="fa fa-caret-right"></span> 服务社会成果</a></li>
            <li class="active"><a href="${pageContext.request.contextPath}/goProjectLecture.action"><span class="fa fa-caret-right"></span> 学术讲座论坛</a></li>
    </ul></li>

        <!-- <li><a href="#" data-target=".legal-menu" class="nav-header collapsed" data-toggle="collapse"><i class="fa fa-fw fa-legal"></i>荣誉奖励<i class="fa fa-collapse"></i></a></li>
        <li><ul class="legal-menu nav nav-list collapse">
            <li ><a href="privacy-policy.html"><span class="fa fa-caret-right"></span> 荣誉奖励列表</a></li>
            <li ><a href="terms-and-conditions.html"><span class="fa fa-caret-right"></span> 荣誉奖励新增</a></li>
            <li ><a href="terms-and-conditions.html"><span class="fa fa-caret-right"></span> 荣誉奖励修改</a></li>
    </ul></li> -->

        
            </ul>
    </div>

	<div class="content">
		<div class="btn-toolbar list-toolbar">
			<button class="btn btn-primary" onclick="showCreateModel()">
				<i class="fa fa-plus"></i> 新增
			</button>
			<button class="btn btn-default" onclick="excel()">导出</button>
			<button id="reset" class="btn btn-default" onclick="reset()">重置</button>
			<button id="toSearch" class="btn btn-primary" onclick="searchByName()">查询</button>
			<div  id="searchTimeDiv" class="input-group date form_date col-md-5" data-date="" data-date-format="dd MM yyyy" data-link-field="dtp_input2" data-link-format="yyyy-mm-dd">
                    <input id="searchTime" class="form-control" size="16" type="text" value="${searchTime }" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
					<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
 
            <label class="seaName">时间:</label>
			
			<input type="text" id="searchName" name="searchName" class="form-control" value="${searchName }"/>
			<label class="seaName">项目名:</label>
			<c:if test='${openAuthor == "true"}'>
				<input type="text" id="searchTName" name="searchTName" class="form-control" value="${searchTName }"/>
				<label class="seaName">姓名:</label>
			</c:if>
		</div>
		<div id="info">
			<table class="table">
				<thead>
					<tr>
						<c:if test='${openAuthor == "true"}'>
							<th>教师姓名</th>
						</c:if>
						<th>学术讲座名称</th>
						<th>学术讲座时间</th>
						<th>学术讲座人员</th>

						<th style="width: 3.5em;"></th>
					</tr>
				</thead>
				<tbody>
	
					<c:forEach items="${list}" var="item">
						<tr>
							<c:if test='${openAuthor == "true"}'>
								<td>${item.tName}</td>
							</c:if>
							<td>${item.name}</td>
							<td><fmt:formatDate value="${item.time}" type="date" pattern="yyyy-MM-dd"/></td>
							<td>${item.academics}</td>
							<td><a onclick="editTaskInfo(${item.id})"><i class="fa fa-pencil"></i></a> <a onclick="setRecordId(${item.id})"><i
									class="fa fa-trash-o"></i></a><a onclick="listAttach(&quot;${item.attach}&quot;);">&nbsp;&nbsp;<i class="glyphicon glyphicon-paperclip"></i></a></td>
						</tr>
					</c:forEach>
	
	
				</tbody>
			</table>
			<div class="pagination">
				<button id="but1" type="button" class="btn btn-primary"
					data-toggle="button" onclick="up()">&laquo;</button>
	
				<div class="input-group">
					<input type="text" id="searchPage" class="form-control"
						value="${currentPage}" /> <span class="input-group-btn">
						<button id="but3" class="btn btn-default" type="button"
							onclick="search()">Go!</button>
					</span>
				</div>
				<!-- /input-group -->
	
				<button id="but2" type="button" class="btn btn-primary"
					data-toggle="button" onclick="down()">&raquo;</button>
				 
				<span id="total" class="btn btn-primary">${userNum}条，共${pageTimes}页</span>
			</div>
		</div>	
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal small fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3 id="myModalLabel">删除</h3>
				</div>
				<div class="modal-body">
					<input type="hidden" id="recordId"/>
					<p class="error-text">
						<i class="fa fa-warning modal-icon"></i>确定删除？
					</p>
				</div>
				<div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal"
						aria-hidden="true">取消</button>
					<button class="btn btn-danger" onclick="delRecord()">删除</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="modal small fade" id="myModal1" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
		<div class="modal-dialog" style="width: 700px;height:250px;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true" onclick="resetForm()">×</button>
					<h3 id="myModalLabel">校企合作任务</h3>
				</div>
				<div class="modal-body">
				<div style="height:300px;width:500px,overflow:auto; ">
					<form id="form1" action="${pageContext.request.contextPath}/saveProjectLecture.action"
			method="post" enctype="multipart/form-data">
			<table id="table1"
				class="table table-striped table-bordered table-condensed list">
				<tbody>
					<tr>
						
						<td width="30%">学术讲座名称<font color="FF0000">*</font></td>
						<td width="500"><input id="name" name="name" type="text"
							value="" /></td>

					</tr>
					
					<tr>
						<td>学术讲座时间<font color="FF0000">*</font></td>
						<td><input id="time" name="time"
							type="date" value="" /></td>

					</tr>
					<tr>
						<td>学术讲座人员<font color="FF0000">*</font></td>
						<td><input id="academics" name="academics"
							type="text" value="" /></td>

					</tr>
		
					
					

				</tbody>
				<input id="tId" name="tId" value="${userinfo.tId}" type="hidden" />
				<input id="tName" name="tName" value="${userinfo.tName}" type="hidden" />
				<input id="id" name="id" value="" type="hidden"/>
			</table>
		</form>
		</div>
				</div>
				<div class="modal-footer">
					
					<button class="btn btn-default" data-dismiss="modal"
						aria-hidden="true" onclick="resetForm()">取消</button>
					<button class="btn btn-primary" onclick="insert()">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 模态框（Modal） -->
	<div class="modal fade" id="myModal2" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
			<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
					<h3 id="myModalLabel">所有附件</h3>
				</div>
				<div class="modal-body" >
					<table class="table" >
				<thead>
				<form id="form2" action="${pageContext.request.contextPath}/uploadAttach9.action" method="post" enctype="multipart/form-data">
					<tr>
						<td><input id="attach1" name="file"
							type="file" value="" multiple=”multiple”/>
						</td>
						<td>
							<input id="instanceId" name="instanceId" value="" type="hidden"/>
							
							<button class="btn btn-primary" type="submit">保存</button>
						</td>

					</tr>
				</form>
					<tr>
						<th >文件名</th>
						<th>类型</th>
						
						<th style="width: 3.5em;"></th>
					</tr>
				</thead>
				<tbody id="listAttach">
	
					
	
				</tbody>
			</table>
				</div>
				<!-- <div class="modal-footer">
					<button class="btn btn-default" data-dismiss="modal"
						aria-hidden="true">取消</button>
					<button class="btn btn-danger" onclick="delRecord()">删除</button>
				</div> -->
				
			</div>
		</div>
	</div>
	
	<script src="lib/bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript">
	$('.form_date').datetimepicker({
		startView: 'decade',  
        minView: 'decade',  
        format: 'yyyy',  
        maxViewMode: 2,  
        minViewMode:2,  
         autoclose: true  
    });
		if("${userinfo.sex}" == "1"){
			$("#male").click()
		}else{
			$("#female").click()
		}
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
        function toAction(){
        	$("#form1").submit();
        }
    </script>


</body>
</html>
