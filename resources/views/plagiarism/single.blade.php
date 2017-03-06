@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Detail Jawaban</h3><br>
					<a>Kursus: {{ $course->nama }}</a><br>
					<a>Penugasan: {{ $quiz->nama }}</a><br>
					<a>NRP: {{ $nrp }}</a><br>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('plagiarism').'/'.$course->id.'/'.$quiz->id.'/'.$filter }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<div class="box-body">
					<div class="form-group">
					<div id="editor" style="height:300px">{{ $answer }}</div>
					</div>
				</div>
				<div class="box-footer">
					<a id="compile" class="btn btn-warning">Compilability Test</a>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection