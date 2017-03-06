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
		<a class="btn btn-sm btn-success" href="{{ url('user/create') }}">
			<i class="fa fa-plus"></i> Tambah
		</a>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>NRP / NIDN</th>
					<th>Nama</th>
					<th>Email</th>
					<th>Aksi</th>
				</tr>
			</thead>
			<tbody>
				@if(count($users) > 0)
				@foreach($users as $user)
				<tr>
					<td>{{ $user->nomorinduk }}</td>
					<td>{{ $user->name }}</td>
					<td>{{ $user->email }}</td>
					<td>
						<a class="btn btn btn-primary btn-xs" data-toggle="tooltip" title="Detail" href="{{ url('user').'/'.$user->id }}">
							<i class="fa fa-list"></i>
						</a>
						<a class="btn btn-warning btn-xs" data-toggle="tooltip" title="Edit" href="{{ url('user').'/'.$user->id }}/edit">
							<i class="fa fa-edit"></i>
						</a>
						<a class="btn btn-success btn-xs" data-toggle="tooltip" title="Role User" href="{{ url('roleuser').'/'.$user->id }}">
							<i class="fa fa-gear"></i>
						</a>
						<span data-toggle="tooltip" title="Hapus">
							<a id="datatable-delete" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#modal-delete" data-id="{{ url('user').'/'.$user->id }}" data-label="{{ $user->name }}">
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