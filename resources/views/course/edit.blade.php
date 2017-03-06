@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Edit Kursus</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('course') }}">
                        <i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <form class="form" role="form" method="POST" action="{{ url('course').'/'.$course->id }}">
                    <div class="box-body">
                        {!! csrf_field() !!}
                        <input type="hidden" name="_method" value="put"></input>

                        <div class="form-group{{ $errors->has('nama') ? ' has-error' : '' }}">
                            <label for="nama">Nama Kursus</label>
                            <input type="text" class="form-control" name="nama" placeholder="Nama Kursus" value="{{ $course->nama }}">

                            @if ($errors->has('nama'))
                            <span class="help-block">
                                <strong>{{ $errors->first('nama') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('periode_id') ? ' has-error' : '' }}">
                            <label for="periode_id">Periode</label>
                            <select class="form-control" name="periode_id">
                                @foreach($periods as $period)
                                @if($period->id == $course->periode_id)
                                <option selected value="{{ $period->id }}"> {{ $period->nama }} </option>
                                @else
                                <option value="{{ $period->id }}"> {{ $period->nama }} </option>
                                @endif
                                @endforeach
                            </select>

                            @if ($errors->has('periode_id'))
                            <span class="help-block">
                                <strong>{{ $errors->first('periode_id') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group{{ $errors->has('mk_id') ? ' has-error' : '' }}">
                            <label for="mk_id">Matakuliah</label>
                            <select class="form-control" name="mk_id">
                                @foreach($subjects as $subject)
                                @if($subject->id == $course->mk_id)
                                <option selected value="{{ $subject->id }}"> {{ $subject->nama }} </option>
                                @else
                                <option value="{{ $subject->id }}"> {{ $subject->nama }} </option>
                                @endif
                                @endforeach
                            </select>

                            @if ($errors->has('mk_id'))
                            <span class="help-block">
                                <strong>{{ $errors->first('mk_id') }}</strong>
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