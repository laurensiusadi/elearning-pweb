@extends('layouts.template')

@section('content')

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

<!-- Small boxes (Stat box) -->
<div class="row">
	@foreach($enrolls as $enroll)
	<div class="col-lg-3 col-xs-6">
		<!-- small box -->
		<div class="small-box bg-aqua">
			<div class="inner">
				<h3>Kursus</h3>
				<p>{{ $enroll->nama }}</p>
			</div>
			<div class="icon">
				<i class="fa fa-book"></i>
			</div>
			<a href="{{ url('enroll').'/'.$enroll->enrole_id.'/quiz' }}" class="small-box-footer">
				Masuk <i class="fa fa-arrow-circle-right"></i>
			</a>
		</div>
	</div>
	@endforeach
	<!-- ./col -->
</div>
<!-- /.row -->

@endsection