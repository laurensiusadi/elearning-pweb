<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <?php
  $string = Breadcrumbs::render(explode('/', Route::getCurrentRoute()->getPath())[0]);
  $start = '<li class="active">';
  $end = '</li>';
  $pos = stripos($string, $start);
  $str = substr($string, $pos);
  $str_two = substr($str, strlen($start));
  $second_pos = stripos($str_two, $end);
  $str_three = substr($str_two, 0, $second_pos);
  $unit = trim($str_three); // remove whitespaces
  ?>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="_token" content="{!! csrf_token() !!}"/>
  <title>ELearning | {{ $unit }}</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  <!-- Bootstrap 3.3.6 -->
  <link rel="stylesheet" href="{{ asset('/bower_components/AdminLTE/bootstrap/css/bootstrap.min.css') }}">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
  <!-- Ionicons -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="{{ asset('/bower_components/AdminLTE/dist/css/AdminLTE.min.css') }}">
  <!-- AdminLTE Skins. We have chosen the skin-blue for this starter
        page. However, you can choose any other skin. Make sure you
        apply the skin class to the body tag so the changes take effect.
      -->
      <link rel="stylesheet" href="{{ asset('/bower_components/AdminLTE/dist/css/skins/skin-blue.min.css') }}">
      <!-- bootstrap datepicker -->
      <link rel="stylesheet" href="{{ asset('/bower_components/AdminLTE/plugins/datepicker/datepicker3.css') }}">
      <!-- daterange picker -->
      <link rel="stylesheet" href="{{ asset('/bower_components/AdminLTE/plugins/daterangepicker/daterangepicker-bs3.css') }}">
      <!-- Bootstrap time Picker -->
      <link rel="stylesheet" href="{{ asset('/bower_components/AdminLTE/plugins/timepicker/bootstrap-timepicker.min.css') }}">
      <!-- DataTables -->
      <link rel="stylesheet" href="{{ asset('/bower_components/AdminLTE/bootstrap/css/site.css') }}">
      <!-- Animated -->
      <link rel="stylesheet" href="{{ asset('/bower_components/AdminLTE/plugins/datatables/dataTables.bootstrap.css') }}">
      <!-- iCheck for checkboxes and radio inputs -->
      <link rel="stylesheet" href="{{ asset('/bower_components/AdminLTE/plugins/iCheck/all.css') }}">
      <!-- jQuery 2.2.0 -->
      <script src="{{ asset('/bower_components/AdminLTE/plugins/jQuery/jQuery-2.2.0.min.js') }}"></script>
      <!-- Bootstrap 3.3.6 -->
      <script src="{{ asset('/bower_components/AdminLTE/bootstrap/js/bootstrap.min.js') }}"></script>
      <!-- AdminLTE App -->
      <script src="{{ asset('/bower_components/AdminLTE/dist/js/app.min.js') }}"></script>
      <!-- DataTables -->
      <script src="{{ asset('/bower_components/AdminLTE/plugins/datatables/jquery.dataTables.min.js') }}"></script>
      <script src="{{ asset('/bower_components/AdminLTE/plugins/datatables/dataTables.bootstrap.min.js') }}"></script>
      <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
      <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
  <!--[if lt IE 9]>
  <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
  <![endif]-->
</head>
<body class="hold-transition skin-blue sidebar-mini">

  <div id="modal-delete" class="modal fade modal-danger">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">&times;</span></button>
            <h4 class="modal-title">Konfirmasi</h4>
          </div>
          <div class="modal-body">
            <p></p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-outline pull-left" data-dismiss="modal">Batal</button>
            <form id="data-delete" method="POST">
              <input type="hidden" name="_method" value="delete"></input>
              {!! csrf_field() !!}
              <input class="btn btn-outline" type="submit" value="Yakin"></input>
            </form>
          </div>
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>
  </div>

  <div id="modal-compile-info" class="modal fade modal-info">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">Menunggu.....</h4>
        </div>
        <div class="modal-body">
          <center>
            <span class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>
          </center>
        </div>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </div>
