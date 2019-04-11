<!DOCTYPE html>
<html lang="uft-8">

<head>
    <title>Login</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" type="text/css" href="fonts/font-awesome-4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="css/util.css">
    <link rel="stylesheet" type="text/css" href="css/main.css">
</head>

<body>
    <div class="limiter">
        <div class="container-login100">
            <div class="wrap-login100">
                <div class="login100-form-title" style="background-image: url(images/bg-01.jpg);">
                    <span class="login100-form-title-1">课程质量问卷调查系统</span>
                </div>

                <form class="login100-form validate-form">

                      <div class="wrap-input101 validate-input m-b-26" data-validate="身份不能为空">
                        <span class="label-input101">身份</span>
                        <input  type="radio" name="identity" value="student" checked><font face="Poppins-Regular" color="#808080" >学生</font>
                         &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                        <input  type="radio" name="identity" value="teacher" ><font face="Poppins-Regular" color="#808080" >老师</font>
                        <span class="focus-input100"></span>
                    </div>

                    <div class="wrap-input100 validate-input m-b-26" data-validate="用户名不能为空">
                        <span class="label-input100">用户名</span>
                        <input class="input100" type="text" name="id" placeholder="请输入用户名">
                        <span class="focus-input100"></span>
                    </div>

                    <div class="wrap-input100 validate-input m-b-18" data-validate="密码不能为空">
                        <span class="label-input100">密码</span>
                        <input class="input100" type="password" name="password" placeholder="请输入密码">
                        <span class="focus-input100"></span>
                    </div>

                   
                    <br></br>
                    <div class="container-login100-form-btn" >
                        <button class="login100-form-btn" type="submit">登 录</button>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <button class="login100-form-btn" type="reset">重 置</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/main.js"></script>
</body>

</html>