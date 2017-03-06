@extends('layouts.template')

@section('content')
<style type="text/css" media="screen">
	#editor {
		margin: 0;
		position: relative;
		top: 0;
		bottom: 0;
		left: 0;
		right: 0;
		height: 300px;
	}
</style>
@if(!empty(Session::get('message')))
<div class="alert alert-success alert-dismissible">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<i class="icon fa fa-check"></i> {{ Session::get('message') }}
</div>
@elseif(!empty(Session::get('error')))
<div class="alert alert-warning alert-dismissible">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<i class="icon fa fa-warning"></i> {{ Session::get('error') }}
</div>
@endif
<div class="box box-primary">
	<div class="box-header">
		<h3 class="box-title">Detail Penugasan</h3>
		<a class="btn btn-sm btn-success pull-right" href="{{ url('enroll').'/'.$enrollid.'/quiz' }}">
			<i class="fa fa-arrow-left"></i> Kembali
		</a>
	</div>
	<div class="box-body">
		<dl>
			<dt>Nama</dt>
			<dd>{{ $quiz->nama }}</dd>
			<dt>Waktu Pengerjaan</dt>
			<dd>{{ $quiz->wmulai.' - '.$quiz->wselesai }}</dd>
			<dt>Deskripsi</dt>
			<dd>{{ $quiz->des }}</dd>
			@if($ismhs == false)
			<dt>Jawaban</dt>
			<dd>
				<!-- <div id="editor">#include<iostream> int main() { cout << "Hai" << endl; }</div> -->
				<div id="editor">{{ $quiz->jwb }}</div>
			</dd>
			<dt>
				<br><a id="compile" class="btn btn-warning">Compilability Test</a>
			</dt>
			@endif
		</dl>
	</div>
</div>
</div>

@endsection