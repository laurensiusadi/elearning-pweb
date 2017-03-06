@extends('layouts.template')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <div class="box box-primary">
                <div class="box-header with-border">
                    <h3 class="box-title">Edit Permission</h3>
                    <a class="btn btn-sm btn-success pull-right" href="{{ url('permission') }}">
                        <i class="fa fa-arrow-left"></i> Kembali
                    </a>
                </div>
                <form class="form" role="form" method="POST" action="{{ url('permission').'/'.$permission->id }}">
                    <div class="box-body">
                        {!! csrf_field() !!}
                        <input type="hidden" name="_method" value="put"></input>

                        <div class="form-group{{ $errors->has('name') ? ' has-error' : '' }}">
                            <label for="name">Nama Permission</label>
                            <input type="text" class="form-control" name="name" placeholder="Nama Permission" value="{{ $permission->name }}">

                            @if ($errors->has('name'))
                            <span class="help-block">
                                <strong>{{ $errors->first('name') }}</strong>
                            </span>
                            @endif
                        </div>

                        <div class="form-group">
                            <label for="slug">Slug</label>
                            <table width="50%">
                                <tr>
                                    @if($permission->slug['create'] == true)
                                    <td><input checked type="checkbox" class="minimal" name="create">Create</td>
                                    @else
                                    <td><input type="checkbox" class="minimal" name="create">Create</td>
                                    @endif
                                    @if($permission->slug['view'] == true)
                                    <td><input checked type="checkbox" class="minimal" name="view">View</td>
                                    @else
                                    <td><input type="checkbox" class="minimal" name="view">View</td>
                                    @endif
                                    @if($permission->slug['update'] == true)
                                    <td><input checked type="checkbox" class="minimal" name="update">Update</td>
                                    @else
                                    <td><input type="checkbox" class="minimal" name="update">Update</td>
                                    @endif
                                    @if($permission->slug['delete'] == true)
                                    <td><input checked type="checkbox" class="minimal" name="delete">Delete</td>
                                    @else
                                    <td><input type="checkbox" class="minimal" name="delete">Delete</td>
                                    @endif
                                </tr>
                            </table>
                        </div>

                        <div class="form-group{{ $errors->has('description') ? ' has-error' : '' }}">
                            <label for="description">Deskripsi</label>
                            <textarea type="text" class="form-control" name="description" placeholder="Deskripsi">{{ $permission->description }}</textarea>

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