</div>

<div id="modal-compile-success" class="modal fade modal-success">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Pemberitahuan</h4>
        </div>
        <div class="modal-body">
          <p>Kode program bisa dicompile</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline pull-right" data-dismiss="modal">OK</button>
        </div>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </div>
</div>

<div id="modal-compile-warning" class="modal fade modal-warning">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span></button>
          <h4 class="modal-title">Pemberitahuan</h4>
        </div>
        <div class="modal-body">
          <p>Kode program tidak bisa dicompile</p>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-outline pull-right" data-dismiss="modal">OK</button>
        </div>
      </div>
      <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
  </div>
</div>

<div class="wrapper">

  <!-- Main Header -->
  <header class="main-header">

    <!-- Logo -->
    <a href="{{ url('home') }}" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>E</b></span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>E</b>Learning</span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- User Account Menu -->
          <li class="dropdown user user-menu">
            <!-- Menu Toggle Button -->
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <!-- The user image in the navbar-->
              <img src="{{ asset('/bower_components/AdminLTE/dist/img/avatar5.png') }}" class="user-image" alt="User Image">
              <!-- hidden-xs hides the username on small devices so only the image appears. -->
              <span class="hidden-xs">{{ Auth::user()->name }}</span>
            </a>
            <ul class="dropdown-menu">
              <!-- The user image in the menu -->
              <li class="user-header">
                <img src="{{ asset('/bower_components/AdminLTE/dist/img/avatar5.png') }}" class="img-circle" alt="User Image">

                <p>
                  {{ Auth::user()->name }}
                  <small>Informatika ITS</small>
                </p>
              </li>
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-right">
                  <a href="{{ url('/logout') }}" class="btn btn-default btn-danger btn-flat" style="color:white">Sign out</a>
                </div>
              </li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
  </header>
  <!-- Left side column. contains the logo and sidebar -->
  <aside class="main-sidebar">

    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
      <div class="user-panel">
        <div class="pull-left image">
          <img src="{{ asset('/bower_components/AdminLTE/dist/img/avatar5.png') }}" class="img-circle" alt="User Image">
        </div>
        <div class="pull-left info">
          <p>{{ Auth::user()->name }}</p>
          <!-- Status -->
          <a href="#"><i class="fa fa-circle text-success"></i> Online</a>
        </div>
      </div>

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu">
        <!-- Optionally, you can add icons to the links -->
        @role(env('ROLE_ADMIN').'|'.env('ROLE_DOSEN'))
        <li class="{{ Request::is('post') ? 'active' : '' }}">
          <a href="{{ url('post') }}"><i class="fa fa-bell-o"></i> <span>Pengumuman</span></a>
        </li>
        @endrole
        @role(env('ROLE_ADMIN'))
        <li class="header">Manajemen Akses</li>
        <li class="{{ Request::is('user') ? 'active' : '' }}">
          <a href="{{ url('user') }}"><i class="fa fa-user"></i> <span>Pengguna</span></a>
        </li>
        <li class="{{ Request::is('role') ? 'active' : '' }}">
          <a href="{{ url('role') }}"><i class="fa fa-gear"></i> <span>Role</span></a>
        </li>
        <li class="{{ Request::is('permission') ? 'active' : '' }}">
          <a href="{{ url('permission') }}"><i class="fa fa-warning"></i> <span>Permission</span></a>
        </li>
        <li class="header">Manajemen Perkuliahan</li>
        <li class="{{ Request::is('period') ? 'active' : '' }}">
          <a href="{{ url('period') }}"><i class="fa fa-calendar"></i> <span>Periode Perkuliahan</span></a>
        </li>
        <li class="{{ Request::is('subject') ? 'active' : '' }}">
          <a href="{{ url('subject') }}"><i class="fa fa-book"></i> <span>Matakuliah</span></a>
        </li>
        @endrole
        <li class="header">Manajemen Kursus</li>
        @role(env('ROLE_ADMIN'))
        <li class="{{ Request::is('convention') ? 'active' : '' }}">
          <a href="{{ url('convention') }}"><i class="fa fa-file"></i> <span>Konvensi Gaya Penulisan Kode</span></a>
        </li>
        <li class="{{ Request::is('course') ? 'active' : '' }}">
          <a href="{{ url('course') }}"><i class="fa fa-graduation-cap"></i> <span>Kursus</span></a>
        </li>
        @endrole
        @role(env('ROLE_MHS').'|'.env('ROLE_DOSEN'))
        <li class="{{ Request::is('enroll') ? 'active' : '' }}">
          <a href="{{ url('enroll') }}"><i class="fa fa-group"></i> <span>Kursus Saya</span></a>
        </li>
        @endrole
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
  </aside>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        {{ $unit }}
        <small>{{ explode('/', Route::getCurrentRoute()->getPath())[0] }}</small>
      </h1>
      <ol class="breadcrumb">
        {!! Breadcrumbs::render(explode('/', Route::getCurrentRoute()->getPath())[0]) !!}
      </ol>
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Your Page Content Here -->
      @yield('content')

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
  <footer class="main-footer">
    <!-- To the right -->
    <div class="pull-right hidden-xs">
      Informatics Department
    </div>
    <!-- Default to the left -->
    <strong>Copyright &copy; 2016 <a href="#">Developer</a>.</strong> All rights reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript::;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript::;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="label label-danger pull-right">70%</span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
