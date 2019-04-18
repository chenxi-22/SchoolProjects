<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

	function SubmitQuestion(Question, subject) {
		$.ajax({
			type: 'POST',
			url: '/add2',
			data: { subject: subject,
				ques : Question
			},
			success: function (result) {
			    if (result == "faild") {
			    	alert("问卷上传失败！");
			    	return;
				}

				alert("问卷上传成功！");
				var arr = result.split("\3");
				var type = "添加 +";
				var table = createTable(700, 130, 3, arr, type, 1);
				document.getElementById("myDiv").innerHTML="选择需要添加问卷的课程:";
				$("#myDiv").append(table);
			    return;
			},
			error:function(result) {
				alert("failed");
			}

		})
	}

	function addNaire(subject, naires) {
	    var tagging = "请在一下输入框输入问题(每一个问题之间用英文的分号隔开 ';')<br>";
		document.getElementById("myDiv").innerHTML=tagging;

	    var Question = document.createElement("input");
	    Question.type = "textarea";
	    // Question.style.margin =  "100px 100px 100px 100px";
        Question.style.width = "700px";
        Question.style.height = "300px";
        Question.value = naires;

		var but = document.createElement("input");
		but.type = "button";
		but.value = "提交问题";
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
		but.onclick = function() {
		    SubmitQuestion(Question.value, subject);
		}

		$("#myDiv").append(Question);
		$("#myDiv").append("<br>");
		$("#myDiv").append(but);
	}

	function getResultCount(id, arr) {
		$.ajax({
			type: 'GET',
			url: '/questionmanag',
			data: { subject: arr[id]},
			success: function (result) {
				$("#myDiv").empty();
				if (result == "subject null") {
					document.getElementById("myDiv").innerHTML="未知错误！！！";
					return;
				}
				if(result == "noOneAnswer"){
					document.getElementById("myDiv").innerHTML="还没有人回答该课程！！！";
					return;
				}

				/**
				 * 每个答案之间用','分隔，每个问题用'\3'分隔
				 * ','前面为选择是的人数，后面为选择否的人数
				 */
				var allQues = result.split("\3");
				var table = createTableWithoutButton_1(700, 130, 3, allQues);
				document.getElementById("myDiv").innerHTML="该课程问卷结果如下:";
				$("#myDiv").append(table);
			},
			error:function(result) {
				alert(result);
			}
		});

	}

	function questionManager(id, arr) {
		var subject = arr[id]
	    $.ajax({
			url: '/m',
			type: 'POST',
			data: {
			    subject : subject
			},
			success: function (result) {
			    if (result == "nonaires") {
			        alert("该科目还没有添加问卷哦!")
					return;
				}
			    arr = result.split("\3");
			    var naires = "";
			    for (var i = 0; i < arr.length; i++) {
			        if (i == 0) {
			            naires += arr[i];
					} else {
			            var tmp = ";" + arr[i]
						naires += tmp;
					}
				}
			    addNaire(subject, naires);
			    return;
			},
			error:function(result) {
				alert(result);
			}
		})
	}
	/**
	 * 创建表格
	 * @param width 宽度
	 * @param height 高度
	 * @param line 列数
	 * @param arr 表内数据
	 * @param type button 类型名
	 */
	function createTableWithoutButton_1(width, height, line, arr) {
		var table = document.createElement("table");
		var tbody = document.createElement("tbody");
		table.style.width = width;
		table.style.height = height;
		table.style.border = 4;
		var td;
		for (var i = 0; i <= arr.length; i++) {
			var tr = document.createElement("tr");
			for (var j = 0; j < line; ++j) {
				td = document.createElement("td");

				if(i > 0){
					var tmparr = arr[i-1].split(",");
				}

				if (j == 0) {
					if(i == 0){
						td.innerHTML = "问题编号";
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.width = "200px";
						td.style.fontSize = "20px"
					} else {
						td.innerHTML =  i;
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.width = "200px";
						td.style.fontSize = "20px"
					}

				} else if (j == 1) {
					if(i == 0){
						td.innerHTML = "选择是的人数";
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.width = "200px";
						td.style.fontSize = "20px"
					}else {
						td.innerHTML = tmparr[0];
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.width = "200px";
						td.style.fontSize = "20px"
					}

				} else {
					if(i == 0){
						td.innerHTML = "选择否的人数";
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.fontSize = "20px"
						td.style.width = "500px"
					}else {
						td.innerHTML = tmparr[1];
						td.style.textAlign = "center";
						td.style.color = "#292929";
						td.style.fontSize = "20px"
						td.style.width = "500px"
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
							// test
							// var str = "are you ok?;i m fine;thank you!"
							var subject = arr[i];
							var naires = "";
							addNaire(subject, naires);
						}
						else if(flag == 2) //统计结果
						{
							getResultCount(i, arr);
						}
						else if(flag == 3) //题目添加管理
						{
							questionManager(i, arr);
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
					var type = "管理 +";
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