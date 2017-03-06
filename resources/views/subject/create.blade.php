@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Tambah Matakuliah</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('subject') }}">
                        <i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <form class="form" role="form" method="POST" action="{{ url('subject') }}">
                    <div class="box-body">
                        {!! csrf_field() !!}

                        <div class="form-group{{ $errors->has('kode') ? ' has-error' : '' }}">
                            <label for="kode">Kode MK</label>
                            <input type="text" class="form-control" name="kode" placeholder="Kode MK" value="{{ old('kode') }}">

                            @if ($errors->has('kode'))
                            <span class="help-block">
                                <strong>{{ $errors->first('kode') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('nama') ? ' has-error' : '' }}">
                            <label for="nama">Nama MK</label>
                            <input type="text" class="form-control" name="nama" placeholder="Nama MK" value="{{ old('nama') }}">

                            @if ($errors->has('nama'))
                            <span class="help-block">
                                <strong>{{ $errors->first('nama') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('sks') ? ' has-error' : '' }}">
                            <label for="sks">SKS MK</label>
                            <input type="text" class="form-control" name="sks" placeholder="SKS MK" value="{{ old('sks') }}">

                            @if ($errors->has('sks'))
                            <span class="help-block">
                                <strong>{{ $errors->first('sks') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('kurikulum') ? ' has-error' : '' }}">
                            <label for="kurikulum">Kurikulum MK</label>
                            <input type="text" class="form-control" name="kurikulum" placeholder="Kurikulum MK" value="{{ old('kurikulum') }}">

                            @if ($errors->has('kurikulum'))
                            <span class="help-block">
                                <strong>{{ $errors->first('kurikulum') }}</strong>
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
