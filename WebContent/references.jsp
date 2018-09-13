<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@include file="automator.jsp" %>
        <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
        <html>

        <head>
            <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
            <meta http-equiv="CACHE-CONTROL" content="NO-CACHE" />
            <meta http-equiv="PRAGMA" content="NO-CACHE" />
            <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
            <title>References</title>
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
                function uploadFileToDrive() {
                    var fileName = $("#dataFile").val();
                    var title = $("#uploadTitle").val().trim();
                    var split = fileName.split("\\");

                    // file does not end with .xls format, show error     
                    if (validationAndSubmit(split[split.length - 1])) {
                        $.confirm({
                            'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                            'message': ' File uploaded successfully with name ' + split[split.length - 1],
                            'buttons': {
                                'OK': {
                                    'class': 'blue',
                                    'action': function() {
                                        $("#uploadModal").modal('toggle');
                                        window.location.reload();
                                        window.open('', '_self', '');
                                    }
                                },
                            }
                        });

                    }
                }

                function validationAndSubmit(fileName) {

                    $("#fileName").val(fileName);
                    var title = $("#uploadTitle").val().trim();

                    if (isEmpty(title) || isEmpty(fileName)) {
                        $.confirm({
                            'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                            'message': "Please provide file and reference title to upload !!",
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

                    /* Create a FormData instance */
                    var formData = new FormData();

                    // console.log("User Details are " + sessionStorage.userDetails);
                    var userdata = JSON.parse(sessionStorage.userDetails);

                    /* Add the file */
                    formData.append("dataFile", document.getElementById("dataFile").files[0]);
                    formData.append("filename", fileName);
                    formData.append("title", title);
                    formData.append("addedBy", userdata.userName);

                    $.ajax({
                        type: 'post',
                        enctype: 'multipart/form-data',
                        data: formData,
                        cache: false,
                        processData: false,
                        contentType: false,
                        url: 'export/upload.htm',
                        success: function(data) {

                        },
                        error: function(request, status, err) {
                            result = "error";
                        }
                    });
                    return true;
                }



                $(document).ready(function() {

                    if (checkAccess()) {


                        // show Add user modal
                        $("#addMapping").click(function() {
                            $('#addLinkModal').modal('show');
                        });

                        //=====================			    
                        $("#saveMapping").click(function(e) {
                            var title = $("#title").val().trim();
                            var link = $("#link").val().trim();

                            if (isEmpty(title) || isEmpty(link)) {
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

                                if (!isEmpty(sessionStorage.userDetails) && sessionStorage.userDetails != 'undefined') {
                                    // console.log("User Details are " + sessionStorage.userDetails);
                                    var userdata = JSON.parse(sessionStorage.userDetails);

                                    var linkToSave = JSON.stringify({
                                        "title": title,
                                        "reference": link,
                                        "addedBy": userdata.userName
                                    });

                                    $.ajax({
                                        url: 'ref/create.htm',
                                        cache: false,
                                        type: 'POST',
                                        contentType: "application/json",
                                        dataType: "json",
                                        data: linkToSave,
                                        error: function(res, textStatus, errorThrown) {
                                            $('#addLinkModal').modal('toggle');
                                            $('#mappingjqxgrid').jqxGrid('updatebounddata');

                                            alert(' Error :' + errorThrown);
                                        },
                                        success: function(data) {

                                            e.preventDefault();
                                            $('#addLinkModal').modal('toggle');
                                            $('#mappingjqxgrid').jqxGrid('updatebounddata');

                                            if (data == 1) {
                                                $.confirm({
                                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                    'message': "Saved the reference link successfully",
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
                                                    'message': "Mapping already exists.",
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
                                        }
                                    });
                                }
                            }
                        });

                        $("#mappingjqxgrid").bind('rowselect', function(event) {

                            var selectedRowIndex = event.args.rowindex;
                            var rowdata = $('#mappingjqxgrid').jqxGrid('getrowdata', selectedRowIndex);
                            if (rowdata.type == "Upload") {
                                $.confirm({
                                    'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                    'message': '  Do you want to download the selected file ?',
                                    'buttons': {
                                        'Yes': {
                                            'class': 'blue',
                                            'action': function() {

                                                var url = 'export/file.htm';
                                                var method = 'post';
                                                var inputs = '<input type="hidden" name="link" value="' + rowdata.reference + '" />';
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
                            }
                        });

                        $("#mappingjqxgrid").bind('rowunselect', function(event) {
                            var unselectedRowIndex = event.args.rowindex;
                        });

                        $("#deleteMapping").click(function() {
                            var rowindex = $('#mappingjqxgrid').jqxGrid('getselectedrowindex');

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
                            var rowdata = $('#mappingjqxgrid').jqxGrid('getrowdata', rowindex);

                            $.confirm({
                                'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                'message': "Do you want to delete the selected reference link ?",
                                'buttons': {
                                    'Yes': {
                                        'class': 'blue',
                                        'action': function() {

                                            /*
                                                                                        $.post('mapping/delete.htm').success(function(data) {
                                                                                            $('#usersjqxgrid').jqxGrid('updatebounddata');
                                                                                        });
                                            */



                                            $.ajax({
                                                url: 'ref/delete/' + rowdata.refId + '.htm',
                                                cache: false,
                                                type: 'POST',
                                                contentType: "application/json",
                                                dataType: "json",
                                                error: function(res, textStatus, errorThrown) {

                                                    alert(' Error :' + errorThrown);
                                                },
                                                success: function() {

                                                    $('#mappingjqxgrid').jqxGrid('updatebounddata');

                                                    $.confirm({
                                                        'title': '<img width="30" height="35" src="resources/CoffeeBean1.jpg" />' + ' CoffeeBeans',
                                                        'message': "Deleted the reference link successfully",
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
                                name: 'refId'
                            }, {
                                name: 'type'
                            }, {
                                name: 'title'
                            }, {
                                name: 'reference'
                            }],
                            id: 'refId',
                            url: 'ref/fetchAll.htm'
                        };

                        var cellsrenderer = function(row, columnfield, value, defaulthtml, columnproperties, rowdata) {
                            if (rowdata.type == 'Link') {
                                return '<a target="_blank" href="' + value + '"/>' + value + '</a>'
                            } else {
                                return value;
                            }
                        }
                        var dataChainAdapter = new $.jqx.dataAdapter(
                            sourceChainGrid);
                        $("#mappingjqxgrid").jqxGrid({
                            width: '70%',
                            height: 400,
                            source: dataChainAdapter,
                            theme: 'energyblue',
                            selectionmode: 'singlerow',
                            sortable: true,
                            filterable: true,
                            ready: function() {},
                            columns: [{
                                text: 'Title',
                                datafield: 'title',
                                width: '40%'
                            }, {
                                text: 'Link',
                                datafield: 'reference',
                                cellsrenderer: cellsrenderer,
                                width: '60%'
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
                        <a href="#"><span style="font-size:25px; color:white;">Reference Links</span></a>
                    </div>
                    <div>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a class="btn" id="uploadBtn" data-toggle="modal" data-target="#uploadModal" href="#"><span class="glyphicon glyphicon-open"></span> Upload </a>
                            </li>

                            <li><a id="addMapping" href="#"><span class="glyphicon glyphicon-screenshot"></span> Add Reference</a>
                            </li>
                            <li><a id="deleteMapping" href="#"><span class="glyphicon glyphicon-remove"></span> Delete Reference </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <div id="mappingjqxgrid" style="margin-top:5%; margin-left:15%;" class="col-xs-12 col-sm-6 col-md-6 ">
            </div>

            <!-- Below Modal is for Upload Reference -->
            <div class="modal fade" id="uploadModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Upload Data</h4>
                        </div>
                        <div class="modal-body">
                            <form id="fileUploadForm" target="_blank">
                                <div class="form-group required">
                                    <label for="firstName" class="col-sm-3 control-label">Reference Title</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" style="height:34px;" id="uploadTitle" placeholder="Provide title for upload">
                                    </div>
                                </div>

                                <label id="header" style="font-style: italic;color: red;">Please choose any file to upload </label>
                                <input id="fileName" type="hidden" name="fileName" value="" />
                                <input id="dataFile" name="dataFile" style=" margin-top: 2%; font-size: 12px; height: 20px; width: 60%;" class="fileupload" type="file">

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" onclick="javascript:uploadFileToDrive();">Upload File</button>
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>

                </div>
            </div>


            <!-- Below Modal is for Add Reference -->
            <div class="modal fade" id="addLinkModal" role="dialog">
                <div class="modal-dialog">

                    <!-- Modal content-->
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Add Reference</h4>
                        </div>
                        <div class="modal-body col-md-12">
                            <form class="form-horizontal">
                                <div class="form-group required">
                                    <label for="title" class="col-sm-3 control-label"> Title</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" style="height:34px;" id="title" placeholder="Provide title for link">
                                    </div>
                                </div>
                                <div class="form-group required">
                                    <label for="email" class="col-sm-3 control-label">Link</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" style="height:34px;" id="link" placeholder="Provide the link">
                                    </div>
                                </div>

                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" id="saveMapping">Save</button>
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