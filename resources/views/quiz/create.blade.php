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
<div class="box box-primary">
	<form action="{{ url('enroll').'/'.$enrollid.'/quiz' }}" method="POST">
     {!! csrf_field() !!}

     <div class="box-header">
        <h3 class="box-title">Tambah Penugasan</h3>
        <a class="btn btn-sm btn-success pull-right" href="{{ url('enroll').'/'.$enrollid.'/quiz' }}">
            <i class="fa fa-arrow-left"></i> Kembali
        </a>
    </div>
    <div class="box-body">

        <div class="form-group{{ $errors->has('nama') ? ' has-error' : '' }}">
            <label for="nama">Nama</label>
            <input type="text" class="form-control" name="nama" placeholder="Nama" value="{{ old('nama') }}">

            @if ($errors->has('nama'))
            <span class="help-block">
                <strong>{{ $errors->first('nama') }}</strong>
            </span>
            @endif
        </div>

        <div class="form-group{{ $errors->has('waktupengerjaan') ? ' has-error' : '' }}">
            <label for="waktupengerjaan">Waktu Pengerjaan</label>
            <div class="input-group">
                <div class="input-group-addon">
                    <i class="fa fa-clock-o"></i>
                </div>
                <input type="text" class="form-control pull-right" name="waktupengerjaan" id="reservationtime" value="{{ old('waktupengerjaan') }}">
            </div>

            @if ($errors->has('waktupengerjaan'))
            <span class="help-block">
                <strong>{{ $errors->first('waktupengerjaan') }}</strong>
            </span>
            @endif
        </div>

        <div class="form-group{{ $errors->has('des') ? ' has-error' : '' }}">
            <label for="des">Deskripsi</label>
            <textarea type="text" class="form-control" name="des" placeholder="Deskripsi">{{ old('des') }}</textarea>

            @if ($errors->has('des'))
            <span class="help-block">
                <strong>{{ $errors->first('des') }}</strong>
            </span>
            @endif
        </div>

        <div class="form-group{{ $errors->has('jwb') ? ' has-error' : '' }}">
            <label for="jwb">Jawaban</label>
            <input type="hidden" class="form-control" name="jwb" id="inputkode"></input>
            <!-- <div id="editor">#include<iostream> int main() { cout << "Hai" << endl; }</div> -->
            <div id="editor">{{ old('jwb') }}</div>

            @if ($errors->has('jwb'))
            <span class="help-block">
                <strong>{{ $errors->first('jwb') }}</strong>
            </span>
            @endif
        </div>
        
    </div>
</div>
<div class="box-footer">
    <button onclick="getInput()" type="submit" class="btn btn-primary">Simpan</button>
    <a id="compile" class="btn btn-warning">Compilability Test</a>
</div>
</form>
</div>

@endsection