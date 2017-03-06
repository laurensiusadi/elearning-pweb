@extends('layouts.template')

@section('content')

<div class="box box-primary">
	<div class="box-header with-border btn-group">
		<h3 class="box-title">Detail Student Feedback</h3><br>
		<h3 class="box-title">Kursus {{ $course->nama }}</h3><br>
		<h3 class="box-title">Penugasan {{ $quiz->nama }}</h3>
		<div class="pull-right">
			<a class="btn btn-sm btn-success" href="{{ url('enroll').'/'.$quiz->enroll_id.'/quiz/'.$quizid.'/answer' }}">
				<i class="fa fa-arrow-left"></i> Kembali
			</a>
			<a class="btn btn-sm btn-warning" onclick="SimilarityCheck(<?= $courseid ?>, <?= $quizid ?>)">
				<i class="fa fa-clipboard"></i> Start Checking
			</a>
		</div>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>NRP</th>
					<th>Smith Alg.</th>
					<th>Modification Alg.</th>
				</tr>
			</thead>
			<tbody>
				@foreach($similaritys as $similarity)
				<tr>
					<td>{{ $similarity->nrp }}</td>
					<td>{{ $similarity->similarity_value_smith }}</td>
					<td>{{ $similarity->similarity_value_modif }}</td>
				</tr>
				@endforeach
			</tbody>
		</table>
	</div>
</div>

<script type="text/javascript">
	function SimilarityCheck(courseid, quizid) {
		$('#modal-compile-info').modal('show');
		$.ajax({
			type: "POST",
			headers: { 'X-CSRF-Token' : $('meta[name=_token]').attr('content') },
			url: "<?= url('similarity'); ?>",
			data: { courseid: courseid, quizid: quizid },
			timeout: 0,
			async: false,
			success: function(data) {
				$('#modal-compile-info').modal('hide');
			}
		});
		window.location.href = "<?= url('similarity') ?>" + "/" + courseid + "/" + quizid;
	}
</script>

@endsection