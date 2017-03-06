@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Tambah Role</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('role') }}">
                        <i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <form class="form" role="form" method="POST" action="{{ url('role') }}">
                    <div class="box-body">
                        {!! csrf_field() !!}

                        <div class="form-group{{ $errors->has('name') ? ' has-error' : '' }}">
                            <label for="name">Nama</label>
                            <input type="text" class="form-control" name="name" placeholder="Nama Role" value="{{ old('name') }}">

                            @if ($errors->has('name'))
                            <span class="help-block">
                                <strong>{{ $errors->first('name') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('slug') ? ' has-error' : '' }}">
                            <label for="slug">Slug</label>
                            <input type="text" class="form-control" name="slug" placeholder="Slug" value="{{ old('slug') }}">

                            @if ($errors->has('slug'))
                            <span class="help-block">
                                <strong>{{ $errors->first('slug') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('description') ? ' has-error' : '' }}">
                            <label for="description">Deskripsi</label>
                            <textarea type="text" class="form-control" name="description" placeholder="Deskripsi">{{ old('description') }}</textarea>

                            @if ($errors->has('description'))
                            <span class="help-block">
                                <strong>{{ $errors->first('description') }}</strong>
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

