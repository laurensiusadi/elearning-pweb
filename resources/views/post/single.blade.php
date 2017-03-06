@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Detail Pengumuman</h3>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('post') }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<div class="box-body">
					<dl>
						<dt>Judul</dt>
						<dd>{{ $post[0]->judul }}</dd>
						<dt>Pengumuman</dt>
						<dd>{{ $post[0]->text }}</dd>
						<dt>Tanggal Update</dt>
						<dd>{{ $post[0]->updated_at }}</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection