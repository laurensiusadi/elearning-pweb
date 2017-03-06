@extends('layouts.template')

@section('content')
<style type="text/css" media="screen">
	#editor {
		margin: 0;
		position: relative;
		top: 0;
		bottom: 0;
		left: 0;
		right: 0;
		height: 300px;
	}
</style>
@if(!empty(Session::get('message')))
<div class="alert alert-success alert-dismissible">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<i class="icon fa fa-check"></i> {{ Session::get('message') }}
</div>
@elseif(!empty(Session::get('error')))
<div class="alert alert-warning alert-dismissible">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<i class="icon fa fa-warning"></i> {{ Session::get('error') }}
</div>
@endif
<div class="box box-primary">
	<div class="box-header">
		<h3 class="box-title">Penugasan {{ $quiz->nama }}</h3><br>
		<h5 class="box-title">Kursus {{ $course->nama }}</h5>
		<a class="btn btn-sm btn-success pull-right" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quizid.'/answer' }}">
			<i class="fa fa-arrow-left"></i> Kembali
		</a>
	</div>
	<div class="box-body">
		<dl>
			<dt>NRP / NIDN</dt>
			<dd>{{ $user->nomorinduk }}</dd>
			<dt>Nama</dt>
			<dd>{{ $user->name }}</dd>
			<dt>Email</dt>
			<dd>{{ $user->email }}</dd>
			<dt>Total Durasi</dt>
			<?php
			$time = $answer->totaldurasi;
			$min = floor($time / 60);
			if($min / 10 < 1) {
				$tempmin = $min;
				$min = '0'.$tempmin;
			}
			$det = $time % 60;
			if($det / 10 < 1) {
				$temp = $det;
				$det = '0'.$temp;
			}
			$time = $min.':'.$det;

			if($jumlahpercobaan > 6) $width = '100%';
			else if($jumlahpercobaan == 1) $width = '10%';
			else if($jumlahpercobaan == 2) $width = '30%';
			else $width = '50%';
			?>
			<dd>{{ $time }}</dd>
			<dt>Total Syntax Error</dt>
			<dd>{{ $answer->totalerrsyntax }}</dd>
			<dt>Total Convention Error</dt>
			<dd>{{ $answer->totalerrconvention }}</dd>
			<dt>Grafik Riwayat Error</dt>
			<dd>
				<div class="chart" style="width:{{ $width }}">
					<canvas id="lineChart" style="height:250px"></canvas>
				</div>
			</dd>
			<dt>Grafik Waktu Pengerjaan (detik)</dt>
			<dd>
				<div class="chart" style="width:{{ $width }}">
					<canvas id="barChart" style="height:250px"></canvas>
				</div>
			</dd>
			<dt>Jawaban</dt>
			<dd>
				<!-- <div id="editor">#include<iostream> int main() { cout << "Hai" << endl; }</div> -->
				<div id="editor">{{ $answer->final }}</div>
			</dd>
			<dt>
				<br><a id="compile" class="btn btn-warning">Compilability Test</a>
			</dt>
		</dl>
	</div>
</div>
</div>

