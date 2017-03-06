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
	Chart.types.Line.extend({
		name: "LineAlt",
		initialize: function (data) {
			this.chart.height -= 30;

			Chart.types.Line.prototype.initialize.apply(this, arguments);

			var ctx = this.chart.ctx;
			ctx.save();
		    // text alignment and color
		    ctx.textAlign = "center";
		    ctx.textBaseline = "bottom";
		    ctx.fillStyle = this.options.scaleFontColor;
		    // position
		    var x = this.chart.width / 2;
		    var y = this.chart.height + 15 + 5;
		    // change origin
		    ctx.translate(x, y)
		    ctx.fillText("Jumlah Cluster", 0, 0);
		    ctx.restore();
		},
		draw: function () {
	        Chart.types.Line.prototype.draw.apply(this, arguments);

	        var ctx = this.chart.ctx;
	        ctx.save();
	        // text alignment and color
	        ctx.textAlign = "center";
	        ctx.textBaseline = "bottom";
	        ctx.fillStyle = this.options.scaleFontColor;
	        // position
	        var x = this.scale.xScalePaddingLeft * 0.4;
	        var y = this.chart.height / 2;
	        // change origin
	        ctx.translate(x, y)
	        // rotate text
	        ctx.rotate(-90 * Math.PI / 180);
	        ctx.fillText(this.datasets[0].label, 0, 0);
	        ctx.restore();
	    }
	});

	var data = {
		labels: {{ $listclusterforchart }},
		xAxisLabel: "",
		datasets: [
		{
			label: "Standar Deviasi",
			fillColor: "rgba(220,220,220,0.2)",
    		strokeColor: "rgba(60,141,188,0.8)",
    		pointColor: "#3b8bba",
			pointStrokeColor: "#fff",
			pointHighlightFill: "#fff",
			pointHighlightStroke: "rgba(220,220,220,1)",
			data: {{ $standardeviasiforchart }}
		}
		]
	};

	var ctx = document.getElementById('lineChart').getContext('2d');
	new Chart(ctx).LineAlt(data, {
		scaleLabel: "          <%=value%>"
	});

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