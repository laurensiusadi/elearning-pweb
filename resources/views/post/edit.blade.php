@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Edit Pengumuman</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('post') }}">
                        <i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <form class="form" role="form" method="POST" action="{{ url('post').'/'.$post->id }}">
                    <div class="box-body">
                        {!! csrf_field() !!}
                        <input type="hidden" name="_method" value="put"></input>

                        <div class="form-group{{ $errors->has('judul') ? ' has-error' : '' }}">
                            <label for="judul">Judul</label>
                            <input type="text" class="form-control" name="judul" placeholder="Judul" value="{{ $post->judul }}">

                            @if ($errors->has('judul'))
                                <span class="help-block">
                                    <strong>{{ $errors->first('judul') }}</strong>
                                </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('text') ? ' has-error' : '' }}">
                            <label for="text">Pengumuman</label>
                            <textarea type="text" class="form-control" name="text" placeholder="Pengumuman">{{ $post->text }}</textarea>

                            @if ($errors->has('text'))
                                <span class="help-block">
                                    <strong>{{ $errors->first('text') }}</strong>
                                </span>
                            @endif
                        </div>
                    </div>
                    <div class="box-footer">
                        <button type="submit" class="btn btn-primary">
                            <i class="fa fa-btn fa-save"></i> Simpan
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
@endsection