<!-- ChartJS 1.0.1 -->
<script src="{{ asset('/bower_components/AdminLTE/plugins/chartjs/Chart.min.js') }}"></script>
<script type="text/javascript">
	//-------------
    //- LINE CHART -
    //--------------
    var lineChartCanvas = $("#lineChart").get(0).getContext("2d");
    var lineChart = new Chart(lineChartCanvas);

    var areaChartData = {
    	labels: {{ $detailpercobaan }},
    	datasets: [
    	{
    		label: "Convention Error",
    		fillColor: "rgba(210, 214, 222, 1)",
    		strokeColor: "rgba(210, 214, 222, 1)",
    		pointColor: "rgba(210, 214, 222, 1)",
    		pointStrokeColor: "#c1c7d1",
    		pointHighlightFill: "#fff",
    		pointHighlightStroke: "rgba(220,220,220,1)",
    		data: {{ $detailconventionerr }}
    	},
    	{
    		label: "Syntax Error",
    		fillColor: "rgba(60,141,188,0.9)",
    		strokeColor: "rgba(60,141,188,0.8)",
    		pointColor: "#3b8bba",
    		pointStrokeColor: "rgba(60,141,188,1)",
    		pointHighlightFill: "#fff",
    		pointHighlightStroke: "rgba(60,141,188,1)",
    		data: {{ $detailsyntaxerr }}
    	}
    	]
    };

    var areaChartOptions = {
		//Boolean - If we should show the scale at all
		showScale: true,
		//Boolean - Whether grid lines are shown across the chart
		scaleShowGridLines: false,
		//String - Colour of the grid lines
		scaleGridLineColor: "rgba(0,0,0,.05)",
		//Number - Width of the grid lines
		scaleGridLineWidth: 1,
		//Boolean - Whether to show horizontal lines (except X axis)
		scaleShowHorizontalLines: true,
		//Boolean - Whether to show vertical lines (except Y axis)
		scaleShowVerticalLines: true,
		//Boolean - Whether the line is curved between points
		bezierCurve: true,
		//Number - Tension of the bezier curve between points
		bezierCurveTension: 0.3,
		//Boolean - Whether to show a dot for each point
		pointDot: false,
		//Number - Radius of each point dot in pixels
		pointDotRadius: 4,
		//Number - Pixel width of point dot stroke
		pointDotStrokeWidth: 1,
		//Number - amount extra to add to the radius to cater for hit detection outside the drawn point
		pointHitDetectionRadius: 20,
		//Boolean - Whether to show a stroke for datasets
		datasetStroke: true,
		//Number - Pixel width of dataset stroke
		datasetStrokeWidth: 2,
		//Boolean - Whether to fill the dataset with a color
		datasetFill: true,
		//String - A legend template
		legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].lineColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>",
		//Boolean - whether to maintain the starting aspect ratio or not when responsive, if set to false, will take up entire container
		maintainAspectRatio: true,
		//Boolean - whether to make the chart responsive to window resizing
		responsive: true,
		multiTooltipTemplate: "<%=datasetLabel%> : <%= value %>"
	};

	var lineChartOptions = areaChartOptions;
	lineChartOptions.datasetFill = false;
	lineChart.Line(areaChartData, lineChartOptions);
	
	//-------------
    //- BAR CHART -
    //-------------
    var barChartData = {
    	labels: {{ $detailpercobaan }},
    	datasets: [
    	{
    		label: "Duration",
    		fillColor: "#00a65a",
    		strokeColor: "#00a65a",
    		pointColor: "#00a65a",
    		pointStrokeColor: "#00a65a",
    		pointHighlightFill: "#fff",
    		pointHighlightStroke: "#00a65a",
    		data: {{ $detaildurasi }}
    	}
    	]
    };
    var barChartCanvas = $("#barChart").get(0).getContext("2d");
    var barChart = new Chart(barChartCanvas);

    var barChartOptions = {
		//Boolean - Whether the scale should start at zero, or an order of magnitude down from the lowest value
		scaleBeginAtZero: true,
		//Boolean - Whether grid lines are shown across the chart
		scaleShowGridLines: true,
		//String - Colour of the grid lines
		scaleGridLineColor: "rgba(0,0,0,.05)",
		//Number - Width of the grid lines
		scaleGridLineWidth: 1,
		//Boolean - Whether to show horizontal lines (except X axis)
		scaleShowHorizontalLines: true,
		//Boolean - Whether to show vertical lines (except Y axis)
		scaleShowVerticalLines: true,
		//Boolean - If there is a stroke on each bar
		barShowStroke: true,
		//Number - Pixel width of the bar stroke
		barStrokeWidth: 2,
		//Number - Spacing between each of the X value sets
		barValueSpacing: 5,
		//Number - Spacing between data sets within X values
		barDatasetSpacing: 1,
		//String - A legend template
		legendTemplate: "<ul class=\"<%=name.toLowerCase()%>-legend\"><% for (var i=0; i<datasets.length; i++){%><li><span style=\"background-color:<%=datasets[i].fillColor%>\"></span><%if(datasets[i].label){%><%=datasets[i].label%><%}%></li><%}%></ul>",
		//Boolean - whether to make the chart responsive
		responsive: true,
		maintainAspectRatio: true
	};

	barChartOptions.datasetFill = false;
	barChart.Bar(barChartData, barChartOptions);

</script>

@endsection