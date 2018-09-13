<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@include file="automator.jsp" %>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
            <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
            <meta http-equiv="PRAGMA" content="NO-CACHE" />
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
            <title>Users</title>
            <link rel="shortcut icon" href="resources/CoffeeBean1.jpg">

            <link rel="stylesheet" type="text/css" href="css/custom-Automator.css" />
            <link rel="stylesheet" href="jqwidgets/styles/jqx.base.css" type="text/css" />
            <script type="text/javascript" src="js/jquery-1.12.2.min.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxcore.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxdropdownlist.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxdata.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxbuttons.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxscrollbar.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxmenu.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxgrid.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxgrid.selection.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxgrid.sort.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxgrid.columnsresize.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxgrid.columnsreorder.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxgrid.filter.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxlistbox.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxdropdownlist.js"></script>
            <script type="text/javascript" src="jqwidgets/jqxgrid.pager.js"></script>
            <script src="js/bootstrap.min.js"></script>

            <script src="js/util.js" type="text/javascript"></script>
            <script src="js/jquery.confirm.js" type="text/javascript"></script>
            <link rel="stylesheet" type="text/css" href="css/jquery.confirm.css">
            <script type="text/javascript">
                $(document).ready(function() {

                    if (checkAccessForButtons()) {

                        // hide the buttons for normal user

                        if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                            // console.log("User Details are " + sessionStorage.userDetails);
                            var userdata = JSON.parse(sessionStorage.userDetails);

                            if (userdata.userRole == "normal") {
                                $('#addUser').hide();
                                $('#deleteUser').hide();
                                $('#editUser').hide();
                            }
                        }
                        // show Add user modal
                        $("#addUser").click(function() {
                            $('#addUserModal').modal('show');
                        });

                        // edit user functionality
                        $("#editUser").click(function(e) {

                            var rowindex = $('#usersjqxgrid').jqxGrid('getselectedrowindex');

                            if (rowindex == -1) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please select one row",
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

                            var rowdata = $('#usersjqxgrid').jqxGrid('getrowdata', rowindex);

                            $.get('role/fetch/' + rowdata.userID + '.htm').success(function(data) {

                                // set the values in modal
                                $("#chosenUserName").val(data.userName);
                                $("#chosenUserRole").val(data.userRole);
                                $("#chosenUserId").val(data.userID);
                                $("#chosenUserEmail").val(data.email);
                                $('#editUserModal').modal('show');
                            });

                        });


                        // on showing of edit modal
                        $('#editUserModal').on('show.bs.modal', function() {

                            $(".modal-body #userNameEdit").val($("#chosenUserName").val());
                            $(".modal-body #roleEdit").val($("#chosenUserRole").val());
                            $(".modal-body #emailEdit").val($("#chosenUserEmail").val());
                        });

                        $("#updateUserToDb").click(function(e) {
                            var userName = $("#userNameEdit").val();
                            var userRole = $("#roleEdit").val();
                            var email = $("#emailEdit").val();
                            var userID = $("#chosenUserId").val();
                            if (isEmpty(userName) || isEmpty(userRole)) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please provide all the field values",
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
                            } else {
                                var userToSave = JSON.stringify({
                                    "userID": parseInt(userID),
                                    "userName": userName,
                                    "userRole": userRole,
                                    "email": email
                                });

                                $.ajax({
                                    url: 'role/edit.htm',
                                    cache: false,
                                    type: 'POST',
                                    contentType: "application/json",
                                    dataType: "json",
                                    data: userToSave,
                                    error: function(res, textStatus, errorThrown) {
                                        $('#editUserModal').modal('toggle');
                                        $('#usersjqxgrid').jqxGrid('updatebounddata');

                                        alert(' Error :' + errorThrown);
                                    },
                                    success: function() {

                                        e.preventDefault();
                                        $('#editUserModal').modal('toggle');
                                        $('#usersjqxgrid').jqxGrid('updatebounddata');

                                        $.confirm({
                                            'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                            'message': "Updated the user successfully",
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
                                });
                            }

                        });
                        //=====================			    
                        $("#saveUser").click(function(e) {
                            var userName = $("#userName").val().trim();
                            var userRole = $("#role").val();
                            var userEmail = $("#email").val().trim();

                            if (isEmpty(userName) || isEmpty(userRole)) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please provide all the field values",
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
                            } else if (!isEmpty(userEmail) && !isEmail(userEmail)) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please provide valid email ID",
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
                            } else {
                                var userToSave = JSON.stringify({
                                    "userName": userName,
                                    "userRole": userRole,
                                    "email": userEmail
                                });

                                $.ajax({
                                    url: 'role/create.htm',
                                    cache: false,
                                    type: 'POST',
                                    contentType: 'application/json',
                                    dataType: 'json',
                                    data: userToSave,
                                    error: function(res, textStatus, errorThrown) {
                                        $('#addUserModal').modal('toggle');
                                        $('#usersjqxgrid').jqxGrid('updatebounddata');

                                        alert(' Error :' + errorThrown);
                                    },
                                    success: function() {

                                        e.preventDefault();
                                        $('#addUserModal').modal('toggle');
                                        $('#usersjqxgrid').jqxGrid('updatebounddata');

                                        $("#userName").val("");
                                        $("#email").val("");

                                        $.confirm({
                                            'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                            'message': "Saved the user successfully",
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
                                });

                            }
                        });

                        $("#deleteUser").click(function() {
                            var rowindex = $('#usersjqxgrid').jqxGrid('getselectedrowindex');

                            if (rowindex == -1) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please select one row",
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
                            // delete
                            var rowdata = $('#usersjqxgrid').jqxGrid('getrowdata', rowindex);

                            $.confirm({
                                'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                'message': "Do you want to delete the selected user ?",
                                'buttons': {
                                    'Yes': {
                                        'class': 'blue',
                                        'action': function() {

                                            $.post('role/delete/' + rowdata.userID + '.htm').success(function(data) {
                                                $('#usersjqxgrid').jqxGrid('updatebounddata');
                                            });

                                            window.open('',
                                                '_self',
                                                '');
                                        }
                                    },
                                    'No': {
                                        'class': 'blue',
                                        'action': function() {
                                            window
                                                .open(
                                                    '',
                                                    '_self',
                                                    '');
                                        }
                                    },
                                }
                            });
                        });

                        var sourceChainGrid = {
                            datatype: "json",
                            datafields: [{
                                name: 'userID'
                            }, {
                                name: 'userName'
                            }, {
                                name: 'userRole'
                            }, {
                                name: 'email'
                            }],
                            id: 'userID',
                            url: 'role/fetchAll.htm'
                        };

                        var dataChainAdapter = new $.jqx.dataAdapter(
                            sourceChainGrid);
                        $("#usersjqxgrid").jqxGrid({
                            width: '90%',
                            height: 400,
                            source: dataChainAdapter,
                            theme: 'energyblue',
                            selectionmode: 'singlerow',
                            sortable: true,
                            filterable: true,
                            ready: function() {},
                            columns: [{
                                text: 'User ID',
                                datafield: 'userID',
                                width: '20%'
                            }, {
                                text: 'User Name',
                                datafield: 'userName',
                                width: '30%'
                            }, {
                                text: 'User Role',
                                datafield: 'userRole',
                                //hidden : true,
                                width: '20%'
                            }, {
                                text: 'User Email',
                                datafield: 'email',
                                //hidden : true,
                                width: '30%'
                            }]
                        });
                    } else {
                        window.location.replace("AccessFailure.jsp");
                    }
                });
            </script>



        </head>

        <body>
            <div class="menu col-xs-12 col-sm-12 col-md-12">
                <div class="container-fluid">
                    <div class="navbar-header topnav">
                        <a href="#"><span style="font-size:25px; color:white;">Manage Users</span></a>
                    </div>
                    <div>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a id="addUser" href="#"><span class="glyphicon glyphicon-user"></span> Add User </a>
                            </li>
                            <li><a id="deleteUser" href="#"><span class="glyphicon glyphicon-remove"></span> Delete User </a>
                            </li>
                            <li><a id="editUser" href="#"><span class="glyphicon glyphicon-pencil"></span> Edit User </a>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>
            <div id="usersjqxgrid" style="margin-top:5%; margin-left:5%;" class="col-xs-12 col-sm-6 col-md-6 ">
            </div>

            <!-- Below Modal is for Add User -->
            <div class="modal fade" id="addUserModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Add User</h4>
                        </div>
                        <div class="modal-body col-md-12">
                            <form class="form-horizontal">
                                <div class="form-group required">
                                    <label for="firstName" class="col-sm-3 control-label">User Name</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" style="height:34px;" id="userName" placeholder="Your Name">
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label for="email" class="col-sm-3 control-label">User Email</label>
                                    <div class="col-sm-8">
                                        <input type="email" class="form-control" style="height:34px;" id="email" placeholder="Email">
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label for="userRole" class="col-sm-3 control-label">User Role</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="role">
                                            <option id="normalUser" value="normal" selected="selected">Normal</option>
                                            <option id="adminUser" value="admin">Admin</option>
                                        </select>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="saveUser">Save</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>

                </div>
            </div>


            <!-- Below Modal is for Update User -->
            <div class="modal fade" id="editUserModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Update User</h4>
                        </div>
                        <div class="modal-body col-md-12">
                            <form class="form-horizontal">
                                <div class="form-group required">
                                    <label for="firstName" class="col-sm-3 control-label">User Name</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" style="height:34px;" id="userNameEdit" placeholder="Your Name">
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label for="email" class="col-sm-3 control-label">User Email</label>
                                    <div class="col-sm-8">
                                        <input type="email" class="form-control" style="height:34px;" id="emailEdit" placeholder="Email">
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label for="userRole" class="col-sm-3 control-label">User Role</label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="roleEdit">
                                            <option value="normal">Normal</option>
                                            <option value="admin">Admin</option>
                                        </select>
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="updateUserToDb">Update</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>

                </div>
            </div>

            <input type="hidden" id="chosenUserName" />
            <input type="hidden" id="chosenUserRole" />
            <input type="hidden" id="chosenUserId" />
            <input type="hidden" id="chosenUserEmail" />

            <%@ include file="footer.jsp" %>