</div>
<div class="control-sidebar-bg"></div>
</body>
<form id="compileform" action="http://cpp.sh/irun" method="POST">
  <input id="inputcompile" type="hidden" name="source">
  <input id="timer" type="hidden" name="timer">
</form>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

<!-- Datepicker -->
<script src="{{ asset('/bower_components/AdminLTE/plugins/datepicker/bootstrap-datepicker.js') }}"></script>
<!-- date-range-picker -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.11.2/moment.min.js"></script>
<script src="{{ asset('/bower_components/AdminLTE/plugins/daterangepicker/daterangepicker.js') }}"></script>
<!-- bootstrap time picker -->
<script src="{{ asset('/bower_components/AdminLTE/plugins/timepicker/bootstrap-timepicker.min.js') }}"></script>
<!-- iCheck 1.0.1 -->
<script src="{{ asset('/bower_components/AdminLTE/plugins/iCheck/icheck.min.js') }}"></script>
{{-- <script src="{{ elixir('js/app.js') }}"></script> --}}

<script type="text/javascript">
  $(document).on("click", "#datatable-delete", function () {
   var datalabel = $(this).data('label');
   $("#modal-delete .modal-body").text("Data '" + datalabel + "' akan dihapus, apakah anda yakin?");
   var dataid = $(this).data('id');
   $("#data-delete").attr('action', dataid);
 });
  $(function () {
  //Date picker
  $('.date').datepicker({
    autoclose: true
  });
  //Date range picker with time picker
  $('#reservationtime').daterangepicker({
    timePicker: true,
    timePickerIncrement: 5,
    format: 'YYYY-MM-DD HH:mm'
  });
  //Table
  $("#striped").DataTable();
  $('#hover').DataTable({
    "paging": true,
    "lengthChange": false,
    "searching": false,
    "ordering": true,
    "info": true,
    "autoWidth": false
  });
  //iCheck for checkbox and radio inputs
  $('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
    checkboxClass: 'icheckbox_minimal-blue',
    radioClass: 'iradio_minimal-blue'
  });
})
</script>

<script>
// Test if service workers are supported
if ('serviceWorker' in navigator) {
    // Attempt to register it
    navigator.serviceWorker.register('/sw.js').then(function() {
    // Success Message
    console.log('ServiceWorker succesfully registered');
    }).catch(function(err) {
    // Error Message
    console.log('ServiceWorker registration failed: ', err);
    });
}
</script>

