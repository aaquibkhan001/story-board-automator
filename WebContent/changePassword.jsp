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

            <script src="js/util.js" type="text/javascript"></script>
            <script>
                $(document).ready(function() {

                    $("#password").keyup(function(e) {
                        if (e.keyCode == 13) {
                            logon();
                        }
                    });
                });

                function changePassword() {

                    if ($("#newPassword").val() == '') {
                        $.confirm({
                            'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                            'message': "Please provide New Password",
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
                    } else if ($("#confirmPassword").val() == '') {
                        $.confirm({
                            'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                            'message': "Please provide password to confirm",
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
                    } else if ($("#confirmPassword").val() != $("#newPassword").val()) {
                        $.confirm({
                            'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                            'message': "Password to confirm should be same with new password",
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

                    if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                        // console.log("User Details are " + sessionStorage.userDetails);
                        var userdata = JSON.parse(sessionStorage.userDetails);


                        $.ajax({
                            url: 'role/changePass.htm?pass=' + $("#newPassword").val(),
                            type: 'POST',
                            cache: false,
                            contentType: "application/json",
                            dataType: 'json',
                            data: sessionStorage.userDetails,
                            success: function(val) {
                                if (val > 0) {
                                    $.confirm({
                                        'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                        'message': "Your password is changed successfully",
                                        'buttons': {
                                            'OK': {
                                                'class': 'blue',
                                                'action': function() {
                                                    window.location.replace("login.jsp");
                                                }
                                            },
                                        }
                                    });
                                } else {
                                    $.confirm({
                                        'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                        'message': "Password could not be changed. Please try again.",
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

                            },
                            error: function(res, textStatus, errorThrown) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Error occurred while changing password. Please try again.",
                                    'buttons': {
                                        'OK': {
                                            'class': 'blue',
                                            'action': function() {
                                                window.open('', '_self', '');
                                            }
                                        },
                                    }
                                });
                            },
                        });
                    }

                };
            </script>
        </head>

        <body>
            <div class="container" id="loginContent">
                <header>
                    <h1>
                        <img style="font-size:25px;" src="resources/CoffeeBean.jpg" class="img-responsive" width="100" height="40"> <span style="#000080 !important;"><strong style="#000044 !important;"><em>Coffee Beans</em></strong></span>
                    </h1>
                </header>

                <section>
                    <div id="container_login">

                        <div id="wrapper">
                            <div id="login" class="animate form">
                                <form autocomplete="on">

                                    <h1>Change Password</h1>
                                    <!--  <p>
                                        <label for="userId" class="uname" data-icon="u"> User ID
								</label> <input id="userId" name="userId" required="required" type="text" placeholder="Your Name" />
                                    </p> -->
                                    <p>
                                        <label for="password" class="youpasswd" data-icon="p">
                                            New Password </label>
                                        <input id="newPassword" name="password" required="required" type="password" placeholder="Password" />
                                    </p>
                                    <p>
                                        <label for="password" class="youpasswd" data-icon="p">
                                            Confirm Password </label>
                                        <input id="confirmPassword" name="password" required="required" type="password" placeholder="Password" />
                                    </p>
                                    <p class="keeplogin">
                                        <br>
                                    </p>
                                    <p class="login button">
                                        <input type="button" value="Change" onclick="changePassword()" />
                                    </p>
                                    <p class="change_link">
                                        Powered by Coffeebeans Tech Team
                                    </p>
                                </form>
                            </div>

                        </div>
                    </div>
                </section>
            </div>
        </body>

        </html>