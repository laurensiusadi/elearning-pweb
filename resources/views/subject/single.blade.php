@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Detail Matakuliah</h3>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('subject') }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<div class="box-body">
					<dl>
						<dt>Kode</dt>
						<dd>{{ $subject->kode }}</dd>
						<dt>Nama</dt>
						<dd>{{ $subject->nama }}</dd>
						<dt>SKS</dt>
						<dd>{{ $subject->sks }}</dd>
						<dt>Kurikulum</dt>
						<dd>{{ $subject->kurikulum }}</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection