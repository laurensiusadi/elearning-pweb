@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Tambah Permission</h3>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('permission') }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<form class="form" role="form" method="POST" action="{{ url('permission') }}">
					<div class="box-body">
						{!! csrf_field() !!}

						<div class="form-group{{ $errors->has('name') ? ' has-error' : '' }}">
							<label for="name">Nama Permission</label>
							<input type="text" class="form-control" name="name" placeholder="Nama Permission" value="{{ old('name') }}">

							@if ($errors->has('name'))
							<span class="help-block">
								<strong>{{ $errors->first('name') }}</strong>
							</span>
							@endif
						</div>

						<div class="form-group">
							<label for="slug">Slug</label>
							<table width="50%">
								<tr>
									<td><input checked type="checkbox" class="minimal" name="create">Create</td>
									<td><input checked type="checkbox" class="minimal" name="view">View</td>
									<td><input checked type="checkbox" class="minimal" name="update">Update</td>
									<td><input checked type="checkbox" class="minimal" name="delete">Delete</td>
								</tr>
							</table>
						</div>

						<div class="form-group{{ $errors->has('description') ? ' has-error' : '' }}">
							<label for="description">Deskripsi</label>
							<textarea type="text" class="form-control" name="description" placeholder="Deskripsi">{{ old('description') }}</textarea>

							@if ($errors->has('description'))
							<span class="help-block">
								<strong>{{ $errors->first('description') }}</strong>
							</span>
							@endif
						</div>
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