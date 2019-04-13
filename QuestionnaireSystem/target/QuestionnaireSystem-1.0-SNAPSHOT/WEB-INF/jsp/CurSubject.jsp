
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html"; charset="utf-8" />
<title>当前所选课程</title>

<style type="text/css">
table.hovertable {
	font-family: verdana,arial,sans-serif;
	font-size:15px;
	text-align: center;
	color:#333333;
	border-width: 10px;
	border-color: #999999;
	border-collapse: collapse;
	margin: 0 auto;
	width: 300px;
}
table.hovertable th {
	background-color:#c3dde0;
	border-width: 10px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;

}
table.hovertable tr {
	background-color:#d4e3e5;
	border-left:all;
	border-right: all;
	border-width: 10px;
}
table.hovertable td {
	border-width: 10px;
	padding: 8px;
	border-style: solid;
	border-color: #a9c6c9;
}
</style>

<link href="css/all.css" rel="stylesheet" type="text/css">
    <link href="js/bstable/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="js/bstable/css/bootstrap-table.css" rel="stylesheet" type="text/css">

</head>
<body>

<div class="div_find">
    <label><font size="4">您当前已选择的课程： </font></label>&nbsp;&nbsp;&nbsp;
	<input type="button" name="Submit" onclick="javascript:history.back(-1);" value="返回上一页">
</div>

    <table class="hovertable" >
<tr>
	<th><font size="4" color="black"><center>科目</center></font></th>
</tr>

<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
	<td>语文</td>
</tr>
<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
	<td>数学</td>
</tr>
<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
	<td>英语</td>
</tr>
<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
	<td>地理</td>
</tr>
<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
	<td>政治</td>
</tr>
<tr onmouseover="this.style.backgroundColor='#ffff66';" onmouseout="this.style.backgroundColor='#d4e3e5';">
	<td>历史</td>
</table>
</body>
</html>


vector<int> GoodsCalculate(vector<int>& prices)
{
	vector<int> res;
	if(prices.size() <= 2)
		return res;

	res.push_bakc(0);
	res.push_back(0);

	int size = prices.size();
	int count = 0;
	int flag = 0;
	for(int i = size-3; i >= 0; --i)
	{
		if(count == 0)
		{
			int tmp = prices[i] + 3;
			if(tmp >= 10)
			{
				flag = 1;
				tmp /= 10;
				res.push_back(tmp);
			}
			
		}
		if(count == 1)
		{
			int tmp = prices[i] + 3;
			if(flag == 1)
			{
				tmp += 1；
				flag = 0;
			}
			if(tmp >= 10)
			{
				flag = 1;
				tmp /= 10;
				res.pish_back(tmp);
			}
		}

		if(flag == 1)
		{
			flag = 0;
			int tmp = prices[i] + 1;
			if(tmp >= 10)
			{
				flag = 1;
				res.push_back(0);
			}
		}
		else
		{
			res.push_back(prices[i]);
		}
		++count;
	}

	return res;
}


 