<!-- Ace -->
<script src="{!! asset('js/ace/ace.js') !!}" type="text/javascript" charset="utf-8"></script>
<!-- ANTLR Worker -->
<script src="{!! asset('js/my-mode.js') !!}" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">

  // Memasukkan Ace Editor ke dalam halaman
  var editor;
  try {
    SetCheckingTime();
    editor = ace.edit("editor");
    editor.setTheme("ace/theme/twilight");
    // editor.getSession().setMode("ace/mode/my-mode");
    editor.getSession().setMode("ace/mode/c_cpp");
    putStatus();
    editor.getSession().on("change", function(){
      SetCheckingTime();
      var editorstatustext = document.getElementById("editorstatustext");
      editorstatustext.style.backgroundColor = "red";
      editorstatustext.innerHTML = "Checker Status : Checking...";
    });
  } catch($err) {
    console.log($err);
  }

  // Menentukan waktu mulai untuk timer
  function SetCheckingTime() {
    var timerstart = new Date().getTime();
    $("#timer").val(timerstart);
  }

  // Meletakkan status dari checker di atas editor
  function putStatus() {
    var status = document.createElement("div");
    var statustext = document.createElement("a");
    var text = document.createTextNode("Checker Status : Checking...");
    status.setAttribute("id", "editorstatus");
    statustext.setAttribute("id", "editorstatustext");
    statustext.style.backgroundColor = "red";
    statustext.style.color = "white";
    statustext.style.padding = "3px";
    statustext.appendChild(text);
    status.appendChild(statustext);

    var editorexist = document.getElementById("editor");
    var editorparent = editorexist.parentElement;
    editorparent.insertBefore(status, editorexist);
  }

  // Memasukkan value dari Ace Editor ke dalam field input
  function getInput() {
    var text = editor.getValue();
    $("#inputkode").val(text);
  }

  // Menghitung jumlah error dan menampilkan ke halaman
  function softSubmit() {
    var conventionerr = 0;
    var syntaxerr = 0;
    var anns = editor.getSession().getAnnotations();
    anns.forEach(function(ann) {
      if(ann.type == 'warning') {
        ++conventionerr;
      } else if(ann.type == 'error') {
        ++syntaxerr
      }
    });
    $("#syntaxout").val(syntaxerr);
    $("#conventionout").val(conventionerr);
  }

  // Compile
  $('#compile').click(function(){
    $('#modal-compile-info').modal('show');
    var text = editor.getValue();
    $("#inputcompile").val(text);
    $.ajax({
      type: "POST",
      headers: { 'X-CSRF-Token' : $('meta[name=_token]').attr('content') },
      url: "<?= url('compile'); ?>",
      data: $("#inputcompile").serialize(),
      success: function(data) {
        var arr = $.makeArray(data);
        var errorstatement = ": error: ";
        var annotations = [];
        var anns = editor.getSession().getAnnotations();
        anns.forEach(function(ann) {
          if(ann.type == 'warning') {
            annotations.push(ann);
          }
        });
        if(arr.length > 0) {
          arr.forEach(function(entry) {
            if(entry.indexOf(errorstatement) > -1) {
              var splitedarr = entry.split(errorstatement);
              var index = splitedarr[0];
              var splitedindex = index.split(":");
              var file = splitedindex[0];
              var row = splitedindex[1];
              var column = splitedindex[2];
              var message = splitedarr[1];
              annotations.push({
                row: row-1,
                column: column,
                text: message,
                type: "error"
              });
            }
          });
          editor.getSession().setAnnotations(annotations);
          $('#modal-compile-warning').modal('show');
          softSubmit();
        } else {
          $('#modal-compile-success').modal('show');
          softSubmit();
        }
        $('#modal-compile-info').modal('hide');
      }
    })
  });
</script>

<!-- Optionally, you can add Slimscroll and FastClick plugins.
Both of these plugins are recommended to enhance the
user experience. Slimscroll is required when using the
fixed layout. -->
</body>
</html>
