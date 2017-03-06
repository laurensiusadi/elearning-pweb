@extends('layouts.template')

@section('content')

<div class="error-page">
	<h2 class="headline text-yellow"> 404</h2>

	<div class="error-content">
	<h3><i class="fa fa-warning text-yellow"></i> Ups! Halaman tidak ditemukan.</h3>

		<p>
			Kamu tidak dapat menemukan halaman yang anda cari.
			Meskipun demikian, anda dapat <a href="{{ URL::previous() }}">kembali ke halaman sebelumnya.</a>
		</p>
	</div>
	<!-- /.error-content -->
</div>

@endsection