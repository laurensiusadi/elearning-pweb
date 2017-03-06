@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-11">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Edit Permission Role {{ $rolename }}</h3>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('permissionrole').'/'.$roleid }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<form class="form" role="form" method="POST" action="{{ url('permissionrole').'/'.$roleid }}">
					<div class="box-body">
						{!! csrf_field() !!}
						<input type="hidden" name="_method" value="put"></input>

						<table id="striped" class="table table-bordered table-hover">
							<thead>
								<tr>
									<th rowspan="2">Nama Permission</th>
									<th colspan="4">Slug</th>
									<th rowspan="2">Deskripsi</th>
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
									@if($permission->slug['create'] == true)
									<td><input checked type="checkbox" class="minimal" name="create::{{$permission->id}}"></td>
									@else
									<td><input type="checkbox" class="minimal" name="create::{{$permission->id}}"></td>
									@endif
									@if($permission->slug['view'] == true)
									<td><input checked type="checkbox" class="minimal" name="view::{{$permission->id}}"></td>
									@else
									<td><input type="checkbox" class="minimal" name="view::{{$permission->id}}"></td>
									@endif
									@if($permission->slug['update'] == true)
									<td><input checked type="checkbox" class="minimal" name="update::{{$permission->id}}"></td>
									@else
									<td><input type="checkbox" class="minimal" name="update::{{$permission->id}}"></td>
									@endif
									@if($permission->slug['delete'] == true)
									<td><input checked type="checkbox" class="minimal" name="delete::{{$permission->id}}"></td>
									@else
									<td><input type="checkbox" class="minimal" name="delete::{{$permission->id}}"></td>
									@endif
									<td>
									{{ $permission->description }}
									<input type="hidden" name="permissions_id[]" value="{{ $permission->id }}">
									</td>
								</tr>
								</input>
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