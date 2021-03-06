<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<html lang="en"><head>
    <meta charset="utf-8">
    <title>教师信息系统</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700' rel='stylesheet' type='text/css'>
    <link rel="stylesheet" type="text/css" href="lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="lib/font-awesome/css/font-awesome.css">

    <script src="lib/jquery-1.11.1.min.js" type="text/javascript"></script>

    

    <link rel="stylesheet" type="text/css" href="stylesheets/theme.css">
    <link rel="stylesheet" type="text/css" href="stylesheets/premium.css">
    
    <link href="stylesheets/toastr.min.css" rel="stylesheet" />
	<script src="js/toastr.min.js"></script>

</head>
<body class=" theme-blue">

    <!-- Demo page code -->

    <script type="text/javascript">
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
        function showHidePwd(){
        	if (this.forms.password.type=="password") {
        	      document.getElementById("pwd").innerHTML="<input id=\"password\" type=\"text\" name=\"password\" class=\"form-controlspan12 form-control\" value="+this.forms.password.value+">";
        	      document.getElementById("eye").innerHTML="<span class=\"glyphicon glyphicon-eye-close\" onclick=\"showHidePwd()\" aria-hidden=\"true\"></span>"
        	}else {
        		  document.getElementById("pwd").innerHTML="<input id=\"password\" type=\"password\" name=\"password\" class=\"form-controlspan12 form-control\" value="+this.forms.password.value+">";
      	      	  document.getElementById("eye").innerHTML="<span class=\"glyphicon glyphicon-eye-open\" onclick=\"showHidePwd()\" aria-hidden=\"true\"></span>"
        	}
        };
        
        function submit1(){
        	debugger
        	var tName = $("#tName").val();
        	var password = $("#password").val();
        	var schoolYear = $("#schoolYear").val();
        	var certificateNumber = $("#certificateNumber").val();
        	var sex = $('input:radio[name="sex"]:checked').val();
        	
        	var date = new Date(schoolYear);
        	
        	
        	if(tName == undefined || tName == ""){
        		toastr.warning("姓名不能为空");
        		return;
        	};
        	if(!tName.match("^[\u4e00-\u9fa5]+(·[\u4e00-\u9fa5]+)*$")){
        		toastr.warning("姓名格式不正确");
        		return;
        	};
        	if(password == undefined || password == ""){
        		toastr.warning("密码不能为空");
        		return;
        	};
        	if(schoolYear == undefined || schoolYear == ""){
        		toastr.warning("入学年份不能为空");
        		return;
        	};
        	if(certificateNumber == undefined || certificateNumber == ""){
        		toastr.warning("身份证号码不能为空");
        		return;
        	};
        	$.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/checkNum.do",
                data: {certificateNumber:$("#certificateNumber").val()},
                dataType: "json",
                success: function(data){
                	if(data.errcode == "-1"){
                		toastr.error(data.errmsg);
                		return;
                	}else{
                		$.ajax({
                            type: "post",
                            url: "${pageContext.request.contextPath}/register.do", 
                            data: {tName:tName,password:password,schoolYear:date,certificateNumber:certificateNumber,sex:sex},
                            dataType: "json",
                            success: function(data){
                            	if(data.errcode == "-1"){
                            		toastr.error(data.errmsg);
                            	}
                            	
                            }
                        });
                	}
                	
                }
            });
        	
        	
        };
        function checkNum(){
        	
        	$.ajax({
                type: "get",
                url: "${pageContext.request.contextPath}/checkNum.do",
                data: {certificateNumber:$("#certificateNumber").val()},
                dataType: "json",
                success: function(data){
                	if(data.errcode == "-1"){
                		toastr.error(data.errmsg);
                		return;
                	}
                	
                }
            });
        }
        
    </script>
    <style type="text/css">
    	.form-group{
    		height:59px;
    	}
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .navbar-default .navbar-brand, .navbar-default .navbar-brand:hover { 
            color: #fff;
        }
        
        #eye{
        	float:right;
        	padding-top: 10px;
        }
        #password{
        	width:95%;
        	float:left
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
    <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../assets/ico/apple-touch-icon-114-precomposed.png">
    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../assets/ico/apple-touch-icon-72-precomposed.png">
    <link rel="apple-touch-icon-precomposed" href="../assets/ico/apple-touch-icon-57-precomposed.png">
  

  <!--[if lt IE 7 ]> <body class="ie ie6"> <![endif]-->
  <!--[if IE 7 ]> <body class="ie ie7 "> <![endif]-->
  <!--[if IE 8 ]> <body class="ie ie8 "> <![endif]-->
  <!--[if IE 9 ]> <body class="ie ie9 "> <![endif]-->
  <!--[if (gt IE 9)|!(IE)]><!--> 
   
  <!--<![endif]-->

    <div class="navbar navbar-default" role="navigation">
        <div class="navbar-header">
          <a class="" href="index.html"><span class="navbar-brand"><span class="fa fa-paper-plane"></span> 教师信息系统</span></a></div>

        <div class="navbar-collapse collapse" style="height: 1px;">

        </div>
      </div>
    </div>
    


        <div class="dialog">
    <div class="panel panel-default">
        <p class="panel-heading no-collapse">注册</p>
        <div class="panel-body">
            <form name="forms" action="${pageContext.request.contextPath}/register.do" method="post">
                <div class="form-group">
                    <label>用户名</label>
                    <input type="text" id="tName" name="tName" class="form-controlspan12 form-control">
                </div>
                <div class="form-group">
                    <label>密码</label>
                   
                    <div>
                    	<div id="pwd"><input id="password" type="password" name="password" class="form-controlspan12 form-control"></div>
                    	<div id="eye"><span class="glyphicon glyphicon-eye-open" onclick="showHidePwd()" aria-hidden="true"></span></div>
                    </div>
                     
                </div>
                <div class="form-group">
                    <label>入校年份</label>
                    <input type="date" id="schoolYear" name="schoolYear" class="form-controlspan12 form-control"/>
                </div>
                <div class="form-group">
                    <label>身份证号码</label>
                    <input type="text" name="certificateNumber" id="certificateNumber" onchange="checkNum()"  class="form-controlspan12 form-control"/>
                </div>
                <div class="form-group">
                    <label>性别</label><br/>
                    <input type="radio" name="sex"  value="1" checked> 男
                    <input type="radio" name="sex"  value="2">女
                </div>
                <input type="button" class="btn btn-primary pull-right"  onclick="submit1()" value="注册"/>
                <div class="clearfix"></div>
            </form>
        </div>
    </div>
    <a href="sign-in.html" style="font-size: .75em; margin-top: .25em;">已有账号，去登陆</a>
</div>



    <script src="lib/bootstrap/js/bootstrap.js"></script>
    <script type="text/javascript">
   		toastr.options.positionClass = 'toast-bottom-center';
        $("[rel=tooltip]").tooltip();
        $(function() {
            $('.demo-cancel-click').click(function(){return false;});
        });
        
    </script>
    
  
</body></html>
