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
		<h3 class="box-title">Detail Role User {{ $username }}</h3>
		<div class="pull-right">
			<a class="btn btn-sm btn-success" href="{{ url('user')}}">
				<i class="fa fa-arrow-left"></i> Kembali
			</a>
			<a class="btn btn-sm btn-warning" href="{{ url('roleuser').'/'.$userid }}/edit">
				<i class="fa fa-edit"></i> Edit
			</a>
		</div>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>*</th>
					<th>Nama Role</th>
					<th>Slug</th>
					<th>Deskripsi</th>
				</tr>
			</thead>
			<tbody>
				@if(count($roles) > 0)
				@foreach($roles as $role)
				<tr>
					@if(!empty($role->user_id))
					<td><i class="fa fa-check"></i></td>
					@else
					<td><i class="fa fa-remove"></i></td>
					@endif
					<td>{{ $role->name }}</td>
					<td>{{ $role->slug }}</td>
					<td>{{ $role->description }}</td>
				</tr>
				@endforeach
				@endif
			</tbody>
		</table>
	</div>
</div>
@endsection