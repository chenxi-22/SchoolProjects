<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
	<title>课程质量问卷调查系统</title>
	<meta charset="utf-8" />
</head>

<!--图标样式-->
<link rel="stylesheet" type="text/css" href="/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="/css/skins/_all-skins.css">

<link rel="stylesheet" href="/css/index.css" />
<script type="text/javascript">
	function loadXMLDoc(e) {
		var type=e.getAttribute("data-type");
		var xmlhttp;
		if (window.XMLHttpRequest)
		{
			// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp=new XMLHttpRequest();
		}
		else
		{
			// IE6, IE5 浏览器执行代码
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		/**
		 * 分流
		 */
		if (type == "canchoose") {
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var result = xmlhttp.responseText;
					arr = result.split("\3");
					display = arr[0] + "\r" + arr[1] + "\r" + arr[2];
					document.getElementById("myDiv").innerHTML=display;
				}
			}
			xmlhttp.open("GET","/canadd",false);
			xmlhttp.send();
		} else if (type == "delete") {
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var result = xmlhttp.responseText;
					document.getElementById("myDiv").innerHTML=result;
				}
			}
			xmlhttp.open("GET", "/choosed", false);
			xmlhttp.send();
		} else if (type == "choosed") {
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var result = xmlhttp.responseText;
					document.getElementById("myDiv").innerHTML=result;
				}
			}
			xmlhttp.open("GET", "/choosed", false);
			xmlhttp.send();
		} else if (type == "see") {
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var result = xmlhttp.responseText;
					document.getElementById("myDiv").innerHTML=result;
				}
			}
			xmlhttp.open("GET", "/choosed", false);
			xmlhttp.send();
		} else {
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var result = xmlhttp.responseText;
					document.getElementById("myDiv").innerHTML=result;
				}
			}
			xmlhttp.open("GET", "/choosed", false);
			xmlhttp.send();
		}
	}
</script>

<body>

		<div class="t-side">
			<p class="b">课程质量问卷调查系统</p>
		</div>
		<div class="l-side" id="myDiv">首页显示</div>

<div class="s-side">
	<ul>
		<!--这部分是导航栏信息。-->
		<li class="s-firstItem first">
				<i class="fa fa-home"></i>
				<span>学生管理</span>
			</a>
		</li>

		<li class="first">
				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="canchoose" onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">添加选课信息</button>
				</li>
				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="delete" onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">删除选课信息</button>
				</li>
				
				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="choosed" onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">查看所选课程</button>
				</li>

				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="see" onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">浏览问卷</button>
				</li>
					<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="result" onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">查看问卷结果</button>
				</li>


		</li>
	</ul>
</div>
	
<script type="text/javascript" src="/js/jquery.min.js"></script>
<script type="text/javascript" src="/js/index.js" ></script>
<div style="text-align:center;">
</div>
</body>	
</html>