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
		<a class="btn btn-sm btn-success" href="{{ url('permission/create') }}">
			<i class="fa fa-plus"></i> Tambah
		</a>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th rowspan="2">Nama Permission</th>
					<th colspan="4">Slug</th>
					<th rowspan="2">Deskripsi</th>
					<th rowspan="2">Aksi</th>
				</tr>
				<tr>
					<th>Create</th>
					<th>View</th>
					<th>Update</th>
					<th>Delete</th>
				</tr>
			</thead>
			<tbody>
				@if(count($permissions) > 0)
				@foreach($permissions as $permission)
				<tr>
					<td>{{ $permission->name }}</td>
					<td>
						@if($permission->slug['create'] == true)
						<i class="fa fa-check"></i>
						@else
						<i class="fa fa-remove"></i>
						@endif
					</td>
					<td>
						@if($permission->slug['view'] == true)
						<i class="fa fa-check"></i>
						@else
						<i class="fa fa-remove"></i>
						@endif
					</td>
					<td>
						@if($permission->slug['update'] == true)
						<i class="fa fa-check"></i>
						@else
						<i class="fa fa-remove"></i>
						@endif
					</td>
					<td>
						@if($permission->slug['delete'] == true)
						<i class="fa fa-check"></i>
						@else
						<i class="fa fa-remove"></i>
						@endif
					</td>
					<td>{{ $permission->description }}</td>
					<td>
						<a class="btn btn btn-primary btn-xs" data-toggle="tooltip" title="Detail" href="{{ url('permission').'/'.$permission->id }}">
							<i class="fa fa-list"></i>
						</a>
						<a class="btn btn-warning btn-xs" data-toggle="tooltip" title="Edit" href="{{ url('permission').'/'.$permission->id }}/edit">
							<i class="fa fa-edit"></i>
						</a>
						<span data-toggle="tooltip" title="Hapus">
							<a id="datatable-delete" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#modal-delete" data-id="{{ url('permission').'/'.$permission->id }}" data-label="{{ $permission->name }}">
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