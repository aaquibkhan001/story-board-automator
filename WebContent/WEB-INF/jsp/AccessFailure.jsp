<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@include file="automator.jsp" %>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
            <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
            <meta http-equiv="PRAGMA" content="NO-CACHE" />
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
            <title>403 Error</title>

            <link rel="stylesheet" type="text/css" href="css/custom-Automator.css" />
            <link rel="stylesheet" href="jqwidgets/styles/jqx.base.css" type="text/css" />
            <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxcore.js"></script>
            <script src="js/bootstrap.min.js"></script>
            <script>
                window.onload = function() {
                    //$("#menu-toggle").hide();

                    // remove user details from session
                    // sessionStorage.removeItem('userDetails');
                }
            </script>

        </head>

        <body>
            <div class="menu">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a href="#"><span style="font-size:25px; color:white;">Permission Denied. Contact Administrator.</span></a>
                    </div>
                    <div>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a id="addUser" href="/Automator"><span class="glyphicon glyphicon-user"></span> Admin Login </a>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>
        </body>

        </html>