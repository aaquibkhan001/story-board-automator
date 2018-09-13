<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <html>

    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
        <meta http-equiv="PRAGMA" content="NO-CACHE" />
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
        <title>Logout</title>
        <link rel="shortcut icon" href="resources/CoffeeBean1.jpg">

        <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
        <script type="text/javascript" src="jqwidgets/jqxcore.js"></script>
        <script type="text/javascript" src="jqwidgets/jqxdata.js"></script>
        <script src="js/jquery.confirm.js" type="text/javascript"></script>
        <link rel="stylesheet" type="text/css" href="css/jquery.confirm.css">
        <script type="text/javascript">
            window.onload = function() {
                $("p").hide();
                $.confirm({
                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                    'message': '  Do you want to exit the Application?',
                    'buttons': {
                        'Yes': {
                            'class': 'blue',
                            'action': function() {

                                <% session.invalidate(); %>
                                $("p").show();
                                //window.open('',	'_self','');
                                window.close();
                            }
                        },
                        'No': {
                            'class': 'gray',
                            'action': function() {
                                window.location.reload();
                                window.location.replace("users.jsp");
                            }
                        }
                    }
                });
            }
        </script>

    </head>

    <body>
        <p>You have been successfully logged out. Please close the browser and login again.</p>
    </body>

    </html>