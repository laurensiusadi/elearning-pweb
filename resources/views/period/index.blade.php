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
		<a class="btn btn-sm btn-success" href="{{ url('period/create') }}">
			<i class="fa fa-plus"></i> Tambah
		</a>
	</div>
	<div class="box-body">
		<table id="striped" class="table table-bordered table-striped">
			<thead>
				<tr>
					<th>Nama Periode</th>
					<th>Tahun</th>
					<th>Semester</th>
					<th>Tanggal Mulai</th>
					<th>Tanggal Selesai</th>
					<th>Aksi</th>
				</tr>
			</thead>
			<tbody>
				@if(count($periods) > 0)
				@foreach($periods as $period)
				<tr>
					<td>{{ $period->nama }}</td>
					<td>{{ $period->tahun }}</td>
					<td>{{ $period->semester }}</td>
					<td>{{ $period->mulai }}</td>
					<td>{{ $period->selesai }}</td>
					<td>
						<a class="btn btn btn-primary btn-xs" data-toggle="tooltip" title="Detail" href="{{ url('period').'/'.$period->id }}">
							<i class="fa fa-list"></i>
						</a>
						<a class="btn btn-warning btn-xs" data-toggle="tooltip" title="Edit" href="{{ url('period').'/'.$period->id }}/edit">
							<i class="fa fa-edit"></i>
						</a>
						<span data-toggle="tooltip" title="Hapus">
							<a id="datatable-delete" class="btn btn-danger btn-xs" data-toggle="modal" data-target="#modal-delete" data-id="{{ url('period').'/'.$period->id }}" data-label="{{ $period->nama }}">
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