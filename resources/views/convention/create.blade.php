@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Tambah Konvensi Kode</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('convention') }}">
                        <i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <form class="form" role="form" method="POST" action="{{ url('convention') }}">
                    <div class="box-body">
                        {!! csrf_field() !!}

                        <div class="form-group{{ $errors->has('for') ? ' has-error' : '' }}">
                            <label for="for">Aturan Untuk</label>
                            <select class="form-control" name="for">
                                @foreach($conventions['all'] as $convention)
                                <option value="{{ $convention }}"> {{ $convention }} </option>
                                @endforeach
                            </select>

                            @if ($errors->has('for'))
                            <span class="help-block">
                                <strong>{{ $errors->first('for') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('regex') ? ' has-error' : '' }}">
                            <label for="regex">Regex</label>
                            <input type="text" class="form-control" name="regex" placeholder="Regex" value="{{ old('regex') }}">

                            @if ($errors->has('regex'))
                            <span class="help-block">
                                <strong>{{ $errors->first('regex') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('deskripsi') ? ' has-error' : '' }}">
                            <label for="deskripsi">Deskripsi Regex</label>
                            <input type="text" class="form-control" name="deskripsi" placeholder="Deskripsi Regex" value="{{ old('deskripsi') }}">

                            @if ($errors->has('deskripsi'))
                            <span class="help-block">
                                <strong>{{ $errors->first('deskripsi') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('min') ? ' has-error' : '' }}">
                            <label for="min">Jumlah Minimal Karakter</label>
                            <input type="text" class="form-control" name="min" placeholder="Jumlah Minimal Karakter" value="{{ old('min') }}">

                            @if ($errors->has('min'))
                            <span class="help-block">
                                <strong>{{ $errors->first('min') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('pesanmin') ? ' has-error' : '' }}">
                            <label for="pesanmin">Pesan Error untuk Jumlah Minimal Karakter</label>
                            <input type="text" class="form-control" name="pesanmin" placeholder="Pesan Error" value="{{ old('pesanmin') }}">

                            @if ($errors->has('pesanmin'))
                            <span class="help-block">
                                <strong>{{ $errors->first('pesanmin') }}</strong>
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