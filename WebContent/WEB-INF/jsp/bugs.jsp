<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@include file="automator.jsp" %>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
            <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
            <meta http-equiv="PRAGMA" content="NO-CACHE" />
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
            <title>Bugs</title>
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

                    if (checkAccess()) {

                        // show Add user modal
                        $("#openBug").click(function() {
                            $('#openBugModal').modal('show');
                        });

                        //=====================			    
                        $("#saveBug").click(function(e) {
                            var bugName = $("#bugName").val().trim();
                            var bugDesc = $("#bugDescription").val().trim();

                            if (isEmpty(bugName) || isEmpty(bugDesc)) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please provide all the field values.",
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

                                if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                                    // console.log("User Details are " + sessionStorage.userDetails);
                                    var userdata = JSON.parse(sessionStorage.userDetails);

                                    var bugToSave = JSON.stringify({
                                        "bugName": bugName,
                                        "addedBy": userdata.userName,
                                        "updatedBy": userdata.userName,
                                        "description": bugDesc,
                                        "status": "Open"
                                    });

                                    $.ajax({
                                        url: 'bug/create.htm',
                                        cache: false,
                                        type: 'POST',
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: bugToSave,
                                        error: function(res, textStatus, errorThrown) {
                                            $('#openBugModal').modal('toggle');
                                            $('#bugjqxgrid').jqxGrid('updatebounddata');

                                            alert(' Error :' + errorThrown);
                                        },
                                        success: function(data) {

                                            e.preventDefault();
                                            $('#openBugModal').modal('toggle');
                                            $('#bugjqxgrid').jqxGrid('updatebounddata');

                                            if (data > 0) {
                                                $.confirm({
                                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                    'message': "Opened the bug successfully",
                                                    'buttons': {
                                                        'OK': {
                                                            'class': 'blue',
                                                            'action': function() {
                                                                window.open('', '_self', '');
                                                            }
                                                        },
                                                    }
                                                });
                                                $("#state").val("");
                                            } else {
                                                $.confirm({
                                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                    'message': "Errow while opening the bug. Please try again !",
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
                                        }
                                    });
                                }
                            }
                        });

                        //=====================			    
                        $("#resolve").click(function(e) {
                            var bugName = $("#updateBugName").val().trim();
                            var bugDesc = $("#updateBugDescription").val().trim();
                            var resolution = $("#resolveBugDescription").val().trim();

                            if (isEmpty(bugName) || isEmpty(bugDesc)) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please provide all the field values.",
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

                                if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                                    // console.log("User Details are " + sessionStorage.userDetails);
                                    var userdata = JSON.parse(sessionStorage.userDetails);

                                    var bugToSave = JSON.stringify({
                                        "bugId": parseInt($("#chosenBugId").val()),
                                        "bugName": bugName,
                                        "addedBy": $("#chosenBugAddedBy").val(),
                                        "updatedBy": userdata.userName,
                                        "description": bugDesc,
                                        "resolution": resolution,
                                        "status": "Resolved"
                                    });

                                    $.ajax({
                                        url: 'bug/edit.htm',
                                        cache: false,
                                        type: 'POST',
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: bugToSave,
                                        error: function(res, textStatus, errorThrown) {
                                            $('#resolveBugModal').modal('toggle');
                                            $('#bugjqxgrid').jqxGrid('updatebounddata');

                                            alert(' Error :' + errorThrown);
                                        },
                                        success: function(data) {

                                            e.preventDefault();
                                            $('#resolveBugModal').modal('toggle');
                                            $('#bugjqxgrid').jqxGrid('updatebounddata');

                                            if (data > 0) {
                                                $.confirm({
                                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                    'message': "Updated the bug as resolved.",
                                                    'buttons': {
                                                        'OK': {
                                                            'class': 'blue',
                                                            'action': function() {
                                                                window.open('', '_self', '');
                                                            }
                                                        },
                                                    }
                                                });
                                                $("#state").val("");
                                            } else {
                                                $.confirm({
                                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                    'message': "Errow while resolving the bug. Please try again !",
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
                                        }
                                    });
                                }
                            }
                        });

                        // resolve bug functionality
                        $("#resolveBug").click(function(e) {

                            var rowindex = $('#bugjqxgrid').jqxGrid('getselectedrowindex');

                            if (rowindex == -1) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please select one bug",
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

                            var rowdata = $('#bugjqxgrid').jqxGrid('getrowdata', rowindex);

                            $("#chosenBugAddedBy").val(rowdata.addedBy);
                            $("#chosenBugId").val(rowdata.bugId);
                            $("#chosenBugDesc").val(rowdata.description);

                            // set the values in modal
                            $("#updateBugName").val(rowdata.bugName);
                            $("#updateBugDescription").val(rowdata.description);

                            $('#resolveBugModal').modal('show');
                        });

                        $("#deleteBug").click(function() {
                            var rowindex = $('#bugjqxgrid').jqxGrid('getselectedrowindex');

                            if (rowindex == -1) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please select one bug",
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
                            var rowdata = $('#bugjqxgrid').jqxGrid('getrowdata', rowindex);

                            if (rowdata.country != 'Not-Applicable') {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Do you want to delete the selected bug permanently ?",
                                    'buttons': {
                                        'Yes': {
                                            'class': 'blue',
                                            'action': function() {
                                                $.post('bug/delete/' + rowdata.bugId + '.htm').success(function(data) {
                                                    $('#bugjqxgrid').jqxGrid('updatebounddata');
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
                            } else {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Cannot delete N/A  record",
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

                        var sourceChainGrid = {
                            datatype: "json",
                            datafields: [{
                                name: 'bugId'
                            }, {
                                name: 'bugName'
                            }, {
                                name: 'description'
                            }, {
                                name: 'addedBy'
                            }, {
                                name: 'status'
                            }, {
                                name: 'updatedBy',

                            }, {
                                name: 'createdDate',
                                type: 'date',
                                format: 'dd-MM-yyyy HH.mm'
                            }, {
                                name: 'updatedDate',
                                type: 'date',
                                format: 'dd-MM-yyyy HH.mm'
                            }],
                            id: 'bugId',
                            url: 'bug/fetchAll.htm'
                        };

                        var dataChainAdapter = new $.jqx.dataAdapter(
                            sourceChainGrid);

                        $("#bugjqxgrid").jqxGrid({
                            width: '90%',
                            height: 400,
                            source: dataChainAdapter,
                            theme: 'energyblue',
                            selectionmode: 'singlerow',
                            sortable: true,
                            filterable: true,
                            columnsresize: true,
                            columnsreorder: true,
                            enabletooltips: true,
                            /*
                            cellhover: function (element, pageX, pageY) {
                                // update tooltip.
                                var cellValue = element.innerText;
                                var tooltipContent = "<div style='color: blue;'> Task Description : " + cellValue + "</div>";
                                $("#tasksjqxgrid").jqxTooltip({ content: tooltipContent });
                                // open tooltip.
                                $("#tasksjqxgrid").jqxTooltip('open', pageX + 15, pageY + 15);
                            },
                            */
                            ready: function() {},
                            columns: [{
                                text: 'Bug Title',
                                datafield: 'bugName',
                                width: '15%'
                            }, {
                                text: 'Description',
                                datafield: 'description',
                                width: '30%'
                            }, {
                                text: 'Status',
                                datafield: 'status',
                                //hidden : true,
                                width: '5%'
                            }, {
                                text: 'Updated By',
                                datafield: 'updatedBy',
                                //hidden : true,
                                width: '15%'
                            }, {
                                text: 'Created Date',
                                datafield: 'createdDate',
                                //hidden : true,
                                cellsformat: 'dd-MM-yyyy HH.mm',

                                width: '15%'
                            }, {
                                text: 'Updated Date',
                                datafield: 'updatedDate',
                                //hidden : true,
                                cellsformat: 'dd-MM-yyyy HH.mm',
                                width: '10%'
                            }, {
                                text: 'Added By',
                                datafield: 'addedBy',
                                //hidden : true,
                                width: '10%'
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
                    <div class="navbar-header">
                        <a href="#"><span style="font-size:25px; color:white;">Bugs Tracker</span></a>
                    </div>
                    <div>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a id="openBug" href="#"><span class="glyphicon glyphicon-piggy-bank"></span> New Bug </a>
                            </li>
                            <li><a id="resolveBug" href="#"><span class="glyphicon glyphicon-ok"></span> Resolve </a>
                            </li>
                            <li><a id="deleteBug" href="#"><span class="glyphicon glyphicon-remove"></span> Remove </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="bugjqxgrid" style="margin-top:5%; margin-left:5%;" class="col-xs-12 col-sm-6 col-md-6 ">
            </div>

            <!-- Below Modal is for Open Bug -->
            <div class="modal fade" id="openBugModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">New Bug</h4>
                        </div>
                        <div class="modal-body col-md-12">
                            <form class="form-horizontal col-md-12">
                                <div class="form-group">
                                    <label class="control-label" for="bugTitle">Bug Title:</label>
                                    <input type="text" class="form-control" id="bugName" placeholder="Bug Title" name="title">
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Description:</label>
                                    <textarea class="form-control" id="bugDescription" rows="4" placeholder="Description of the bug" name="desc"></textarea>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="saveBug">Open</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>

                </div>
            </div>

            <!-- Below Modal is for Resolve Bug-->
            <div class="modal fade" id="resolveBugModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Resolve Bug</h4>
                        </div>
                        <div class="modal-body col-md-12">
                            <form class="form-horizontal col-md-12">
                                <div class="form-group">
                                    <label class="control-label" for="bugTitle">Bug Title:</label>
                                    <input type="text" class="form-control" id="updateBugName" placeholder="Bug Title" name="title" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Bug Description:</label>
                                    <textarea class="form-control" id="updateBugDescription" rows="4" placeholder="Description of the bug" name="desc" readonly></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Resolution:</label>
                                    <textarea class="form-control" id="resolveBugDescription" rows="4" placeholder="Provide resolution" name="desc"></textarea>
                                </div>


                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="resolve">Resolve</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>

                </div>
            </div>

            <input type="hidden" id="chosenBugDesc" />
            <input type="hidden" id="chosenBugAddedBy" />
            <input type="hidden" id="chosenBugId" />

            <%@ include file="footer.jsp" %>