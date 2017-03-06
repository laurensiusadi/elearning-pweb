@extends('layouts.template')

@section('content')
<div class="container">
	<div class="row">
		<div class="col-md-8">
			<div class="box box-primary">
				<div class="box-header with-border">
					<h3 class="box-title">Detail Periode</h3>
					<a class="btn btn-sm btn-success pull-right" href="{{ url('period') }}">
						<i class="fa fa-arrow-left"></i> Kembali
					</a>
				</div>
				<div class="box-body">
					<dl>
						<dt>Nama</dt>
						<dd>{{ $period->nama }}</dd>
						<dt>Tahun</dt>
						<dd>{{ $period->tahun }}</dd>
						<dt>Semester</dt>
						<dd>{{ $period->semester }}</dd>
						<dt>Tanggal Mulai</dt>
						<dd>{{ $period->mulai }}</dd>
						<dt>Tanggal Selesai</dt>
						<dd>{{ $period->selesai }}</dd>
					</dl>
				</div>
			</div>
		</div>
	</div>
</div>
@endsection