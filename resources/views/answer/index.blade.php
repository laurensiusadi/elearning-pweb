@extends('layouts.template')

@section('content')

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
	<div class="box-header with-border">
		<h3 class="box-title">Penugasan {{ $quiz->nama }}</h3><br>
		<h5 class="box-title">Kursus {{ $course->nama }}</h5>
		<div class="box-header with-border btn-group">
			<div class="pull-right">
				<a class="btn btn-sm btn-success" href="{{ url('enroll').'/'.$enrollid.'/quiz' }}">
					<i class="fa fa-arrow-left"></i> Kembali
				</a>
				@if($ismhs == false)
				<a class="btn btn-sm btn-warning" href="{{ url('plagiarism').'/'.$courseid.'/'.$quizid.'/0' }}">
					<i class="fa fa-copy"></i> Plagiarism Check
				</a>
				{{-- <a class="btn btn-sm btn-warning" href="{{ url('similarity').'/'.$courseid.'/'.$quizid }}">
					<i class="fa fa-clipboard"></i> Student Feedback
				</a> --}}
				@endif
			</div>
		</div>
		<form id="">
			
		</form>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>NRP / NIDN</th>
					<th>Nama Peserta</th>
					<th>Status Pengerjaan</th>
				</tr>
			</thead>
			<tbody>
				@if(count($participants) > 0)
				@foreach($participants as $participant)
				<tr>
					<td>{{ $participant->nomorinduk }}</td>
					<td>{{ $participant->username }}</td>
					<td>
						@if($ismhs == true) <!-- Jangan lupa diubah ke true -->
						@if(!empty($participant->answerid))
						<a class="btn btn-primary btn-xs" data-toggle="tooltip" title="Lihat Jawaban" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quiz->id.'/answer/'.$participant->answerid}}">
							<i class="fa fa-list"></i>
						</a>
						<a class="btn btn-warning btn-xs" data-toggle="tooltip" title="Edit Jawaban" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quiz->id.'/answer/'.$participant->answerid.'/edit'}}">
							<i class="fa fa-edit"></i>
						</a>
						@else
						<a class="btn btn-success btn-xs" data-toggle="tooltip" title="Tambah Jawaban" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quiz->id.'/answer/create'}}">
							<i class="fa fa-plus"></i>
						</a>
						@endif
						@else
						@if(!empty($participant->answerid))
						<a class="btn btn-primary btn-xs" data-toggle="tooltip" title="Lihat Jawaban" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quiz->id.'/answer/'.$participant->answerid}}">
							<i class="fa fa-list"></i>
						</a>
						@else
						Peserta belum mengerjakan penugasan
						@endif
						@endif
					</td>
				</tr>
				@endforeach
				@endif
			</tbody>
		</table>
	</div>
</div>

@endsection