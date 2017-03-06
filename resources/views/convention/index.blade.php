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
		<a class="btn btn-sm btn-success" href="{{ url('convention/create') }}">
			<i class="fa fa-plus"></i> Tambah
		</a>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th rowspan="2">Aturan Untuk</th>
					<th colspan="2">Aturan</th>
					<th colspan="2">Jumlah Karakter</th>
					<th rowspan="2">Aksi</th>
				</tr>
				<tr>
					<th>Regex</th>
					<th>Deskripsi</th>
					<th>Minimal</th>
					<th>Pesan Error</th>
				</tr>
			</thead>
			<tbody>
				@if(count($dbconventions) > 0)
				@foreach($dbconventions as $dbconvention)
				<tr>
					<td>{{ $dbconvention->for }}</td>
					<td>{{ $dbconvention->regex }}</td>
					<td>{{ $dbconvention->deskripsi }}</td>
					<td>{{ $dbconvention->min }}</td>
					<td>{{ $dbconvention->pesanmin }}</td>
					<td>
						<a class="btn btn btn-primary btn-xs" data-toggle="tooltip" title="Detail" href="{{ url('convention').'/'.$dbconvention->id }}">
							<i class="fa fa-list"></i>
						</a>
						<a class="btn btn-warning btn-xs" data-toggle="tooltip" title="Edit" href="{{ url('convention').'/'.$dbconvention->id }}/edit">
							<i class="fa fa-edit"></i>
						</a>
						<span data-toggle="tooltip" title="Hapus">
							<a id="datatable-delete" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#modal-delete" data-id="{{ url('convention').'/'.$dbconvention->id }}" data-label="{{ $dbconvention->for }}">
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