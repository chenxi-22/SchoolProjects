<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>课程质量问卷调查系统</title>
</head>

<!--图标样式-->
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/skins/_all-skins.css">

<link rel="stylesheet" href="css/index.css" />
<script type="text/javascript">
	function loadXMLDoc(e) {
		document.getElementById("myDiv").innerHTML="hehe"
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
		if (type == "loadsubjects") {
			xmlhttp.onreadystatechange=function()
			{

				document.getElementById("myDiv").innerHTML=type;
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{

					var result = xmlhttp.responseText;
					document.getElementById("myDiv").innerHTML=result;
				} else {
					document.getElementById("myDiv").innerHTML=xmlhttp.responseText;
				}
			}
			xmlhttp.open("GET","/loadsubjects",false);
			xmlhttp.send();
		} else if (type == "pressnaires") {
			document.getElementById("myDiv").innerHTML=type;
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var result = xmlhttp.responseText;
					document.getElementById("myDiv").innerHTML=result;
				}
			}
			xmlhttp.open("GET", "/pressnaires", false);
			xmlhttp.send();
		} else if (type == "addnaires") {
			document.getElementById("myDiv").innerHTML=type;
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var result = xmlhttp.responseText;
					document.getElementById("myDiv").innerHTML=result;
				}
			}
			xmlhttp.open("GET", "/addnaires", false);
			xmlhttp.send();
		} else if (type == "getResultCount") {
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var result = xmlhttp.responseText;
					document.getElementById("myDiv").innerHTML=result;
				}
			}
			xmlhttp.open("GET", "/getResultCount", false);
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
			xmlhttp.open("GET", "/questionmanager", false);
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
				<span>教师管理</span>
			</a>
		</li>

		<li class="first">
				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="loadsubjects" onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">导入选课信息</button>
				</li>
				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="pressnaires" onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">催交问卷</button>
				</li>
				
				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="addnaires" onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">添加问卷</button>
				</li>

				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="getResultCount"  onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">问卷结果统计</button>
				</li>
					<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" data-type="questionmanager" onclick="loadXMLDoc(this)" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">题目添加管理</button>
				</li>


		</li>
	</ul>
</div>
	
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="js/index.js" ></script>
<div style="text-align:center;">
</div>
</body>	
</html>