@extends('layouts.template')

@section('content')

{{ Session::get('message') }}

<?php $dateold = null; ?>

@foreach($posts as $post)
	  <!-- row -->
      <div class="row">
        <div class="col-md-12">
          <!-- The time line -->
          <ul class="timeline">
            <!-- timeline time label -->
            <?php 
            $datenew = date('d/m/Y', strtotime($post->created_at)); 
            if($datenew < $dateold || empty($dateold)) {
	            ?>
	            <li class="time-label">
	                  <span class="bg-red">
	                  {{ $dateold = date('d/m/Y', strtotime($post->created_at)) }}
	                  </span>
	            </li>
	            <?php
        	}
            ?>
            <!-- /.timeline-label -->
            <!-- timeline item -->
            <li>
              <i class="fa fa-user bg-aqua"></i>

              <div class="timeline-item">
                <span class="time"><i class="fa fa-clock-o"></i>{{ date('h:i', strtotime($post->created_at)) }}</span>

                <h3 class="timeline-header">{{ $post->judul }}</h3>

                <div class="timeline-body">
                  {{ $post->text }}
                </div>

                <div class="timeline-footer">
                  <a>{{ $post->name }}</a>
                </div>
              </div>
            </li>
            <!-- END timeline item -->

@endforeach
            <li>
              <i class="fa fa-clock-o bg-grey"></i>
            </li>
          </ul>
          <div class="pull-right">
            {!! $posts->render() !!}
          </div>
        </div>
        <!-- /.col -->
      </div>
      <!-- /.row -->


@endsection