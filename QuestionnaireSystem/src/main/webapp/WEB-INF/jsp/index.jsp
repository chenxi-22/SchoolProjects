<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title></title>
</head>

<!--图标样式-->
<link rel="stylesheet" type="text/css" href="css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="css/skins/_all-skins.css">

<link rel="stylesheet" href="css/index.css" />
<script type="text/javascript">
	function loadXMLDoc() {
    	document.getElementById("myDiv").innerHTML="hehe"
	}
</script>

<body>

		<div class="t-side">
			<p class="b">课程质量问卷调查系统</p>
		</div>
		<div class="l-side" id="myDiv">hhhhhhhhhh</div>

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
					<button class="but" onclick="loadXMLDoc()" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">添加选课信息</button>
				</li>
				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" onclick="loadXMLDoc()" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">删除选课信息</button>
				</li>
				
				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" onclick="loadXMLDoc()" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">查看所选课程</button>
				</li>

				<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" onclick="loadXMLDoc()" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">浏览问卷</button>
				</li>
					<li class="s-secondItem">
					<i class="fa fa-minus-square-o"></i>
					<button class="but" onclick="loadXMLDoc()" onmouseover="this.style.backgroundColor='#A9A9A9';"onmouseout="this.style.backgroundColor='#292929';">查看问卷结果</button>
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