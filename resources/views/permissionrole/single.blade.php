@extends('layouts.template')

@section('content')

@if(!empty(Session::get('message')))
<div class="alert alert-success alert-dismissible">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<i class="icon fa fa-check"></i> {{ Session::get('message') }}
</div>
@endif
<div class="box box-primary">
	<div class="box-header with-border btn-group">
		<h3 class="box-title">Detail Permission Role {{ $rolename }}</h3>
		<div class="pull-right">
			<a class="btn btn-sm btn-success" href="{{ url('role')}}">
				<i class="fa fa-arrow-left"></i> Kembali
			</a>
			<a class="btn btn-sm btn-warning" href="{{ url('permissionrole').'/'.$roleid }}/edit">
				<i class="fa fa-edit"></i> Edit
			</a>
		</div>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th rowspan="2">Nama Permission</th>
					<th colspan="4">Slug</th>
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
				@foreach($permissions as $key => $permission)
				<tr>
					<td>{{ $key }}</td>
					<td>
						@if($permission['create'] == true)
						<i class="fa fa-check"></i>
						@else
						<i class="fa fa-remove"></i>
						@endif
					</td>
					<td>
						@if($permission['view'] == true)
						<i class="fa fa-check"></i>
						@else
						<i class="fa fa-remove"></i>
						@endif
					</td>
					<td>
						@if($permission['update'] == true)
						<i class="fa fa-check"></i>
						@else
						<i class="fa fa-remove"></i>
						@endif
					</td>
					<td>
						@if($permission['delete'] == true)
						<i class="fa fa-check"></i>
						@else
						<i class="fa fa-remove"></i>
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