<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html"; charset="utf-8" />
<title>添加课程</title>

<link href="css/all.css" rel="stylesheet" type="text/css">
    <link href="js/bstable/css/bootstrap.min.css" rel="stylesheet" type="text/css">
    <link href="js/bstable/css/bootstrap-table.css" rel="stylesheet" type="text/css">

</head>
<script type="text/javascript">

<!--做是否添加成功的校验-->

function display_alert()
{

  alert("添加成功！")
}
</script>

<body>
<form action="CurSubject.html" method="get">
    <div class="div_find">
        <label>选择要添加的课程： </label>
        <select class="find_input" name="subject">
            <option value="chinese">语文</option>
            <option value="math">数学</option>
            <option value="english">英语</option>
            <option value="geography">地理</option>
            <option value="politics">政治</option>
            <option value="history">历史</option>
        </select>

         <button class="find_but1" type="submit" onclick="display_alert()">提 交</button>
    </div>
</form>
</body>
</html>