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
		<a class="btn btn-sm btn-success" href="{{ url('role/create') }}">
			<i class="fa fa-plus"></i> Tambah
		</a>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>Nama Role</th>
					<th>Slug</th>
					<th>Deskripsi</th>
					<th>Aksi</th>
				</tr>
			</thead>
			<tbody>
				@if(count($roles) > 0)
				@foreach($roles as $role)
				<tr>
					<td>{{ $role->name }}</td>
					<td>{{ $role->slug }}</td>
					<td>{{ $role->description }}</td>
					<td>
						<a class="btn btn btn-primary btn-xs" data-toggle="tooltip" title="Detail" href="{{ url('role').'/'.$role->id }}">
							<i class="fa fa-list"></i>
						</a>
						<a class="btn btn-warning btn-xs" data-toggle="tooltip" title="Edit" href="{{ url('role').'/'.$role->id }}/edit">
							<i class="fa fa-edit"></i>
						</a>
						<a class="btn btn-success btn-xs" data-toggle="tooltip" title="Permission Role" href="{{ url('permissionrole').'/'.$role->id }}">
							<i class="fa fa-warning"></i>
						</a>
						<span data-toggle="tooltip" title="Hapus">
							<a id="datatable-delete" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#modal-delete" data-id="{{ url('role').'/'.$role->id }}" data-label="{{ $role->name }}">
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