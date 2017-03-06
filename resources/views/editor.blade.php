@extends('layouts.template')

@section('content')
<style type="text/css" media="screen">
    #editor {
        margin: 0;
        position: absolute;
        top: 0;
        bottom: 0;
        left: 0;
        right: 0;
        height: 300px;
    }
</style>
<div class="container">
    <div class="row">
        <div class="col-md-10 col-md-offset-1">
            <div class="panel panel-default">
                <div class="panel-body">
                    <button onclick="getString()">
                        Get Code!
                    </button>
                </div>
            </div>
        </div>
        <div class="col-md-10 col-md-offset-1">
            <div class="panel-body">
                <!-- <div id="editor">#include<iostream> int main() { cout << "Hai" << endl; }</div> -->
                <div id="editor">function myFunction(a, b) { return a * b; }</div>
            </div>
        </div>
    </div>
</div>

<!-- Ace -->
<script src="{!! asset('ace-builds/src-noconflict/ace.js') !!}" type="text/javascript" charset="utf-8"></script>
<!-- ANTLR Worker -->
<script src="{!! asset('/js/my-mode.js') !!}" type="text/javascript" charset="utf-8"></script>
<script>
  var editor = ace.edit("editor");
  editor.setTheme("ace/theme/twilight");
  // editor.getSession().setMode("ace/mode/my-mode");
  editor.getSession().setMode("ace/mode/javascript");
</script>
<script type="text/javascript">
  function getString() {
    var text = editor.getValue();
    alert(text);
  }
</script>
@endsection
