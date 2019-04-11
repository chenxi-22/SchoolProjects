<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2019/4/11
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>需要立即去作答的问卷有：</title>
</head>
<body>

${list};

<form action="/student" method="get">
    <fieldset>
        <input type="submit" valule="返回主页">
    </fieldset>
</form>

</body>
</html>
