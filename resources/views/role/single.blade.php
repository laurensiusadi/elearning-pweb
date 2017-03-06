@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Detail Role</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('role') }}">
                    	<i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <div class="box-body">
                	<dl>
		                <dt>Nama</dt>
		                <dd>{{ $role->name }}</dd>
		                <dt>Slug</dt>
		                <dd>{{ $role->slug }}</dd>
		                <dt>Deskripsi</dt>
		                <dd>{{ $role->description }}</dd>
					</dl>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection