@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Detail Permission</h3>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('permission') }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<div class="box-body">
					<dl>
						<dt>Nama</dt>
						<dd>{{ $permission->name }}</dd>
						<dt>Slug</dt>
						<dd>
							@if($permission->slug['create'] == true)
							<i class="fa fa-check"></i>
							@else
							<i class="fa fa-remove"></i>
							@endif
						Create</dd>
						<dd>
							@if($permission->slug['view'] == true)
							<i class="fa fa-check"></i>
							@else
							<i class="fa fa-remove"></i>
							@endif
						View</dd>
						<dd>
							@if($permission->slug['update'] == true)
							<i class="fa fa-check"></i>
							@else
							<i class="fa fa-remove"></i>
							@endif
						Update</dd>
						<dd>
							@if($permission->slug['delete'] == true)
							<i class="fa fa-check"></i>
							@else
							<i class="fa fa-remove"></i>
							@endif
						Delete</dd>
						<dt>Deskripsi</dt>
						<dd>{{ $permission->description }}</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection