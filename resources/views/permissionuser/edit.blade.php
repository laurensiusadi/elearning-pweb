@extends('layouts.template')

@section('content')

{{ Session::get('message') }}

<div class="box">
    <form action="{{ url('permissionrole').'/'.$roleid }}" method="POST">
		<div class="box-body">
			<table id="example2" class="table table-bordered table-hover">
			<thead>
				<tr>
				<th rowspan="2">*</th>
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
						@if(!empty($permission->role_id))
		                    <td><input checked type="checkbox" class="minimal" name="data::{{ $permission->id }}"></td>
		                @else
		                    <td><input type="checkbox" class="minimal" name="data::{{ $permission->id }}"></td>
		                @endif
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
						</tr>
        			<input type="hidden" name="permissions_id[]" value="{{ $permission->id }}"></input>
					@endforeach
				@endif
			</tbody>
			</table>
		</div>
		<div class="box-footer">
            <button type="submit" class="btn btn-primary">Simpan</button>
        </div>
        <input type="hidden" name="_method" value="put"></input>
        {!! csrf_field() !!}
	</form>
</div>
@endsection