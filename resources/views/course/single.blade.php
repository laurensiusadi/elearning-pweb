@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Detail Kursus</h3>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('course') }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<div class="box-body">
					<dl>
						<dt>Nama Kursus</dt>
						<dd>{{ $course[0]->nama }}</dd>
						<dt>Periode Kursus</dt>
						<dd>{{ $course[0]->namaperiode }}</dd>
						<dt>Nama Matakuliah</dt>
						<dd>{{ $course[0]->namamatakuliah }}</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection