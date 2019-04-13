<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<html>
<head>
    <title>课程质量问卷调查系统</title>
    <link rel="stylesheet" href="js/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/font-awesome.min.css">
    <link rel="stylesheet" href="css/index.css">
    <link rel="stylesheet" href="css/skins/_all-skins.css">
</head>
<body class="hold-transition skin-blue sidebar-mini" style="overflow:hidden;">
    <div id="ajax-loader" style="cursor: progress; position: fixed; top: -50%; left: -50%; width: 200%; height: 200%; background: #fff; z-index: 10000; overflow: hidden;">
        <img src="img/ajax-loader.gif" style="position: absolute; top: 0; left: 0; right: 0; bottom: 0; margin: auto;" />
    </div>
    <div class="wrapper">
        <!--头部信息-->
        <header class="main-header">
            <nav class="navbar navbar-static-top">
                <a class="sidebar-toggle">
                </a><span class="index_top"><strong>课程质量问卷调查系统</strong></span>
            </nav>
        </header>


        <!--左边导航-->
        <div class="main-sidebar">
            <div class="sidebar">
                <ul class="sidebar-menu" id="sidebar-menu">
                    <li class="header">导航菜单</li>
                </ul>
               
                
            </div>
        </div>
        <!--中间内容-->
        <div id="content-wrapper" class="content-wrapper">
            <div class="content-tabs">
                <button class="roll-nav roll-left tabLeft">
                    <i class="fa fa-backward"></i>
                </button>
                <nav class="page-tabs menuTabs">
                    <div class="page-tabs-content" style="margin-left: 0px;">
                    </div>
                </nav>
                <button class="roll-nav roll-right tabRight">
                    <i class="fa fa-forward" style="margin-left: 3px;"></i>
                </button>
                <div class="btn-group roll-nav roll-right">
                </div>
                <button class="roll-nav roll-right fullscreen"><i class="fa fa-arrows-alt"></i></button>
            </div>
            <div class="content-iframe" style="overflow: hidden;">
                <div class="mainContent" id="content-main" style="margin: 10px; margin-bottom: 0px; padding: 0;">
                </div>
            </div>
        </div>
    </div>
    <script src="/js/jquery/jQuery-2.2.0.min.js"></script>
    <script src="/js/bootstrap/js/bootstrap.min.js"></script>
    <script src="/js/index.js"></script>
</body>
</html>
