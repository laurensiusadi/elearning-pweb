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
<div class="container">
    <div class="row">
        <form action="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quizid.'/answer/'.$answerid }}" method="POST">
            <div class="col-md-11">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <label>{{ $quiz->nama }}</label>
                        <a class="btn btn-sm btn-success pull-right" href="{{ url('enroll').'/'.$enrollid.'/quiz/'.$quizid.'/answer' }}">
                            <i class="fa fa-arrow-left"></i> Kembali
                        </a>
                    </div>
                    <div class="panel-body">
                        <dl>
                            <dt>Deskripsi</dt>
                            <dd> {{$quiz->des}} </dd>
                            <dt>Waktu Pengerjaan</dt>
                            <dd> {{$quiz->wmulai}} sampai {{$quiz->wselesai}} </dd>
                        </dl>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <input type="hidden" class="form-control" name="kode" id="inputkode"></input>
                <!-- <div id="editor">#include<iostream> int main() { cout << "Hai" << endl; }</div> -->
                <div id="editor">{{ $answer->final }}</div>
            </div>
            <div class="col-md-5">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="col-sm-6">
                            <label>Waktu mengerjakan</label>
                        </div>
                        <input type="hidden" class="form-control" name="durasi" id="inputdurasi"></input>
                        <div class="col-sm-6">
                            <i class="fa fa-clock-o"></i>
                            <output id="durasi">0</output>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="col-sm-6">
                            <label>Syntax error</label>
                        </div>
                        <input type="hidden" class="form-control" name="errsyntax" id="inputerrsyntax"></input>
                        <div class="col-sm-6">
                            <i class="fa fa-times"></i>
                            <output id="syntaxout">0</output>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-body">
                        <div class="col-sm-6">
                            <label>Convention error</label>
                        </div>
                        <input type="hidden" class="form-control" name="errconvention" id="inputerrconvention"></input>
                        <div class="col-sm-6">
                            <i class="fa fa-warning"></i>
                            <output id="conventionout">0</output>
                        </div>
                    </div>
                </div>
                <button onclick="GetCode()" type="submit" class="btn btn-primary">
                    <i class="fa fa-btn"></i>Submit
                </button>
                <a id="compile" class="btn btn-warning">Compilability Test</a>
            </div>
            <input type="hidden" name="_method" value="put"></input>
            {!! csrf_field() !!}
        </form>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(timedCount);
    
    var i = 0;
    function timedCount() {
        i = i + 1;
        var min = Math.floor(i / 60);
        if(min / 10 < 1) {
            var tempmin = min;
            min = '0';
            min = min.concat(tempmin);
        }
        var det = i % 60;
        if(det / 10 < 1) {
            var temp = det;
            det = '0';
            det = det.concat(temp);
        }
        var time = min + ":" + det;
        $("#durasi").val(time);
        setTimeout("timedCount()",1000);
    }
    
    function GetCode() {
        var text = editor.getValue();
        $("#inputkode").val(text);
        $("#inputdurasi").val($("#durasi").text());
        $("#inputerrsyntax").val($("#syntaxout").text());
        $("#inputerrconvention").val($("#conventionout").text());
    }
</script>
@endsection
