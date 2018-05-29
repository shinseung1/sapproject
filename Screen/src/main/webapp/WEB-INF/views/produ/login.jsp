<!DOCTYPE html>
<html lang="ko">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <!-- Meta, title, CSS, favicons, etc. -->
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <title>MES Project</title>

  <!-- Bootstrap -->
  <link href="${pageContext.request.contextPath}/resources/vendors/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link href="${pageContext.request.contextPath}/resources/vendors/font-awesome/css/font-awesome.min.css" rel="stylesheet">
  <!-- NProgress -->
  <link href="${pageContext.request.contextPath}/resources/vendors/nprogress/nprogress.css" rel="stylesheet">
  <!-- Animate.css -->
  <link href="${pageContext.request.contextPath}/resources/vendors/animate.css/animate.min.css" rel="stylesheet">
 
  <!-- Custom Theme Style -->
  <!-- 2018.05.15, songyee, change css file (min->original)  -->
  <link href="${pageContext.request.contextPath}/resources/build/css/custom.css" rel="stylesheet">
</head>
<body class="login">
  <div>
    <div class="login_wrapper">
      <div class="animate form login_form">
        <section class="login_content">
          <form>
           <h1><i class="glyphicon glyphicon-user"></i> Login</h1>

           <!-- id -->
           <div class="form-group">
             <label class="control-label col-md-3 col-sm-3 col-xs-12">User id</label>
             <div class="col-md-9 col-sm-9 col-xs-12">
               <input type="text" id="userid" class="form-control" placeholder="User" required  autofocus />
             </div>
           </div>

           <!-- password -->
           <div class="form-group">
             <label class="control-label col-md-3 col-sm-3 col-xs-12">Password</label>
             <div class="col-md-9 col-sm-9 col-xs-12">
               <input type="password"  id="password" class="form-control" placeholder="Password" required />
             </div>
           </div>

           <!-- Logon language -->
           <div class="form-group">
             <label class="control-label col-md-3 col-sm-3 col-xs-12">Logon Language</label>
             <div class="col-md-3 col-sm-3 col-xs-3">
               <input type="text" class="form-control" value="KO" readonly/>
             </div>
           </div>
           <!-- login Button -->
           <div class="control-label col-md-12 col-sm-12 col-xs-12">
            <a class="btn btn-info" style="text-shadow: none; font-size:medium;" href="report.html">Login</a>
            <!--<a class="reset_pass" href="#">Lost your password?</a> -->
          </div>

          <div class="clearfix"></div>

          <div class="separator">

            <div>
              <h1><i class="fa fa-users"></i> MES Project 1.0 ver.</h1>
              <p>©2018 Smart Factory MES Project </p>
            </div>
          </div>
        </form>
      </section>
    </div>
  </div>
</div>
</body>
</html>
