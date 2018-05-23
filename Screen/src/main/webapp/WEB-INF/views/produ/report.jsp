<!DOCTYPE html>
<html lang="ko">

<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!-- Meta, title, CSS, favicons, etc. -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>MES Project | Report</title>

  <!-- Bootstrap -->
  <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="${pageContext.request.contextPath}/resources/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <!-- NProgress -->
  <link href="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.css" rel="stylesheet">
  <!-- iCheck -->
  <link href="${pageContext.request.contextPath}/resources/vendors/iCheck/skins/flat/green.css" rel="stylesheet">
  <!-- bootstrap-progressbar -->
  <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap-progressbar/css/bootstrap-progressbar-3.3.4.min.css" rel="stylesheet">
  <!-- PNotify-->
  <link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.buttons.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.nonblock.css" rel="stylesheet"> 

  <!-- Datatables -->
  <link href="${pageContext.request.contextPath}/resources/vendors/datatables.net-bs/css/dataTables.bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons-bs/css/buttons.bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/vendors/datatables.net-fixedheader-bs/css/fixedHeader.bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/vendors/datatables.net-responsive-bs/css/responsive.bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/resources/vendors/datatables.net-scroller-bs/css/scroller.bootstrap.min.css" rel="stylesheet">

  <!-- bootstrap-daterangepicker -->
  <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet">



  <!-- Custom Theme Style -->
  <link href="${pageContext.request.contextPath}/resources/build/css/custom.min.css" rel="stylesheet">
</head>

<body class="nav-md">
  <div class="container body">
    <div class="main_container">
      <!-- page content -->
      <div class="right_col" role="main">

        <!-- Page title -->
        <div class="page-title">
          <div class="title_left">
            <h3>Inspection Report</h3>
          </div>
        </div>
        

        

        <!-- Search Session -->
        <div class="col-md-12 col-sm-12 col-xs-12">
          <div class="x_panel">

            <!-- 검색창 패널  -->
            <ul class="nav navbar-right panel_toolbox">
              <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
              </li>


            </ul>
            
            <div class="clearfix"></div>

            <div class="x_content" style="padding: 0;">
             <!-- 날짜 검색  -->
             <label class="control-label col-md-1 col-sm-2 col-xs-2" >Complete Date</label>
             <div class="col-md-11 col-sm-10 col-xs-10" style="margin-bottom: 20px;">
              <div id="reportrange" class="pull-left"  style="background: #fff; cursor: pointer; padding: 5px 10px; border: 1px solid #ccc">
                <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                <span>December 30, 2014 - January 28, 2015</span> <b class="caret"></b>
              </div>
            </div>
            <!-- 물품 선택 --> 
            <label class="control-label col-md-1 col-sm-2 col-xs-2">Quality Type</label>
            <div class="col-md-4 col-sm-4 col-xs-4 pull-left" style="margin-bottom: 10px; margin-right: 50px; ">
              <select class="form-control">
                <option>All selection</option>
                <option>Good</option>
                <option>Defective</option>
              </select>
            </div>

            <!-- 공정 선택 --> 
            <label class="control-label col-md-1 col-sm-1 col-xs-1">Process</label>
            <div class="col-md-4 col-sm-4 col-xs-4" style="margin-bottom: 20px;">
              <select class="form-control">
                <option>Choose process...</option>
                <option>Process 1</option>
                <option>Process 2-1</option>
                <option>Process 2-2</option>
              </select>
            </div>

            <!-- search button -->
            <div class="control-label col-md-12 col-sm-12 col-xs-12">
              <a class="btn btn-success" type="submit" style="float: right;" href="#">Search</a>
              <a class="btn btn-primary" type="reset" style="float: right;" href="#">Reset</a>
              <!--<a class="reset_pass" href="#">Lost your password?</a> -->
            </div>

          </div>
        </div>
      </div>

      <div class="clearfix"></div>

      <!-- Tab Session-->
      <div class="col-md-12 col-sm-12 col-xs-12">
        <div class="x_panel">                 
          <!-- Content-->
          <div class="x_content">
            <!-- (Tab + 내용) 한쌍-->
            <div class="" role="tabpanel" data-example-id="togglable-tabs">
              <ul id="myTab1" class="nav nav-tabs bar_tabs" role="tablist">
                <!-- Table Tab btn-->
                <li role="presentation" class="active"><a href="#tab_content11" id="home-tabb" role="tab" data-toggle="tab" aria-controls="home" aria-expanded="true"><i class="fa fa-table"></i>&nbsp;Table</a>
                </li>
                <!-- Graph Tab btn-->
                <li role="presentation" class=""><a href="#tab_content22" role="tab" id="profile-tabb" data-toggle="tab" aria-controls="profile" aria-expanded="false"><i class="fa fa-area-chart"></i>&nbsp;Graph</a>
                </li>                  
              </ul>

              <div id="myTabContent2" class="tab-content">
                <!-- table content-->
                <div role="tabpanel" class="tab-pane fade active in" id="tab_content11" aria-labelledby="home-tab">
                  <div class="col-md-12 col-sm-12 col-xs-12">
                    <div class="x_panel"> 
                      <div class="col-md-12 col-sm-12 col-xs-12" style="height: 20px;"></div>
                      <div class="x_title">
                        </i><h2>Product conditions <small>2018/04/28 - 2018/05/28</small></h2>
                        <div class="clearfix"></div>
                      </div>      
                      <div class="x_content">

                        <table id="datatable-buttons" class="table table-striped jambo_table bulk_action" style="width:100%">
                          <thead>
                            <tr>
                              <th>Row_num</th>
                              <th>Product_number </th>
                              <th>Unit1_end_time</th>
                              <th>Unit2_end_time</th>
                              <th>Unit2.2_end_time</th>
                              <th>Unit1_check_result</th>
                              <th>Unit2_check_result</th>
                              <th>Unit2.2_check_result</th>
                            </tr>
                          </thead>

                          <tbody>
                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>


                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>


                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>

                            <tr>
                              <td>1</td>
                              <td>1</td>
                              <td>2018.04.25 10:11:85</td>
                              <td>2018.04.25 11:11:85</td>
                              <td>2018.04.25 12:11:85</td>
                              <td>Y</td>
                              <td>Y</td>
                              <td>N</td>
                            </tr>
                          </tbody>
                        </table>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- Graph content-->
                <div role="tabpanel" class="tab-pane fade" id="tab_content22" aria-labelledby="profile-tab">


                  <div class="col-md-12">
                    <div class="x_panel">

                      <div class="col-md-12 col-sm-12 col-xs-12" style="height: 20px;"></div>

                      <div class="x_title">
                        <h2>Product conditions <small>2018/04/28 - 2018/05/28</small></h2>
                        <div class="clearfix"></div>
                      </div>
                      <div class="x_content">
                        <div class="col-md-12 col-sm-12 col-xs-12">
                          <!-- 처리량, 불량률, 양품생산량 --> 
                          <!-- Moris.js - Graph area -->
                          <div class="demo-container" style="height:280px">
                            <div id="graph_area" style="width:100%; height:300px;"></div>
                          </div>

                          <!-- 불량구역 -->
                          <!-- Charts.js - Pie Graph Chart -->
                          <!-- eCharts.js - Pie Graph Chart -->
                          <div class="tiles">
                             <br>                        
                            <div class="col-md-4 tile overflow_hidden">
                              <!-- <span></span> -->
                              <h2>Defective Area</h2>
                              <!-- <canvas id="pieChart" style="width:350px; height:300px;"></canvas> -->
                              <div id="echart_pie" style="width:410px;height:300px;"></div>
                            </div>

                            <!-- 불량률 (처리량-양품생산량)/처리량 -->
                            <!-- Moris.js - line graph -->
                            <div class="col-md-4 tile overflow_hidden">
                              <h2>Defective Rates By Date</h2>
                              <div id="graph_line" style="width:410px; height:300px;"></div>
                            </div>

                            <!-- 현재 목표달성률 --> 
                            <!-- echart.js - gauge -->
                            <div class="col-md-4 tile overflow_hidden">
                              <h2>Goal Achievement Rates Of Processes</h2>
                              <div id="echart_gauge" style="width:410px; height:300px;"></div>
                            </div>
                          </div>

                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- 현재 목표달성률 --> 
                  <!-- echart.js - gauge -->
              <!--  <div class="row">
                <div class="col-md-12" >
                  <div class="">
                    <div class="x_title">
                      <h2>Goal achievement chart </h2>
                      <div class="clearfix"></div>
                    </div>
                    <div class="x_content2">
                      <div id="echart_gauge" style="width:200px; height:200px;"></div>
                    </div>
                  </div>
                </div>
              </div> -->

              <!-- 처리량, 불량률, 양품생산량 --> 
              <!-- Moris.js - Graph area -->
             <!--  <div class="row">
                <div class="col-md-12">
                  <div class="x_panel">
                    <div class="x_title">
                      <h2>Product conditions</h2>
                      <div class="clearfix"></div>
                    </div>

                    <div class="x_content2">
                      <div id="graph_area" style="width:100%; height:300px;"></div>
                    </div>
                  </div>
                </div>
              </div> -->
              <!-- 불량구역 -->
              <!-- Charts.js - Pie Graph Chart -->
              <!-- <div class="row">
                
                <div class="col-md-6 col-sm-6 col-xs-12">
                  <div class="tile fixed_height_400 overflow_hidden">
                    <div class="x_title">
                      <h2>Defactive area</h2>
                      <div class="clearfix"></div>

                    </div>
                    <div class="x_content2">
                      <canvas id="pieChart" style="width:350px; height:300px;"></canvas>
                    </div>
                  </div>
                </div> -->
                <!-- /bar charts group -->

                <!-- 불량률 (처리량-양품생산량)/처리량 -->
                <!-- Moris.js - line graph -->
                <!-- <div class="col-md-6 col-sm-6 col-xs-12">
                  <div class="tile fixed_height_400 overflow_hidden">
                    <div class="x_title">
                      <h2>Defactive rate</h2>
                      <div class="clearfix"></div>

                    </div>
                    <div class="x_content2">
                      <div id="graph_line" style="width:350px; height:300px;"></div>
                    </div>
                  </div>
                </div> -->
                <!-- /line graph -->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Tab Session-->
  </div>




  <div class="clearfix"></div>
</div>

<!-- /page content -->

<!-- footer content -->
<footer>
  <div class="pull-right">
    Gentelella - Bootstrap Admin Template by <a href="https://colorlib.com">Colorlib</a>
  </div>
  <div class="clearfix"></div>
</footer>
<!-- /footer content -->
</div>


<div id="custom_notifications" class="custom-notifications dsp_none">
  <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
  </ul>
  <div class="clearfix"></div>
  <div id="notif-group" class="tabbed_notifications"></div>
</div>
</div>
<!-- jQuery -->
<script src="${pageContext.request.contextPath}/resources/vendors/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap -->
<script src="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- FastClick -->
<script src="${pageContext.request.contextPath}/resources/vendors/fastclick/lib/fastclick.js"></script>
<!-- NProgress -->
<script src="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.js"></script>
<!-- bootstrap-progressbar -->
<script src="${pageContext.request.contextPath}/resources/vendors/bootstrap-progressbar/bootstrap-progressbar.min.js"></script>
<!-- iCheck -->
<script src="${pageContext.request.contextPath}/resources/vendors/iCheck/icheck.min.js"></script>
<!-- PNotify 
<script src="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.buttons.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/pnotify/dist/pnotify.nonblock.js"></script>-->

<!-- Custom Theme Scripts -->
<script src="${pageContext.request.contextPath}/resources/build/js/custom.min.js"></script>

<!-- Datatables -->
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons-bs/js/buttons.bootstrap.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons/js/buttons.flash.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-fixedheader/js/dataTables.fixedHeader.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-responsive-bs/js/responsive.bootstrap.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/datatables.net-scroller/js/dataTables.scroller.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/jszip/dist/jszip.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/pdfmake/build/pdfmake.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/pdfmake/build/vfs_fonts.js"></script>

<!-- ECharts -->
<script src="${pageContext.request.contextPath}/resources/vendors/echarts/dist/echarts.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/echarts/map/js/world.js"></script>

<!-- morris.js -->
<script src="${pageContext.request.contextPath}/resources/vendors/raphael/raphael.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/morris.js/morris.min.js"></script>

<!-- Chart.js -->
<script src="${pageContext.request.contextPath}/resources/vendors/Chart.js/dist/Chart.min.js"></script>

<!-- bootstrap-daterangepicker -->
<script src="${pageContext.request.contextPath}/resources/vendors/moment/min/moment.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/vendors/bootstrap-daterangepicker/daterangepicker.js"></script>

</body>
</html>