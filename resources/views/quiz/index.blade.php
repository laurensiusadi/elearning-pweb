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
	<div class="box-header with-border btn-group">
		<h3 class="box-title">Daftar Penugasan dari Kursus {{ $course->nama }}</h3>
		<div class="pull-right">
			<a class="btn btn-sm btn-success" href="{{ url('enroll') }}">
				<i class="fa fa-arrow-left"></i> Kembali
			</a>
			@if($ismhs == false)
			<a class="btn btn-sm btn-success" href="{{ url('enroll').'/'.$enrollid.'/quiz/create' }}">
				<i class="fa fa-plus"></i> Tambah
			</a>
			@endif
		</div>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>Nama Penugasan</th>
					<th>Waktu Mulai</th>
					<th>Waktu Selesai</th>
					<th>Deskripsi</th>
					<th>Aksi</th>
				</tr>
			</thead>
			<tbody>
				@if(count($quizes) > 0)
				@foreach($quizes as $quiz)
				<tr>
					<td>{{ $quiz->nama }}</td>
					<td>{{ $quiz->wmulai }}</td>
					<td>{{ $quiz->wselesai }}</td>
					<td>{{ $quiz->des }}</td>
					<td>
						<a class="btn btn btn-primary btn-xs" data-toggle="tooltip" title="Detail" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quiz->id }}">
							<i class="fa fa-list"></i>
						</a>
						<a class="btn btn-success btn-xs" data-toggle="tooltip" title="Jawaban" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quiz->id }}/answer">
							<i class="fa fa-copy"></i>
						</a>
						@if($ismhs == false)
						<a class="btn btn-warning btn-xs" data-toggle="tooltip" title="Edit" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quiz->id }}/edit">
							<i class="fa fa-edit"></i>
						</a>
						<span data-toggle="tooltip" title="Hapus">
							<a id="datatable-delete" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#modal-delete" data-id="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quiz->id }}" data-label="{{ $quiz->nama }}">
								<i class="fa fa-trash"></i>
							</a>
						</span>
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