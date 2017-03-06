@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Detail Konvensi Kode</h3>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('convention') }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<div class="box-body">
					<dl>
						<dt>Aturan Untuk</dt>
						<dd>{{ $convention->for }}</dd>
						<dt>Regex</dt>
						<dd>{{ $convention->regex }}</dd>
						<dt>Deskripsi Regex</dt>
						<dd>{{ $convention->deskripsi }}</dd>
						<dt>Jumlah Minimal Karakter</dt>
						<dd>{{ $convention->min }}</dd>
						<dt>Pesan Error untuk Jumlah Minimal Karakter</dt>
						<dd>{{ $convention->pesanmin }}</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection