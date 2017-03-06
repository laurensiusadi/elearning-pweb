@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Edit Role User {{ $username }}</h3>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('roleuser').'/'.$userid }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<form class="form" role="form" method="POST" action="{{ url('roleuser').'/'.$userid }}">
					<div class="box-body">
						{!! csrf_field() !!}
						<input type="hidden" name="_method" value="put"></input>

						<table id="striped" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th>*</th>
									<th>Nama</th>
									<th>Slug</th>
									<th>Deskripsi</th>
								</tr>
							</thead>
							<tbody>
								@if(count($roles) > 0)
								@foreach($roles as $role)
								<tr>
									@if(!empty($role->user_id))
									<td><input checked type="checkbox" class="minimal" name="data::{{ $role->id }}"></td>
									@else
									<td><input type="checkbox" class="minimal" name="data::{{ $role->id }}"></td>
									@endif
									<td>{{ $role->name }}</td>
									<td>{{ $role->slug }}</td>
									<td>{{ $role->description }}
										<input type="hidden" name="roles_id[]" value="{{ $role->id }}"></input>
									</td>
								</tr>
								@endforeach
								@endif
							</tbody>
						</table>

					</div>
					<div class="box-footer">
						<button type="submit" class="btn btn-primary">
							<i class="fa fa-btn fa-save"></i> Simpan
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
@endsection