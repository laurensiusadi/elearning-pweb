@extends('layouts.template')

@section('content')

<div class="box box-primary">
	<div class="box-header with-border btn-group">
		<h3 class="box-title">Detail Clustering</h3><br>
		<h3 class="box-title">Kursus {{ $course->nama }}</h3><br>
		<h3 class="box-title">Penugasan {{ $quiz->nama }}</h3>
		<div class="pull-right">
			<a class="btn btn-sm btn-success" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quizid.'/answer' }}">
				<i class="fa fa-arrow-left"></i> Kembali
			</a>
			<a class="btn btn-sm btn-warning" onclick="PlagiarismCheck(<?= $courseid ?>, <?= $quizid ?>)">
				<i class="fa fa-copy"></i> Start Checking
			</a>
		</div>
	</div>
	<div class="box-body">
		<div>Jumlah Cluster
			<select class="form-control" style="width:10%" onchange="FilterCluster(<?= $courseid ?>, <?= $quizid ?>, this)">
				@foreach($listcluster as $cluster)
				@if($cluster == $selected)
				<option selected value="{{ $cluster }}">{{ $cluster }}</option>
				@else
				<option value="{{ $cluster }}">{{ $cluster }}</option>
				@endif
				@endforeach
			</select>
		</div>
		<div>
			<br>Pilih Cluster:<br>
			@for($i=1; $i < count($fixedcluster); $i++)
			<button id="button_{{ $i }}" class="btn clickbutton" value="<?= $i ?>">{{ $i }}</button>
			@endfor
		</div>
		<div>
			<br>
			Range Persentase:
			@foreach($proc as $index => $prosentase)
			<a class="proc" id="proc_{{ $index + 1 }}">{{ $prosentase }}%</a>
			@endforeach
		</div>
		<table id="buttonselect" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>No.</th>
					<th>Cluster</th>
					<th>Member</th>
					<th>Aksi</th>
				</tr>
			</thead>
			<tbody>
				@foreach($fixedcluster as $key => $datacluster)
				@if(is_array($datacluster))
				@foreach($datacluster as $data)
				<tr>
					<td></td>
					<td>{{ $key + 1 }}</td>
					<td>{{ $data }}</td>
					<td>
						<a class="btn btn btn-primary btn-xs" data-toggle="tooltip" title="Lihat" href="{{ url('plagiarism').'/'.$courseid.'/'.$quizid.'/'.$selected.'/'.$data }}">
							<i class="fa fa-list"></i>
						</a>
					</td>
				</tr>
				@endforeach
				@endif
				@endforeach
			</tbody>
		</table>
		<br><h4 class="box-title">Grafik Standar Deviasi</h4><br>
		<div class="chart">
			<canvas id="lineChart" style="height:250px;"></canvas>
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
    	labels: {{ $listclusterforchart }},
    	datasets: [
    	{
    		label: "Syntax Error",
    		fillColor: "rgba(60,141,188,0.9)",
    		strokeColor: "rgba(60,141,188,0.8)",
    		pointColor: "#3b8bba",
    		pointStrokeColor: "rgba(60,141,188,1)",
    		pointHighlightFill: "#fff",
    		pointHighlightStroke: "rgba(60,141,188,1)",
    		data: {{ $standardeviasiforchart }}
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

	function PlagiarismCheck(courseid, quizid) {
		$('#modal-compile-info').modal('show');
		$.ajax({
			type: "POST",
			headers: { 'X-CSRF-Token' : $('meta[name=_token]').attr('content') },
			url: "<?= url('plagiarism'); ?>",
			data: { courseid: courseid, quizid: quizid },
			timeout: 0,
			async: false,
			success: function(data) {
				$('#modal-compile-info').modal('hide');
			}
		});
		window.location.href = "<?= url('plagiarism') ?>" + "/" + courseid + "/" + quizid + "/" + '0';
	}
	
	function FilterCluster(courseid, quizid, elm) {
		window.location.href = "<?= url('plagiarism') ?>" + "/" + courseid + "/" + quizid + "/" + elm.value;
	}

	var tableobj = $("#buttonselect").DataTable({
		"paging": false,
		"lengthChange": false,
		"searching": true,
		"ordering": true,
		"info": true,
		"autoWidth": false
	});

	$(".proc").hide();
	regExSearch = '^' + 1 +'$';
	tableobj.column(1).search(regExSearch, true, false).draw();
	$("#proc_1").show();
	$("#button_1").prop('disabled', true);

	$(".clickbutton").click(function() {
		regExSearch = '^' + this.value +'$';
		tableobj.column(1).search(regExSearch, true, false).draw();
		$(".proc").hide();
		$("#proc_" + this.value).show();
		$(".clickbutton").prop('disabled', false);
		$(this).prop('disabled', true);
	});

	tableobj.on( 'order.dt search.dt', function () {
		tableobj.column(0, {search:'applied', order:'applied'}).nodes().each( function (cell, i) {
			cell.innerHTML = i+1;
		} );
	} ).draw();

</script>

@endsection