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

	function func(type) {
	    if (type == "添加") {

		}
	}

	/**
	 * 创建表格
	 * @param width 宽度
	 * @param height 高度
	 * @param line 列数
	 * @param arr 表内数据
	 * @param type button 类型名
	 */
	function createTable(width, height, line, arr, type) {
	    var table = document.createElement("table");
	    var tbody = document.createElement("tbody");

	    table.style.width = width;
	    table.style.height = height;
	    table.style.border = 4;

	    var but;
	    var td;

	    for (var i = 0; i < arr.length; i++) {
	    	var tr = document.createElement("tr");
	    	for (var j = 0; j < line; ++j) {
	    	    td = document.createElement("td");
	    	    but = document.createElement("input");
	    	    but.type = "button";
	    	    but.value = type;
	    	    but.addEventListener("click", func);
				but.setAttribute("onmouseover","style.backgroundColor='#A9A9A9'");
				but.setAttribute("onmouseout","style.backgroundColor='#9ACD32'");
				but.style.color = "white";
				but.style.fontSize = "12px";
				but.style.backgroundColor = "#9ACD32";
				but.style.borderColor = "#D3D3D3";
				but.style.cursor = "pointer";
				but.style.margin = "7px 80px 7px 80px";
				but.style.width = "75px";
				but.style.height = "25px";


	    		if (j == 0) {
	    		    td.innerHTML = "科目";
	    		    td.style.textAlign = "center";
	    		    td.style.color = "#292929";
	    		    td.style.width = "200px"
				} else if (j == 1) {
	    		    td.innerHTML = arr[i];
					td.style.textAlign = "center";
					td.style.color = "#292929";
					td.style.width = "260px"
				}
	    		tr.appendChild(td);
			}
	    	td.appendChild(but);
	    	tbody.appendChild(tr);
		}
	    table.appendChild(tbody);
	    tbody.style.backgroundColor = "#F0FBCD";
	    table.style.margin = "46px 120px";
	    return table;
	}

	function loadXMLDoc(e) {
	    $("#myDiv").empty();
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
					/**
					 * 这个 result 是一个 String,里面的各种科目是由 '\3' 分隔
					 * @type {string}
					 */
					var result = xmlhttp.responseText;
					if (result == "nosubjects") {
						document.getElementById("myDiv").innerHTML="好学的你已经选择了所有课程哦！";
					    return;
					}
					var arr = result.split("\3");
					/**
					 * arr.length 就可以获取到分隔后的元素每一个元素就是一个科目
					 * @type {string}
					 */
					var type = "添加 +";
					var table = createTable(700, 130, 3, arr, type);
					document.getElementById("myDiv").innerHTML="以下课程可选择:";
					$("#myDiv").append(table);
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