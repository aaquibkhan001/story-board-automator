<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ page session="true" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>

            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
            <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
            <meta http-equiv="PRAGMA" content="NO-CACHE" />
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
            <meta name="viewport" content="width=device-width, shrink-to-fit=no, initial-scale=1">

            <title>Automator Navigation</title>
            <link rel="shortcut icon" href="resources/CoffeeBean1.jpg">

            <!-- Bootstrap Core CSS -->
            <link href="css/bootstrap.min.css" rel="stylesheet">

            <!-- Custom CSS -->
            <link href="css/simple-sidebar.css" rel="stylesheet">
            <link rel="stylesheet" type="text/css" href="css/custom-Automator.css" />
            <link rel="stylesheet" type="text/css" href="css/jqx.energyblue.css">

            <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxcore.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxdata.js"></script>
            <script src="js/jquery.confirm.js" type="text/javascript"></script>
            <link rel="stylesheet" type="text/css" href="css/jquery.confirm.css">


        </head>

        <body>

            <div id="wrapper">

                <!-- Sidebar -->
                <div id="sidebar-wrapper">
                    <ul class="sidebar-nav">
                        <li class="sidebar-brand">
                            <a href="#">
                        Dashboard Menu
                    </a>
                        </li>
                        <li>
                            <a href="leaves.jsp"><span class="glyphicon glyphicon-list-alt"></span> Leaves</a>
                        </li>
                        <li>
                            <a href="bugs.jsp"><span class="glyphicon glyphicon-piggy-bank"></span> Bugs</a>
                        </li>
                        <li>
                            <a href="users.jsp"><span class="glyphicon glyphicon-user"></span>  Users</a>
                        </li>
                        <li>
                            <a href="tasks.jsp"><span class="glyphicon glyphicon-globe"></span> Tasks</a>

                        </li>
                        <li>
                            <a href="references.jsp"><span class="glyphicon glyphicon-screenshot"></span>  References</a>

                        </li>
                        <li>
                            <a id="changePass" href="changePassword.jsp"><span class="glyphicon glyphicon-cog"></span> Change Password</a>
                        </li>
                        <li>
                            <a id="logout" href="logout.jsp"><span class="glyphicon glyphicon-off"></span> Log Out</a>
                        </li>
                    </ul>
                </div>
                <!-- /#sidebar-wrapper -->

                <!-- Page Content -->
                <div id="page-content-wrapper" style="background-color:rgba(51, 122, 183, 0.36);">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-sm-12">
                                <a href="#menu-toggle" class="btn btn-default" id="menu-toggle"><span class="glyphicon glyphicon-th"></span> View Menu</a>
                                <span style="float:right; margin-top:1%; margin-right:1%; font-size:25px;">
                                  <strong><em> Coffeebeans</em></strong>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /#page-content-wrapper -->

            </div>


            <!-- /#wrapper -->
            <!-- jQuery -->
            <script src="js/jquery-1.12.2.min.js"></script>

            <!-- Bootstrap Core JavaScript -->
            <script src="js/bootstrap.min.js"></script>
            <!-- Menu Toggle Script -->
            <script>
                $("#menu-toggle").click(function(e) {
                    e.preventDefault();
                    $("#wrapper").toggleClass("toggled");
                });
            </script>

            <%@ include file="footer.jsp" %>