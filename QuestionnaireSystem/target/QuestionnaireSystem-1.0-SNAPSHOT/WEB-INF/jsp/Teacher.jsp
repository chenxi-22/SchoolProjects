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


	function pressNaire(id, arr) {
		var subject = arr[id];
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
		xmlhttp.onreadystatechange=function()
		{
			var result = xmlhttp.responseText;
			//alert("hehehehe");
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				var result = xmlhttp.responseText;
				alert("催缴");

				if (result == "false") {
					alert("催缴失败！");
					return;
				}
				alert("催缴成功！");
				document.getElementById("myDiv").innerHTML="催缴成功！";
			} else {

				document.getElementById("myDiv").innerHTML="催缴失败！";
			}
		}
		// 发送 GET 请求，带参数 subject
		xmlhttp.open("GET","/pressNaire?subject=" + subject, false);
		xmlhttp.send();
	}

	function addNaire(id, arr) {
		var subject = arr[id];
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
		xmlhttp.onreadystatechange=function()
		{
			var result = xmlhttp.responseText;
			//alert("hehehehe");
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				var result = xmlhttp.responseText;
				alert("添加问卷");

				if (result == "false") {
					alert("添加失败！");
					return;
				}
				alert("添加成功！");
				document.getElementById("myDiv").innerHTML="催缴成功！";
			} else {

				document.getElementById("myDiv").innerHTML="催缴失败！";
			}
		}
		// 发送 GET 请求，带参数 subject
		xmlhttp.open("GET","/pressNaire?subject=" + subject, false);
		xmlhttp.send();
	}

	function getResultCount(id, arr) {
		var subject = arr[id];
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
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				var result = xmlhttp.responseText;
				alert("统计结果");

				if (result == "false") {
					alert("统计失败！");
					return;
				}
				alert("统计成功！");
				document.getElementById("myDiv").innerHTML="统计成功！";
			} else {

				document.getElementById("myDiv").innerHTML="统计失败！";
			}
		}
		// 发送 GET 请求，带参数 subject
		xmlhttp.open("GET","/pressNaire?subject=" + subject, false);
		xmlhttp.send();
	}
	/**
	 * 创建表格
	 * @param width 宽度
	 * @param height 高度
	 * @param line 列数
	 * @param arr 表内数据
	 * @param type button 类型名
	 */
	function createTableWithoutButton(width, height, line, arr) {
		var table = document.createElement("table");
		var tbody = document.createElement("tbody");
		table.style.width = width;
		table.style.height = height;
		table.style.border = 4;
		var td;

		for (var i = 0; i < arr.length; i++) {
			var tr = document.createElement("tr");
			for (var j = 0; j < line; ++j) {
				td = document.createElement("td");

				var tmparr = arr[i].split(":");
				if (j == 0) {
					td.innerHTML = tmparr[0];
					td.style.textAlign = "center";
					td.style.color = "#292929";
					td.style.width = "200px";
					td.style.fontSize = "20px"
				} else if (j == 1) {
					td.innerHTML = tmparr[1];
					td.style.textAlign = "center";
					td.style.color = "#292929";
					td.style.fontSize = "20px"
					td.style.width = "500px"
				}
				tr.appendChild(td);
			}
			tbody.appendChild(tr);
		}
		table.appendChild(tbody);
		tbody.style.backgroundColor = "#F0FBCD";
		table.style.margin = "46px 120px";
		return table;
	}

	/**
	 * 创建表格
	 * @param width 宽度
	 * @param height 高度
	 * @param line 列数
	 * @param arr 表内数据
	 * @param type button 类型名
	 */
	function createTable(width, height, line, arr, type, flag) {
		var table = document.createElement("table");
		var tbody = document.createElement("tbody");
		table.style.width = width;
		table.style.height = height;
		table.style.border = 4;
		var td;
		for (var i = 0; i < arr.length; i++) {
			var tr = document.createElement("tr");
			for (var j = 0; j < line; ++j) {
				td = document.createElement("td");
				var but = document.createElement("input");
				but.type = "button";
				but.value = type;
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
				// js 的闭包问题，需要注意，必须以下面的解法来解决闭包问题
				(function(i){
					but.onclick = function() {
						if(flag == 0)//催缴问卷
						{
							pressNaire(i, arr);
						}
						else if(flag == 1) //添加问卷
						{
							addNaire(i, arr);
						}
						else if(flag == 2) //统计结果
						{
							getResultCount(i, arr);
						}
						else if(flag == 3) //
						{

						}


					}
				})(i);
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
		if (type == "loadsubjects") {
			xmlhttp.onreadystatechange=function()
			{
				/**
				 * 这个 result 是一个 String,科目与学生名单间用':'分隔
				 * 学生与学生之间用'\3'分隔，每行之间用'\4'分隔
				 * @type {string}
				 */
				var result = xmlhttp.responseText;
				result.replace(/\3/g, ",");
				var allrow = result.split("\4");


				var table = createTableWithoutButton(700, 130, 2, allrow);
				document.getElementById("myDiv").innerHTML="所有选课信息如下";
				$("#myDiv").append(table);

			}
			xmlhttp.open("GET","/loadsubjects",false);
			xmlhttp.send();
		} else if (type == "pressnaires") {
			document.getElementById("myDiv").innerHTML=type;
			xmlhttp.onreadystatechange=function()
			{
				/**
				 * 这个 result 是一个 String,里面的各种科目是由 '\3' 分隔
				 * @type {string}
				 */
				var result = xmlhttp.responseText;

				var arr = result.split("\3");
				/**
				 * arr.length 就可以获取到分隔后的元素每一个元素就是一个科目
				 * @type {string}
				 */
				var type = "催缴 +";
				var table = createTable(700, 130, 3, arr, type, 0);
				document.getElementById("myDiv").innerHTML="选择需要催缴的课程:";
				$("#myDiv").append(table);
			}
			xmlhttp.open("GET", "/pressnaires", false);
			xmlhttp.send();
		} else if (type == "addnaires") {
			document.getElementById("myDiv").innerHTML=type;
			xmlhttp.onreadystatechange=function()
			{
				/**
				 * 这个 result 是一个 String,里面的各种科目是由 '\3' 分隔
				 */
				var result = xmlhttp.responseText;

				var arr = result.split("\3");
				/**
				 * arr.length 就可以获取到分隔后的元素每一个元素就是一个科目
				 */
				var type = "添加 +";
				var table = createTable(700, 130, 3, arr, type, 1);
				document.getElementById("myDiv").innerHTML="选择需要添加问卷的课程:";
				$("#myDiv").append(table);
			}
			xmlhttp.open("GET", "/addnaires", false);
			xmlhttp.send();
		} else if (type == "getResultCount") {
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					/**
					 * 这个 result 是一个 String,里面的各种科目是由 '\3' 分隔
					 */
					var result = xmlhttp.responseText;

					var arr = result.split("\3");
					/**
					 * arr.length 就可以获取到分隔后的元素每一个元素就是一个科目
					 */
					var type = "统计 +";
					var table = createTable(700, 130, 3, arr, type, 2);
					document.getElementById("myDiv").innerHTML="选择需要统计结果的课程:";
					$("#myDiv").append(table);
				}
			}
			xmlhttp.open("GET", "/getResultCount", false);
			xmlhttp.send();
		} else {
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					/**
					 * 这个 result 是一个 String,里面的各种科目是由 '\3' 分隔
					 */
					var result = xmlhttp.responseText;

					var arr = result.split("\3");
					/**
					 * arr.length 就可以获取到分隔后的元素每一个元素就是一个科目
					 */
					var type = "guan +";
					var table = createTable(700, 130, 3, arr, type, 3);
					document.getElementById("myDiv").innerHTML="选择需要管理题目的课程:";
					$("#myDiv").append(table);
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