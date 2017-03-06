<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use Kodeine\Acl\Models\Eloquent\Permission;
use DB;

class PermissionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $permissions = DB::table('permissions')
        ->whereNull('inherit_id')
        ->get();

        return view('permission.index', ['permissions' => Permission::hydrate($permissions)]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('permission.create');
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'name' => 'required',
            'description' => 'required',
            ]);

        // input biasa
        $permission = new Permission();
        $permission->create([ 
            'name'        => $request->name,
            'slug'        => [          // pass an array of permissions.
            'create'     => !empty($request->create) ? true : false,
            'view'       => !empty($request->view) ? true : false,
            'update'     => !empty($request->update) ? true : false,
            'delete'     => !empty($request->delete) ? true : false
            ],
            'description' => $request->description
            ]);

        return redirect('permission')->with('message', 'Permission baru berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $permission = Permission::find($id);

        if(!$permission) {
            abort('503');
        }

        return view('permission.single')->with('permission', $permission);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $permission = Permission::find($id);

        if(!$permission) {
            abort('503');
        }

        return view('permission.edit')->with('permission', $permission);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'name' => 'required',
            'description' => 'required',
            ]);

        // input biasa
        $permission = Permission::find($id);
        $permission->update([ 
            'name'        => $request->name,
            'slug'        => [          // pass an array of permissions.
            'create'     => !empty($request->create) ? true : false,
            'view'       => !empty($request->view) ? true : false,
            'update'     => !empty($request->update) ? true : false,
            'delete'     => !empty($request->delete) ? true : false
            ],
            'description' => $request->description
            ]);

        return redirect('permission')->with('message', 'Permission berhasil diupdate');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $permission = Permission::find($id);
        try {
            $permission->delete();
        } catch (QueryException $e) {
            return redirect('permission')->with('error', 'Permission gagal dihapus, data masih direferensikan');
        }

        return redirect('permission')->with('message', 'Permission berhasil dihapus');
    }
}
