@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Edit Periode</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('period') }}">
                        <i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <form class="form" role="form" method="POST" action="{{ url('period').'/'.$period->id }}">
                    <div class="box-body">
                        {!! csrf_field() !!}
                        <input type="hidden" name="_method" value="put"></input>

                        <div class="form-group{{ $errors->has('nama') ? ' has-error' : '' }}">
                            <label for="nama">Nama</label>
                            <input type="text" class="form-control" name="nama" placeholder="Nama" value="{{ $period->nama }}">

                            @if ($errors->has('nama'))
                            <span class="help-block">
                                <strong>{{ $errors->first('nama') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('tahun') ? ' has-error' : '' }}">
                            <label for="tahun">Tahun</label>
                            <input type="text" class="form-control" name="tahun" placeholder="Tahun" value="{{ $period->tahun }}">

                            @if ($errors->has('tahun'))
                            <span class="help-block">
                                <strong>{{ $errors->first('tahun') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('semester') ? ' has-error' : '' }}">
                            <label for="semester">Semester</label>
                            <input type="text" class="form-control" name="semester" placeholder="Semester" value="{{ $period->semester }}">

                            @if ($errors->has('semester'))
                            <span class="help-block">
                                <strong>{{ $errors->first('semester') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('mulai') ? ' has-error' : '' }}">
                            <label for="mulai">Tanggal Mulai</label>
                            <div class="input-group date">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <input type="date" class="form-control pull-right" name="mulai" value="{{ $period->mulai }}"></input>
                            </div>

                            @if ($errors->has('mulai'))
                            <span class="help-block">
                                <strong>{{ $errors->first('mulai') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('selesai') ? ' has-error' : '' }}">
                            <label for="selesai">Tanggal Selesai</label>
                            <div class="input-group date">
                                <div class="input-group-addon">
                                    <i class="fa fa-calendar"></i>
                                </div>
                                <input type="date" class="form-control pull-right" name="selesai" value="{{ $period->selesai }}"></input>
                            </div>

                            @if ($errors->has('selesai'))
                            <span class="help-block">
                                <strong>{{ $errors->first('selesai') }}</strong>
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