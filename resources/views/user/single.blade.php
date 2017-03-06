@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Detail Pengguna</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('user') }}">
                    	<i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <div class="box-body">
                	<dl>
                        <dt>NRP / NIDN</dt>
                        <dd>{{ $user->nomorinduk }}</dd>
                        <dt>Nama</dt>
                        <dd>{{ $user->name }}</dd>
                        <dt>Email</dt>
                        <dd>{{ $user->email }}</dd>
					</dl>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection