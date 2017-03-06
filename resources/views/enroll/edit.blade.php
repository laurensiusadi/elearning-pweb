@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Edit Enrollment dari Kursus {{ $course->nama }}</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('enroll').'/'.$course->id }}">
                        <i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <form class="form" role="form" method="POST" action="{{ url('enroll').'/'.$course->id }}">
                    <div class="box-body">
                        {!! csrf_field() !!}
                        <input type="hidden" name="_method" value="put"></input>

                        <table id="striped" class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>*</th>
                                    <th>NRP / NIDN</th>
                                    <th>User</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                </tr>
                            </thead>
                            <tbody>
                                @if(count($enrolls) > 0)
                                @foreach($enrolls as $enroll)
                                <tr>
                                    @if(!empty($enroll->id))
                                    <td><input checked type="checkbox" class="minimal" name="data::{{ $enroll->userid }}"></td>
                                    @else
                                    <td><input type="checkbox" class="minimal" name="data::{{ $enroll->userid }}"></td>
                                    @endif
                                    <td>{{ $enroll->nomorinduk }}</td>
                                    <td>{{ $enroll->namauser }}</td>
                                    <td>{{ $enroll->email }}</td>
                                    <td>{{ $enroll->namarole }}
                                        <input type="hidden" name="user_id[]" value="{{ $enroll->userid }}"></input>
                                    </td>
                                </tr>
                                @endforeach
                                @endif
                            </tbody>
                        </table>

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