<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@include file="automator.jsp" %>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
            <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
            <meta http-equiv="PRAGMA" content="NO-CACHE" />
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
            <title>Tasks</title>
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
            <script type="text/javascript" src="jqwidgets/jqxtooltip.js"></script>
            <script src="js/bootstrap.min.js"></script>

            <script src="js/util.js" type="text/javascript"></script>
            <script src="js/jquery.confirm.js" type="text/javascript"></script>
            <link rel="stylesheet" type="text/css" href="css/jquery.confirm.css">
            <script type="text/javascript">
                $(document).ready(function() {

                    $.get('name/fetchAll.htm', {}, function(data) {
                        if (data != null) {
                            names = data;
                            $("#assigneeDropdown").jqxDropDownList({
                                source: names,
                                width: '95%',
                                height: '25px',

                            });
                        }
                    });
                    $.get('name/fetchAll.htm', {}, function(data) {
                        if (data != null) {
                            names = data;
                            $("#updateAssigneeDropdown").jqxDropDownList({
                                source: names,
                                width: '95%',
                                height: '25px',

                            });
                        }
                    });
                    var slider = document.getElementById("myRange");
                    var output = document.getElementById("percentageComplete");
                    output.innerHTML = slider.value;

                    var slider = document.getElementById("updateMyRange");
                    var output = document.getElementById("updatePercentageComplete");
                    output.innerHTML = slider.value;

                    slider.oninput = function() {
                        output.innerHTML = this.value;
                    }

                    if (checkAccess()) {

                        // hide the buttons for normal user

                        if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                            // console.log("User Details are " + sessionStorage.userDetails);
                            var userdata = JSON.parse(sessionStorage.userDetails);
                            $('#acceptance').prop('readonly', true);
                            $('#updateAcceptance').prop('readonly', true);
                            $("#status option[value=QA-Done]").hide();
                            $("#updateStatus option[value=QA-Done]").hide();
                            
                            if (userdata.userRole == "normal") {
                                $('#addTask').hide();
                                $('#deleteTask').hide();
                            }
                            if (userdata.userRole == "superadmin") {
                            	       $('#acceptance').prop('readonly', false);
                            	       $('#updateAcceptance').prop('readonly', false);
                            	       $("#status option[value=QA-Done]").show();
                                    $("#updateStatus option[value=QA-Done]").show();
                            }
                        }

                        // show Add user modal
                        $("#addTask").click(function() {
                            $('#addTaskModal').modal('show');
                        });

                        $('#exportBtn').click(function(e) {
                            var displayedRows = $('#tasksjqxgrid').jqxGrid('getdisplayrows');
                            var ids = [];
                            for (var i = 0; i < displayedRows.length; i++) {
                                ids.push(displayedRows[i].taskid);
                            }
                            // alert("Total number of filtered data: " + ids.length + "\n" + "Emails of filtered data:\n" + ids.join(', '));

                            $.confirm({
                                'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                'message': '  Do you want to export displayed ' + ids.length + ' records into excel?',
                                'buttons': {
                                    'Yes': {
                                        'class': 'blue',
                                        'action': function() {

                                            var url = 'export/excel.htm';
                                            var method = 'post';
                                            var inputs = '<input type="hidden" name="selectedRecs" value="' + ids + '" />';
                                            $(
                                                    '<form action="' + url + '" method="' + (method || 'post') +
                                                    '" target = "_blank">' + inputs + '</form>')
                                                .appendTo('body').submit().remove();

                                            window.open('', '_self', '');
                                        }
                                    },
                                    'No': {
                                        'class': 'gray',
                                        'action': function() {}
                                    }
                                }
                            });
                        });

                        // edit user functionality
                        $("#editTask").click(function(e) {

                            var rowindex = $('#tasksjqxgrid').jqxGrid('getselectedrowindex');

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

                            var rowdata = $('#tasksjqxgrid').jqxGrid('getrowdata', rowindex);

                            $("#chosenTaskAddedBy").val(rowdata.addedBy);
                            $("#chosenTaskCreated").val(rowdata.createdDate);
                            $("#chosenTaskProject").val(rowdata.project);
                            $("#chosenTaskId").val(rowdata.taskid);
                            $("#chosenTaskPriority").val(rowdata.priority);

                            $("#updateAssigneeDropdown").jqxDropDownList('selectItem', rowdata.assignee);
                            // set the values in modal
                            $("#updateTaskName").val(rowdata.name);
                            $("#updatePriority").val(rowdata.priority);
                            $("#updateDescription").val(rowdata.description);
                            $("#updateAcceptance").val(rowdata.acceptance);
                            $("#updateStatus").val(rowdata.status);
                            $("#updateProject").val(rowdata.project);
                            $("#updateMyRange").val(rowdata.percentComplete);
                            document.getElementById("updatePercentageComplete").innerHTML = $("#updateMyRange").val();
                            $('#editTaskModal').modal('show');
                        });

                        $("#updateStatus").on('change', function() {
                            if ($(this).val() == 'dev-completed') {
                                document.getElementById("updatePercentageComplete").innerHTML = 90;
                                $("#updateMyRange").val(90);
                                document.getElementById("updateMyRange").disabled = true;

                            } else if ($(this).val() == 'QA-Done') {
                            if ($(this).val() == 'completed') {
                                document.getElementById("updatePercentageComplete").innerHTML = 100;
                                $("#updateMyRange").val(100);
                            }
                        });

                        // task history functionality
                        $("#historyTask").click(function(e) {
                            var rowindex = $('#tasksjqxgrid').jqxGrid('getselectedrowindex');

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

                            var rowdata = $('#tasksjqxgrid').jqxGrid('getrowdata', rowindex);

                            var sourceChainGrid = {
                                datatype: "json",
                                datafields: [{
                                    name: 'taskHistoryId'
                                }, {
                                    name: 'taskHistoryAddedBy'
                                }, {
                                    name: 'taskHistoryDescription'
                                }, {
                                    name: 'createdDate',
                                    type: 'date',
                                    format: 'dd-MM-yyyy HH.mm'
                                }],
                                id: 'taskid',
                                url: 'tasks/history/' + rowdata.taskid + '.htm'
                            };

                            var dataChainAdapter = new $.jqx.dataAdapter(
                                sourceChainGrid);

                            $("#taskHistjqxgrid").jqxGrid({
                                width: '100%',
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
                                    text: 'Action By',
                                    datafield: 'taskHistoryAddedBy',
                                    width: '28%'
                                }, {
                                    text: 'Description',
                                    datafield: 'taskHistoryDescription',
                                    //hidden : true,
                                    width: '50%'
                                }, {
                                    text: 'Action Date',
                                    datafield: 'createdDate',
                                    //hidden : true,
                                    cellsformat: 'dd-MM-yyyy HH.mm',

                                    width: '25%'
                                }]
                            });


                            $('#historyTaskModal').modal('show');
                        });

                        // on showing of edit modal
                        $('#editTaskModal').on('show.bs.modal', function() {

                            $(".modal-body #userNameEdit").val($("#chosenTaskAddedBy").val());
                            $(".modal-body #roleEdit").val($("#chosenTaskCreated").val());
                            $(".modal-body #emailEdit").val($("#chosenTaskHistory").val());
                        });

                        $("#updateTaskToDb").click(function(e) {
                            var taskName = $("#updateTaskName").val();
                            var description = $("#updateDescription").val();
                            var acceptance = $("#updateAcceptance").val();
                            var status = $("#updateStatus").val();
                            var percentageComplete = $("#updateMyRange").val();
                            var histDescription = $("#historyDescription").val();
                            var priority = $("#updatePriority").val();
                            var project = $("#updateProject").val();
						   var updateType = null;
                            if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                                // console.log("User Details are " + sessionStorage.userDetails);
                                var userdata = JSON.parse(sessionStorage.userDetails);
                            }
                                if (userdata.userRole == "superadmin" && isEmpty(acceptance)) {
                                	 $.confirm({
                                         'title': '<img width="40" height="20" src="resources/CoffeeBean.jpg" />' + ' Coffee Beans',
                                         'message': "Please provide acceptance criteria on the task before saving",
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
                                } else if ((userdata.userRole != "superadmin" && isEmpty(histDescription)) || ($("#updateAssigneeDropdown").jqxDropDownList('getSelectedItem') == 'undefined' || $("#updateAssigneeDropdown").jqxDropDownList('getSelectedItem') == null)) {

                            if (isEmpty(histDescription) || ($("#updateAssigneeDropdown").jqxDropDownList('getSelectedItem') == 'undefined' || $("#updateAssigneeDropdown").jqxDropDownList('getSelectedItem') == null)) {
                                $.confirm({
                                    'title': '<img width="40" height="20" src="resources/CoffeeBean.jpg" />' + ' Coffee Beans',
                                    'message': "Please provide updates on the task before saving",
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

                                var assignee = $("#updateAssigneeDropdown").jqxDropDownList('getSelectedItem').value;

                                if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                                    // console.log("User Details are " + sessionStorage.userDetails);
                                    var userdata = JSON.parse(sessionStorage.userDetails);

                                    var historySet = new Set();
                                    var descr = isEmpty(histDescription) ? "ACCEPTANCE CRITERIA added -" +  acceptance : histDescription;
                                    var history = {
                                        "taskHistoryAddedBy": userdata.userName,
                                        "taskHistoryDescription": descr
                                    }
                                    historySet.add(history);
                                    var taskToUpdate = JSON.stringify({
                                        "taskid": parseInt($("#chosenTaskId").val()),
                                        "name": taskName,
                                        "addedBy": $("#chosenTaskAddedBy").val(),
                                        "updatedBy": userdata.userName,
                                        "percentComplete": parseInt(percentageComplete),
                                        "assignee": assignee,
                                        "description": description,
                                        "status": status,
                                        "priority": priority,
                                        "project": project,
                                        "acceptance":acceptance,
                                        //"createdDate":	$("#chosenTaskCreated").val(),
                                        "historyItems": Array.from(historySet.values())
                                    });

                                    $.ajax({
                                        url: 'tasks/edit.htm',
                                        cache: false,
                                        type: 'POST',
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: taskToUpdate,
                                        error: function(res, textStatus, errorThrown) {
                                            $('#addTaskModal').modal('toggle');
                                            $('#tasksjqxgrid').jqxGrid('updatebounddata');

                                            alert(' Error :' + errorThrown);
                                        },
                                        success: function() {

                                            e.preventDefault();
                                            $('#editTaskModal').modal('toggle');
                                            $('#tasksjqxgrid').jqxGrid('updatebounddata');
                                            $("#updateDescription").val("");
                                            $("#updateAcceptance").val("");
                                            $("#historyDescription").val("");
                                            document.getElementById("updatePercentageComplete").innerHTML = 0;
                                            $("#updateMyRange").val(0);
                                            

                                            $.confirm({
                                                'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                'message': "Added an update to the task successfully",
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
                            }

                        });

                        //====================== Project Filtering =================
                        var source = [
                            "Coffeebeans",
                            "Fastnext",
                            "Wru"
                        ];
                        // Create a jqxDropDownList
                        $("#projectFilterDropdown").jqxDropDownList({
                            autoDropDownHeight: true,
                            placeHolder: "Project to filter",
                            source: source,
                            width: '200px',
                            height: '25px'
                        });

                        // bind to 'select' event.
                        $('#projectFilterDropdown').bind('select', function(event) {
                            var args = event.args;
                            var item = $('#projectFilterDropdown').jqxDropDownList('getItem', args.index);
                            var filtergroup = new $.jqx.filter();
                            var filter1 = filtergroup.createfilter('stringfilter', item.label, 'contains');

                            filtergroup.addfilter(1, filter1);
                            // add the filters.
                            $("#tasksjqxgrid").jqxGrid('addfilter', 'project', filtergroup);
                            // apply the filters.
                            $("#tasksjqxgrid").jqxGrid('applyfilters');

                        });

                        //=====================			    
                        $("#saveUser").click(function(e) {
                            var taskName = $("#taskName").val();
                            var description = $("#description").val();
                            var acceptance = $("#acceptance").val();
                            var status = $("#status").val();
                            var percentageComplete = $("#myRange").val();
                            var priority = $("#priority").val();
                            var project = $("#project").val();

                            if (isEmpty(taskName) || ($("#assigneeDropdown").jqxDropDownList('getSelectedItem') == 'undefined' || $("#assigneeDropdown").jqxDropDownList('getSelectedItem') == null)) {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': "Please provide assignee and task name.",
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
                                var assignee = $("#assigneeDropdown").jqxDropDownList('getSelectedItem').value;

                                if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                                    // console.log("User Details are " + sessionStorage.userDetails);
                                    var userdata = JSON.parse(sessionStorage.userDetails);

                                    var historySet = new Set();
                                    var history = {
                                        "taskHistoryAddedBy": userdata.userName,
                                        "taskHistoryDescription": "Task got created"
                                    }
                                    historySet.add(history);
                                    var taskToSave = JSON.stringify({
                                        "name": taskName,
                                        "addedBy": userdata.userName,
                                        "updatedBy": userdata.userName,
                                        "percentComplete": percentageComplete,
                                        "assignee": assignee,
                                        "description": description,
                                        "status": status,
                                        "priority": priority,
                                        "project": project,
                                        "acceptance":acceptance,
                                        "historyItems": Array.from(historySet.values())
                                    });

                                    $.ajax({
                                        url: 'tasks/create.htm',
                                        cache: false,
                                        type: 'POST',
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: taskToSave,
                                        error: function(res, textStatus, errorThrown) {
                                            $('#addTaskModal').modal('toggle');
                                            $('#tasksjqxgrid').jqxGrid('updatebounddata');

                                            alert(' Error :' + errorThrown);
                                        },
                                        success: function() {

                                            e.preventDefault();
                                            $('#addTaskModal').modal('toggle');
                                            $('#tasksjqxgrid').jqxGrid('updatebounddata');
                                            $("#taskName").val("");
                                            $("#description").val("");
                                            $("#assigneeDropdown").jqxDropDownList('clearSelection');

                                            $.confirm({
                                                'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                'message': "Saved the task  successfully",
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
                            }
                        });

                        $("#deleteTask").click(function() {
                            var rowindex = $('#tasksjqxgrid').jqxGrid('getselectedrowindex');

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
                            var rowdata = $('#tasksjqxgrid').jqxGrid('getrowdata', rowindex);

                            $.confirm({
                                'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                'message': "Do you want to delete the selected task ?",
                                'buttons': {
                                    'Yes': {
                                        'class': 'blue',
                                        'action': function() {

                                            $.post('tasks/delete/' + rowdata.taskid + '.htm').success(function(data) {
                                                $('#tasksjqxgrid').jqxGrid('updatebounddata');
                                                $.confirm({
                                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                    'message': "Deleted the task successfully",
                                                    'buttons': {
                                                        'OK': {
                                                            'class': 'blue',
                                                            'action': function() {
                                                                window.open('', '_self', '');
                                                            }
                                                        },
                                                    }
                                                });
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
                                name: 'taskid'
                            }, {
                                name: 'name'
                            }, {
                                name: 'description'
                            }, {
                                name: 'assignee'
                            }, {
                                name: 'addedBy'
                            }, {
                                name: 'status'
                            }, {
                                name: 'priority'
                            }, {
                                name: 'updatedBy',

                            }, {
                                name: 'project',

                            }, {
                                name: 'acceptance',
                                hidden : true,
                            },{
                                name: 'createdDate',
                                type: 'date',
                                format: 'dd-MM-yyyy HH.mm'
                            }, {
                                name: 'updatedDate',
                                type: 'date',
                                format: 'dd-MM-yyyy HH.mm'
                            }, {
                                name: 'percentComplete',
                            }],
                            id: 'taskid',
                            url: 'tasks/fetchAll.htm'
                        };

                        var dataChainAdapter = new $.jqx.dataAdapter(
                            sourceChainGrid);

                        $("#tasksjqxgrid").jqxGrid({
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
                            pageable: true,
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
                                text: 'Task Title',
                                datafield: 'name',
                                width: '25%'
                            }, {
                                text: 'Status',
                                datafield: 'status',
                                //hidden : true,
                                width: '8%'
                            }, {
                                text: 'Priority',
                                datafield: 'priority',
                                width: '8%'
                            }, {
                                text: 'Added By',
                                datafield: 'addedBy',
                                //hidden : true,
                                width: '5%'
                            }, {
                                text: 'Assignee',
                                datafield: 'assignee',
                                //hidden : true,
                                width: '10%'
                            }, {
                                text: 'Description',
                                datafield: 'description',
                                width: '20%'
                            }, {
                                text: '% Completed',
                                datafield: 'percentComplete',
                                //hidden: true,
                                width: '8%'
                            }, {
                                text: 'Project',
                                datafield: 'project',
                                //hidden: true,
                                width: '10%'
                            }, {
                                text: 'Updated Date',
                                datafield: 'updatedDate',
                                //hidden : true,
                                cellsformat: 'dd-MM-yyyy HH.mm',
                                width: '10%'
                            }, {
                                text: 'Created Date',
                                datafield: 'createdDate',
                                //hidden : true,
                                cellsformat: 'dd-MM-yyyy HH.mm',

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
                        <a href="#"><span style="font-size:25px; color:white;">Manage Tasks</span></a>
                    </div>
                    <div>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a id="addTask" href="#"><span class="glyphicon glyphicon-plus"></span> Add Task </a>
                            </li>
                            <li><a id="deleteTask" href="#"><span class="glyphicon glyphicon-remove"></span> Delete Task </a>
                            </li>

                            <li><a id="editTask" href="#"><span class="glyphicon glyphicon-pencil"></span> Update </a>
                            </li>
                            <li><a id="exportBtn" href="#"><span class="glyphicon glyphicon-share"></span> Export Tasks </a>
                            </li>
                            <li><a id="historyTask" href="#"><span class="glyphicon glyphicon-th-list"></span> Task History</a>
                            </li>

                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-sm-2" style="margin-top:5%; margin-left:5%;" id='projectFilterDropdown'>
            </div>
            <!--   <div class="col-sm-2" style="margin-top:5%; margin-left:5%;">
									<select class="form-control" id="projectFilter">
                                            <option value="Coffeebeans">Coffeebeans</option>
                                            <option value="Fastnext">Fastnext</option>
                                        </select>
                                    </div> -->

            <div id="tasksjqxgrid" style="margin-top:1%; margin-left:5%; " class="col-xs-12 col-sm-6 col-md-6 ">
            </div>

            <!-- Below Modal is for Add User -->
            <div class="modal fade" id="addTaskModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Add Task</h4>
                        </div>
                        <div class="modal-body col-md-12">
                            <form class="form-horizontal col-md-12">
                                <div class="form-group required">
                                    <label class="control-label" for="email">Task Title:</label>
                                    <input type="text" class="form-control" id="taskName" placeholder="Enter title" name="title">
                                </div>
                                <div class="form-group required">
                                    <label for="pwd">Description:</label>
                                    <textarea class="form-control" id="description" rows="6" placeholder="Enter Description" name="desc"></textarea>
                                </div>
								<div class="form-group">
                                    <label for="acceptance">Acceptance Criteria:</label>
                                    <textarea class="form-control" id="acceptance" rows="6" placeholder="Enter Acceptance Criteria" name="acceptance"></textarea>
                                </div>
                                <div class="form-group required">
                                    <label class="control-label col-sm-2" for="status">Status:</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="status">
                                            <option value="unassigned">Unassigned</option>
                                            <option value="readyForDev">Ready For Dev</option>
                                            <option value="inProgress">In Progress</option>
                                            <option value="testReady">Test Ready</option>
                                            <option value="blocked">Blocked</option>
                                            <option value="readyForProd">Ready for PROD</option>
                                            <option value="cancelled">Cancelled</option>
                                            <option value="dev-completed">Dev-Completed</option>
                                            <option value="QA-Done">QA-Done</option>
                                        </select>
                                    </div>


                                    <label class="control-label col-sm-2" for="assignee">Assignee:</label>
                                    <div class="col-sm-4">
                                        <div id="assigneeDropdown"></div>
                                    </div>
                                </div>

                                <div class="form-group required">
                                    <label class="control-label col-sm-2" for="status">Priority:</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="priority">
                                            <option value="HIGH">High</option>
                                            <option value="MEDIUM">Medium</option>
                                            <option value="LESS">Less</option>

                                        </select>
                                    </div>


                                    <label class="control-label col-sm-2" for="project">Project</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="project">
                                            <option value="Coffeebeans">Coffeebeans</option>
                                            <option value="Fastnext">Fastnext</option>
                                            <option value="Wru">Wru</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="pwd">Percentage of Completion</label>
                                    <div id="slidecontainer">
                                        <input type="range" min="0" max="100" value="0" class="slider" id="myRange">
                                        <p>Current Percentage : <span id="percentageComplete"></span>%</p>
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
            <div class="modal fade" id="editTaskModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Update Task</h4>
                        </div>
                        <div class="modal-body col-md-12">
                            <form class="form-horizontal col-md-12">
                                <div class="form-group">
                                    <label class="control-label" for="email">Task Title:</label>
                                    <input type="text" class="form-control" id="updateTaskName" placeholder="Task Title" name="title" readonly>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Description:</label>
                                    <textarea class="form-control" id="updateDescription" rows="4" placeholder="Description of the task" name="desc" readonly></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="acceptance">Acceptance Criteria:</label>
                                    <textarea class="form-control" id="updateAcceptance" rows="3" placeholder="Acceptance Criteria" name="acceptance"></textarea>
                                </div>
                                <div class="form-group">
                                    <label for="pwd">Provide update:</label>
                                    <textarea class="form-control" id="historyDescription" rows="8" placeholder="Provide your updates on task" name="desc"></textarea>
                                </div>
                                <div class="form-group">
                                    <label class="control-label col-sm-2" for="status">Status:</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="updateStatus">
                                            <option value="unassigned">Unassigned</option>
                                            <option value="readyForDev">Ready For Dev</option>
                                            <option value="inProgress">In Progress</option>
                                            <option value="testReady">Test Ready</option>
                                            <option value="blocked">Blocked</option>
                                            <option value="readyForProd">Ready for PROD</option>
                                            <option value="cancelled">Cancelled</option>
                                            <option value="dev-completed">Dev-Completed</option>
                                            <option value="QA-Done">QA-Done</option>
                                        </select>
                                    </div>


                                    <label class="control-label col-sm-2" for="assignee">Assignee:</label>
                                    <div class="col-sm-4">
                                        <div id="updateAssigneeDropdown"></div>
                                    </div>
                                </div>

                                <div class="form-group required">
                                    <label class="control-label col-sm-2" for="status">Priority:</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="updatePriority">
                                            <option value="HIGH">High</option>
                                            <option value="MEDIUM">Medium</option>
                                            <option value="LESS">Less</option>

                                        </select>
                                    </div>


                                    <label class="control-label col-sm-2" for="project">Project</label>
                                    <div class="col-sm-4">
                                        <select class="form-control" id="updateProject">
                                            <option value="Coffeebeans">Coffeebeans</option>
                                            <option value="Fastnext">Fastnext</option>
                                            <option value="Wru">Wru</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="pwd">Percentage of Completion:</label>
                                    <div id="slidecontainer">
                                        <input type="range" min="0" max="100" value="0" class="slider" id="updateMyRange">
                                        <p>Current Percentage : <span id="updatePercentageComplete"></span>%</p>
                                    </div>


                                </div>


                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="updateTaskToDb">Update</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>

                </div>
            </div>

            <!-- Below Modal is for Task History-->
            <div class="modal fade" id="historyTaskModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Task History</h4>
                        </div>
                        <div class="modal-body col-md-12">

                            <div id="taskHistjqxgrid" class="col-xs-12 col-sm-12 col-md-12">
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                        </div>
                    </div>

                </div>
            </div>

            <input type="hidden" id="chosenTaskAddedBy" />
            <input type="hidden" id="chosenTaskProject" />
            <input type="hidden" id="chosenTaskCreated" />
            <input type="hidden" id="chosenTaskId" />
            <input type="hidden" id="chosenTaskPriority" />

            <%@ include file="footer.jsp" %>
