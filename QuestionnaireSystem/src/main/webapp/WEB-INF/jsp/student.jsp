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

	function createNaireTable(width, height, line, arr) {
		var table = document.createElement("table");
		var tbody = document.createElement("tbody");

		table.style.width = width;
		table.style.height = height;
		table.style.border = 4;

		var td;

		for (var i = 0; i < arr.length + 1; i++) {
			var tr = document.createElement("tr");
			for (var j = 0; j < line; ++j) {
				td = document.createElement("td");
				var rd;
				var rd2;
				if (j == 0) {
					if (i == 0) {
						td.innerHTML = "问题";
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.width = "580px"
					} else {
						td.innerHTML = i + "." + arr[i - 1];
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.width = "500px"
					}
				} else if (j == 1) {
					if (i == 0) {
						td.innerHTML = "是"
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.width = "60px"
					} else {
						rd = document.createElement("input");
						rd.type = "checkbox";
						rd.value = "是";
						rd.id = "yes";
						rd.style.margin = "7px 70px 7px 70px";
						td.appendChild(rd);
					}
				} else if (j == 2) {
					if (i == 0) {
						td.innerHTML = "否"
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.width = "60px"
					} else {
						rd2 = document.createElement("input");
						rd2.type = "checkbox";
						rd2.value = "否";
						rd2.id = "no";
						rd2.style.margin = "7px 70px 7px 70px";
						td.appendChild(rd2);
					}

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

	function seeNaire(i, arr) {
	    $.ajax({
			type: 'POST',
			url: '/see',
			data: { subject: arr[i] },
            // contentType: "text/html;charset=UTF-8",
			success: function (result) {
				$("#myDiv").empty();
				if (result == "nonaires") {
					$("#myDiv").get(0).innerHTML = "该科目还没有问卷哦！";
					return;
				}

				arr = result.split("\3");
				var table = createNaireTable(700, 140, 3, arr);
				document.getElementById("myDiv").innerHTML="问卷问题如下:";
				$("#myDiv").append(table);
			},
			error:function(result) {
			    alert("failed");
			}
		});
	}

	function seeResult(i, arr) {
		alert(arr[i] + "结果");
	}

	function deleteSubject(id, arr) {
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
				$("#myDiv").empty();
				if (result == "nosubjects") {
					document.getElementById("myDiv").innerHTML="还没有选择任何课程哦！快去选课吧！";
					return;
				}

				alert("删除成功！");
				var arr = result.split("\3");
				var type = "删除 -";
				var table = createTable(700, 130, 3, arr, type);
				document.getElementById("myDiv").innerHTML="以下课程可删除:";
				$("#myDiv").append(table);
			}
		}
		// 发送 GET 请求，带参数 subject
		var url = "/delete?subject=" + subject + "&t=" + Math.random();
		xmlhttp.open("GET", url, false);
		xmlhttp.send();
	}

	function addSubject(id, arr) {
		$.ajax({
			type: 'POST',
			url: '/add',
			data: { subject: arr[id] },
			success: function (result) {
			    alert("添加成功");
				$("#myDiv").empty();
				if (result == "nosubjects") {
					document.getElementById("myDiv").innerHTML="好学的你已经选了所有的课程了呢！";
					return;
				}
				var arr = result.split("\3");
				var type = "添加 +";
				var table = createTable(700, 130, 3, arr, type);
				document.getElementById("myDiv").innerHTML="以下课程可添加:";
				$("#myDiv").append(table);
			},
			error:function(result) {
			    alert(result);
			}
		});
	}

	function createChooseTable(width, height, line, arr) {
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
	function createTable(width, height, line, arr, type) {
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
				    	if (type == "添加 +") {
							addSubject(i, arr);
						} else if (type == "删除 -") {
				    		deleteSubject(i, arr);
						} else if (type == "浏览") {
				    	    seeNaire(i, arr);
						} else if (type == "查看结果") {
				    	    seeResult(i, arr);
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
			xmlhttp.open("GET","/canadd?t=" + Math.random(),false);
			xmlhttp.send();
		} else if (type == "delete") {
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					var result = xmlhttp.responseText;
					if (result == "nosubjects") {
						document.getElementById("myDiv").innerHTML="还没有选择任何课程哦！快去选课吧！"
						return;
					}
					var arr = result.split("\3");
					/**
					 * arr.length 就可以获取到分隔后的元素每一个元素就是一个科目
					 * @type {string}
					 */
					var type = "删除 -";
					var table = createTable(700, 130, 3, arr, type);
					document.getElementById("myDiv").innerHTML="以下课程可删除:";
					$("#myDiv").append(table);
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
					if (result == "nosubjects") {
						document.getElementById("myDiv").innerHTML="还没有选择任何课程呢，快去选课哦！";
						return;
					}
					var arr = result.split("\3");
					var table = createChooseTable(700, 130, 2, arr);
					document.getElementById("myDiv").innerHTML="以下课程已经选择:";
					$("#myDiv").append(table);
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
					if (result == "nosubjects") {
						document.getElementById("myDiv").innerHTML="还没有选择任何课程呢，怎么会有问卷呢?";
						return;
					}
					var arr = result.split("\3");
					var type = "浏览";
					var table = createTable(700,130, 3, arr, type);
					document.getElementById("myDiv").innerHTML="下面的问卷可以浏览:";
					$("#myDiv").append(table);
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
					if (result == "nosubjects") {
						document.getElementById("myDiv").innerHTML="还没有选择任何课程呢，是看不到别的同学回答的结果的?";
						return;
					}
					var arr = result.split("\3");
					var type = "查看结果";
					var table = createTable(700,130, 3, arr, type);
					document.getElementById("myDiv").innerHTML="下面的问卷可查看结果:";
					$("#myDiv").append(table);
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
		<div class="l-side" id="myDiv">以下课程的问卷需要及时填写哦!
			<br>
			${list}
		</div>

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