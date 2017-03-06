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
		<a class="btn btn-sm btn-success" href="{{ url('course/create') }}">
			<i class="fa fa-plus"></i> Tambah
		</a>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>Nama Kursus</th>
					<th>Periode</th>
					<th>Matakuliah</th>
					<th>Aksi</th>
				</tr>
			</thead>
			<tbody>
				@if(count($courses) > 0)
				@foreach($courses as $course)
				<tr>
					<td>{{ $course->nama }}</td>
					<td>{{ $course->namaperiode }}</td>
					<td>{{ $course->namamatakuliah }}</td>
					<td>
						<a class="btn btn btn-primary btn-xs" data-toggle="tooltip" title="Detail" href="{{ url('course').'/'.$course->id }}">
							<i class="fa fa-list"></i>
						</a>
						<a class="btn btn-warning btn-xs" data-toggle="tooltip" title="Edit" href="{{ url('course').'/'.$course->id }}/edit">
							<i class="fa fa-edit"></i>
						</a>
						<a class="btn btn-success btn-xs" data-toggle="tooltip" title="Enrollment" href="{{ url('enroll').'/'.$course->id }}">
							<i class="fa fa-group"></i>
						</a>
						<span data-toggle="tooltip" title="Hapus">
							<a id="datatable-delete" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#modal-delete" data-id="{{ url('course').'/'.$course->id }}" data-label="{{ $course->nama }}">
								<i class="fa fa-trash"></i>
							</a>
						</span>
					</td>
				</tr>
				@endforeach
				@endif
			</tbody>
		</table>
	</div>
</div>
@endsection