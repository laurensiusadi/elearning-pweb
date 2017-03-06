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
		<a class="btn btn-sm btn-success" href="{{ url('subject/create') }}">
			<i class="fa fa-plus"></i> Tambah
		</a>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>Kode</th>
					<th>Nama</th>
					<th>SKS</th>
					<th>Kurikulum</th>
					<th>Aksi</th>
				</tr>
			</thead>
			<tbody>
				@if(count($subjects) > 0)
				@foreach($subjects as $subject)
				<tr>
					<td>{{ $subject->kode }}</td>
					<td>{{ $subject->nama }}</td>
					<td>{{ $subject->sks }}</td>
					<td>{{ $subject->kurikulum }}</td>
					<td>
						<a class="btn btn btn-primary btn-xs" data-toggle="tooltip" title="Detail" href="{{ url('subject').'/'.$subject->id }}">
							<i class="fa fa-list"></i>
						</a>
						<a class="btn btn-warning btn-xs" data-toggle="tooltip" title="Edit" href="{{ url('subject').'/'.$subject->id }}/edit">
							<i class="fa fa-edit"></i>
						</a>
						<span data-toggle="tooltip" title="Hapus">
							<a id="datatable-delete" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#modal-delete" data-id="{{ url('subject').'/'.$subject->id }}" data-label="{{ $subject->nama }}">
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