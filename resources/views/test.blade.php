@extends('layouts.app')

@section('custom-css')
<style>
[class*="scr-"] {padding: 0.1%; float: left; position: relative; min-height: 1px; transition: 0.3s ease}
.scr-full { width:80% }
.scr-min { width:10% }
.scr-normal { width: 33.33333333% }
</style>
@endsection

@section('content')
<div class="container" style="padding: 0">
    <div class="row">
        <div id="desc" class="scr-normal">
            <div class="panel panel-default">
                <div class="panel-heading">Description
                    <a id="desc-full" href="#">
                        <i class="fa fa-arrows-alt pull-right" aria-hidden="true"></i></a>
                </div>
                <div class="panel-body full-height">
                    Your Application's Landing Page.
                </div>
            </div>
        </div>
        <div id="code" class="scr-normal">
            <div class="panel panel-default">
                <div class="panel-heading">Code Area
                    <a id="code-full">
                        <i class="fa fa-arrows-alt pull-right" aria-hidden="true"></i></a>
                </div>
                <div class="panel-body full-height">
                    This is code area.
                </div>
            </div>
        </div>
        <div id="rend" class="scr-normal">
            <div class="panel panel-default ">
                <div class="panel-heading">Render Area
                    <a id="rend-full">
                        <i class="fa fa-arrows-alt pull-right" aria-hidden="true"></i></a>
                </div>
                <div class="panel-body full-height">
                    Your Application's Landing Page.
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@section('scripts')
<script>
$(document).ready(function(){
    $("#desc-full").click(function(){
        if($("#desc").hasClass("scr-full")){
            $("#desc").attr('class','scr-normal');
            $("#code").attr('class','scr-normal');
            $("#rend").attr('class','scr-normal');
        } else {
            $("#desc").attr('class','scr-full');
            $("#code").attr('class','scr-min');
            $("#rend").attr('class','scr-min');
        }
    });
    $("#code-full").click(function(){
        if($("#code").hasClass("scr-full")){
            $("#desc").attr('class','scr-normal');
            $("#code").attr('class','scr-normal');
            $("#rend").attr('class','scr-normal');
        } else {
            $("#desc").attr('class','scr-min');
            $("#code").attr('class','scr-full');
            $("#rend").attr('class','scr-min');
        }
    });
    $("#rend-full").click(function(){
        if($("#rend").hasClass("scr-full")){
            $("#desc").attr('class','scr-normal');
            $("#code").attr('class','scr-normal');
            $("#rend").attr('class','scr-normal');
        } else {
            $("#desc").attr('class','scr-min');
            $("#code").attr('class','scr-min');
            $("#rend").attr('class','scr-full');
        }
    });
});
</script>
<script>
// Test if service workers are supported
if ('serviceWorker' in navigator) {
    // Attempt to register it
    navigator.serviceWorker.register('/sw.js').then(function() {
    // Success Message
    console.log('ServiceWorker succesfully registered');
    }).catch(function(err) {
    // Error Message
    console.log('ServiceWorker registration failed: ', err);
    });
}
</script>
@endsection
