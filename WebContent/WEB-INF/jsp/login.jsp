<%@ page session="true" %>
    <%-- <%@taglib uri="http://www.springframework.org/tags" prefix="spring" %>
        --%>
        <!DOCTYPE html>

        <head>
            <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
            <meta http-equiv="PRAGMA" content="NO-CACHE" />
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
            <meta http-equiv="X-UA-Compatible" content="IE=11,chrome=1">
            <title>CoffeeBeans Login</title>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <link rel="shortcut icon" href="resources/CoffeeBean1.jpg">
            <link rel="stylesheet" type="text/css" href="css/loginstyle.css" />
            <link rel="stylesheet" type="text/css" href="css/animate-custom.css" />
            <script src="js/jquery-1.12.2.min.js" type="text/javascript"></script>
            <script type="text/javascript" src="jqwidgets/jqxcore.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxdata.js"></script>
            <script src="js/jquery.confirm.js" type="text/javascript"></script>
            <link rel="stylesheet" type="text/css" href="css/jquery.confirm.css">
            <!--             <script src="js/util.js" type="text/javascript"></script>
 -->
            <script>
                $(document).ready(function() {

                    $("#password").keyup(function(e) {
                        if (e.keyCode == 13) {
                            logon();
                        }
                    });
                });

                function alertInvalidCredentials() {
                    $("#password").val('');
                    // showDialog("Please login with valid credentials");

                    $.confirm({
                        'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                        'message': "Please login with valid credentials",
                        'buttons': {
                            'OK': {
                                'class': 'blue',
                                'action': function() {
                                    window.open('', '_self', '');
                                }
                            },
                        }
                    });
                }

                function changePassword() {
                    if (validateInputs()) {

                        $.ajax({
                            url: 'role/authenticate.htm?userid=' + $("#userId").val() + '&pass=' + $("#password").val(),
                            type: 'POST',
                            cache: false,
                            dataType: 'json',
                            success: function(userData) {
                                if (userData != null) {
                                    sessionStorage.userDetails = JSON.stringify(userData);
                                    window.location.replace("changePassword.jsp");

                                } else {

                                }

                            },
                            error: function(res, textStatus, errorThrown) {
                                alertInvalidCredentials()
                            },
                        });
                    }
                }

                function logon() {

                    if (validateInputs()) {
                        $.ajax({
                            url: 'role/authenticate.htm?userid=' + $("#userId").val() + '&pass=' + $("#password").val(),
                            type: 'POST',
                            cache: false,
                            dataType: 'json',
                            success: function(userData) {
                                if (userData != null) {

                                    sessionStorage.userDetails = JSON.stringify(userData);
                                    if (userData.userRole == "admin" || userData.userRole == "Admin") {
                                        //window.location.replace("/Automator/users.htm");
                                        window.location.replace("tasks.jsp");
                                    } else if (userData.userRole == "normal" || userData.userRole == "Normal") {
                                        //window.location.replace("/Automator/home.htm");
                                        window.location.replace("tasks.jsp");
                                    } else if (userData.userRole == "superadmin") {
                                        //window.location.replace("/Automator/home.htm");
                                        window.location.replace("tasks.jsp");
                                    }
                                } else {
                                    alertInvalidCredentials()
                                }

                            },
                            error: function(res, textStatus, errorThrown) {
                                //alert(' Error :' + errorThrown);
                                // window.location.replace("/Automator/accessfailure.htm");
                                //window.location.replace("AccessFailure.jsp");
                                alertInvalidCredentials()
                            },
                        });
                    }

                };

                function validateInputs() {
                    if ($("#userId").val() == '') {
                        //	showDialog("Please provide user Name");
                        $.confirm({
                            'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                            'message': "Please provide user Name",
                            'buttons': {
                                'OK': {
                                    'class': 'blue',
                                    'action': function() {
                                        window.open('', '_self', '');
                                    }
                                },
                            }
                        });
                        return false;
                    } else if ($("#password").val() == '') {
                        //showDialog("Please provide password");
                        $.confirm({
                            'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                            'message': "Please provide password",
                            'buttons': {
                                'OK': {
                                    'class': 'blue',
                                    'action': function() {
                                        window.open('', '_self', '');
                                    }
                                },
                            }
                        });
                        return false;
                    }
                    return true;
                }
            </script>
        </head>

        <body>
            <div class="container" id="loginContent">
                <header>
                    <h1>
                        <img style="font-family:fantasy;" src="resources/CoffeeBean1.jpg" class="img-responsive col-sm-3" width="60" height="70"> <span style="#000080 !important;"><strong style="#000044 !important;" class="col-sm-8"><em>CoffeeBeans</em></strong></span>
                    </h1>
                </header>

                <section>
                    <div id="container_login">

                        <div id="wrapper">
                            <div id="login" class="animate form">
                                <form autocomplete="on">

                                    <h1>Login</h1>
                                    <p>
                                        <label for="userId" class="uname" data-icon="u"> User Name
                                        </label>
                                        <input id="userId" name="userId" required="required" type="text" placeholder="Your Name" />
                                    </p>
                                    <p>
                                        <label for="password" class="youpasswd" data-icon="p">
                                            Password </label>
                                        <input id="password" name="password" required="required" type="password" placeholder="Password" />
                                    </p>
                                    <p class="keeplogin">
                                        <br>
                                    </p>
                                    <p class="login button">
                                        <input type="button" value="Login" onclick="logon()" />
                                    </p>
                                    <p class="change_link">
                                        <a id="changePassword" onClick="changePassword(); return false;" style="float:left;" href="login.jsp"><span class="glyphicon glyphicon-off"></span>Change Password</a> Powered by CB TechTeam
                                    </p>
                                </form>
                            </div>

                        </div>
                    </div>
                </section>
            </div>
        </body>

        </html>