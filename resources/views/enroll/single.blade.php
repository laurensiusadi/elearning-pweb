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
		<h3 class="box-title">Detail Enrollment dari Kursus {{ $course->nama }}</h3>
		<div class="pull-right">
			<a class="btn btn-sm btn-success" href="{{ url('course')}}">
				<i class="fa fa-arrow-left"></i> Kembali
			</a>
			<a class="btn btn-sm btn-warning" href="{{ url('enroll').'/'.$course->id }}/edit">
				<i class="fa fa-edit"></i> Edit
			</a>
		</div>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>*</th>
					<th>NRP / NIDN</th>
					<th>User</th>
					<th>Email</th>
					<th>Role</th>
				</tr>
			</thead>
			<tbody>
				@if(count($enrolls) > 0)
				@foreach($enrolls as $enroll)
				<tr>
					<td>
						@if(!empty($enroll->id))
						<i class="fa fa-check"></i>
						@else
						<i class="fa fa-remove"></i>
						@endif
					</td>
					<td>{{ $enroll->nomorinduk }}</td>
					<td>{{ $enroll->namauser }}</td>
					<td>{{ $enroll->email }}</td>
					<td>{{ $enroll->namarole }}</td>
				</tr>
				@endforeach
				@endif
			</tbody>
		</table>
	</div>
</div>
@endsection