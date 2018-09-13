<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@include file="automator.jsp" %>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
            <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
            <meta http-equiv="PRAGMA" content="NO-CACHE" />
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
            <title>Leave Tracker</title>
            <link rel="shortcut icon" href="resources/CoffeeBean1.jpg">

            <link rel="stylesheet" type="text/css" href="css/custom-Automator.css" />
            <link rel="stylesheet" href="jqwidgets/styles/jqx.base.css" type="text/css" />
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/css/bootstrap-datetimepicker.min.css" />
            <script type="text/javascript" src="js/jquery-1.11.1.min.js"></script>
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

            <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.10.6/moment.min.js"></script>

            <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datetimepicker/4.17.37/js/bootstrap-datetimepicker.min.js"></script>

            <script src="js/util.js" type="text/javascript"></script>
            <script src="js/jquery.confirm.js" type="text/javascript"></script>
            <link rel="stylesheet" type="text/css" href="css/jquery.confirm.css">
            <script type="text/javascript">
                $(document).ready(function() {

                    $(function() {
                        var bindDatePicker = function() {
                            $(".date").datetimepicker({
                                format: 'DD-MM-YYYY',
                                icons: {
                                    time: "fa fa-clock-o",
                                    date: "fa fa-calendar",
                                    up: "fa fa-arrow-up",
                                    down: "fa fa-arrow-down"
                                }
                            }).find('input:first').on("blur", function() {
                                // check if the date is correct. We can accept dd-mm-yyyy and yyyy-mm-dd.
                                // update the format if it's yyyy-mm-dd
                                var date = parseDate($(this).val());

                                /*
                					if (! isValidDate(date)) {
                						//create date based on momentjs (we have that)
                						date = moment().format('DD-MM-YYYY');
                					}
*/
                                $(this).val(date);
                            });
                        }

                        var isValidDate = function(value, format) {
                            format = format || false;
                            // lets parse the date to the best of our knowledge
                            if (format) {
                                value = parseDate(value);
                            }

                            var timestamp = Date.parse(value);

                            return isNaN(timestamp) == false;
                        }

                        var parseDate = function(value) {
                            var m = value.match(/^(\d{1,2})(\/|-)?(\d{1,2})(\/|-)?(\d{4})$/);
                            if (m)
                            //value = m[5] + '-' + ("00" + m[3]).slice(-2) + '-' + ("00" + m[1]).slice(-2);
                                value = ("00" + m[1]).slice(-2) + '-' + ("00" + m[3]).slice(-2) + '-' + m[5];
                            return value;
                        }

                        bindDatePicker();
                    });

                    if (checkAccess()) {

                        // show Add user modal
                        $("#applyLeave").click(function() {
                            $('#applyLeaveModal').modal('show');
                        });

                        //=====================			    
                        $("#apply").click(function(e) {

                            var days = $("#days").val().trim();
                            var reason = $("#reason").val().trim();
                            var startDate = $("#startTimeDatePicker").find("input").val();
                            var endDate = $("#endTimeDatePicker").find("input").val();

                            if (toDate(startDate) > toDate(endDate)) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Start Date cannot be greater than End Date",
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
                            if (isEmpty(startDate) || isEmpty(endDate)) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please provide the dates.",
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

                                    var leaveToApply = JSON.stringify({
                                        "days": parseInt(days),
                                        "addedBy": userdata.userID,
                                        "reason": reason,
                                        "status": "SUBMITTED",
                                        "startDate": toDate(startDate),
                                        "endDate": toDate(endDate)
                                    });

                                    $.ajax({
                                        url: 'leave/create.htm',
                                        cache: false,
                                        type: 'POST',
                                        contentType: 'application/json',
                                        dataType: 'json',
                                        data: leaveToApply,
                                        error: function(res, textStatus, errorThrown) {
                                            $('#applyLeaveModal').modal('toggle');
                                            $('#leavejqxgrid').jqxGrid('updatebounddata');

                                            alert(' Error :' + errorThrown);
                                        },
                                        success: function(data) {

                                            e.preventDefault();
                                            $('#applyLeaveModal').modal('toggle');
                                            $('#leavejqxgrid').jqxGrid('updatebounddata');

                                            if (data > 0) {
                                                $.confirm({
                                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                    'message': "Applied leave successfully",
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
                                                    'message': "Errow while applying the leave. Please try again !",
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

                        $("#cancelLeave").click(function() {
                            var rowindex = $('#leavejqxgrid').jqxGrid('getselectedrowindex');

                            if (rowindex == -1) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please select leave to cancel",
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
                            var rowdata = $('#leavejqxgrid').jqxGrid('getrowdata', rowindex);

                            if (rowdata.country != 'Not-Applicable') {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Do you want to cancel the leave ?",
                                    'buttons': {
                                        'Yes': {
                                            'class': 'blue',
                                            'action': function() {
                                                $.post('leave/cancel/' + rowdata.leaveId + '.htm').success(function(data) {
                                                    $('#leavejqxgrid').jqxGrid('updatebounddata');
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

                        if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                            // console.log("User Details are " + sessionStorage.userDetails);
                            var userdata = JSON.parse(sessionStorage.userDetails);
                        }
                        var sourceChainGrid = {
                            datatype: "json",
                            datafields: [{
                                name: 'leaveId'
                            }, {
                                name: 'days'
                            }, {
                                name: 'startDate',
                                type: 'date',
                                format: 'dd-MM-yyyy'
                            }, {
                                name: 'endDate',
                                type: 'date',
                                format: 'dd-MM-yyyy'
                            }, {
                                name: 'reason'
                            }, {
                                name: 'status'
                            }, {
                                name: 'updatedDate',
                                type: 'date',
                                format: 'dd-MM-yyyy HH.mm'
                            }],
                            id: 'leaveId',
                            url: 'leave/fetchAll.htm'
                        };

                        var dataChainAdapter = new $.jqx.dataAdapter(
                            sourceChainGrid);

                        $("#leavejqxgrid").jqxGrid({
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
                                text: 'Days of Leave',
                                datafield: 'days',
                                width: '10%'
                            }, {
                                text: 'Status',
                                datafield: 'status',
                                width: '10%'
                            }, {
                                text: 'Reason',
                                datafield: 'reason',
                                width: '30%'
                            }, {
                                text: 'Start Date',
                                datafield: 'startDate',
                                cellsformat: 'dd-MM-yyyy',
                                width: '15%'
                            }, {
                                text: 'End Date',
                                datafield: 'endDate',
                                cellsformat: 'dd-MM-yyyy',
                                width: '15%'
                            }, {
                                text: 'Updated Date',
                                datafield: 'updatedDate',
                                //hidden : true,
                                cellsformat: 'dd-MM-yyyy HH.mm',
                                width: '15%'
                            }]
                        });
                    } else {
                        window.location.replace("AccessFailure.jsp");
                    }
                });
            </script>
        </head>

        <body>
            <div class="menu">
                <div class="container-fluid">
                    <div class="navbar-header">
                        <a href="#"><span style="font-size:25px; color:white;">Leave Tracker</span></a>
                    </div>
                    <div>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a id="applyLeave" href="#"><span class="	glyphicon glyphicon-tags"></span> Apply Leave </a>
                            </li>
                            <!-- <li><a id="resolveBug" href="#"><span class="glyphicon glyphicon-ok"></span> Update Leave </a></li> -->
                            <li><a id="cancelLeave" href="#"><span class="glyphicon glyphicon-remove"></span> Cancel </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="leavejqxgrid" style="margin-top:5%; margin-left:5%;" class="col-xs-12 col-sm-6 col-md-6 ">
            </div>

            <!-- Below Modal is for Apply Leave -->
            <div class="modal fade" id="applyLeaveModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Apply Leave</h4>
                        </div>
                        <div class="modal-body col-md-12">
                            <form class="form-horizontal col-md-12">
                                <div class="form-group">
                                    <label class="control-label" for="bugTitle">No.Of Days:</label>
                                    <input type="number" class="form-control" id="days" min="1" placeholder="No.of days for leave" name="title">
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Reason:</label>
                                    <input type="text" class="form-control" id="reason" placeholder="Provide the reason" name="reason">
                                </div>
                                <div class="form-group col-xs-12 col-sm-6">
                                    <label for="pwd">Start Date:</label>
                                    <div class='input-group date' id="startTimeDatePicker">
                                        <input type='text' class="form-control" />
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>

                                <div style="margin-left:2%;" class="form-group col-xs-12 col-sm-6">
                                    <label for="pwd">End Date:</label>
                                    <div class='input-group date' id="endTimeDatePicker">
                                        <input type='text' class="form-control" />
                                        <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span>
                                        </span>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="apply">Apply</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>

                </div>
            </div>

            <%@ include file="footer.jsp" %>