<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use Kodeine\Acl\Models\Eloquent\Role;
use Kodeine\Acl\Models\Eloquent\Permission;
use App\PermissionRole;
use DB;

use Illuminate\Database\QueryException;

class RoleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $roles = Role::all();
        return view('role.index', ['roles' => $roles]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('role.create');
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
            'slug' => 'required',
            'description' => 'required',
            ]);

        // input biasa
        $role = new Role;
        $role->name = $request->name;
        $role->slug = $request->slug;
        $role->description = $request->description;
        $role->save();

        $permissions = DB::table('permissions')
        ->whereNull('inherit_id')
        ->get();

        foreach ($permissions as $permission) {
            $newperm = new Permission();
            $newperm->create([ 
                'inherit_id'  => $permission->id,
                'name'        => $permission->name.'.'.$role->slug,
                'slug'        => [          // pass an array of permissions.
                'create'     => false,
                'view'       => false,
                'update'     => false,
                'delete'     => false
                ],
                'description' => $permission->description.' for '.$role->slug
                ]);
            $lastperm = DB::table('permissions')
            ->where('id', DB::raw("(select max(id) from permissions)"))
            ->select('id')
            ->first();

            $permrole = new PermissionRole;
            $permrole->permission_id = $lastperm->id;
            $permrole->role_id = $role->id;
            $permrole->save();
        }

        return redirect('role')->with('message', 'Role baru berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $role = Role::find($id);

        if(!$role) {
            abort('404');
        }

        return view('role.single')->with('role', $role);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $role = Role::find($id);

        if(!$role) {
            abort('404');
        }

        return view('role.edit')->with('role', $role);
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
            'slug' => 'required',
            'description' => 'required',
            ]);

        // input biasa
        $role = Role::find($id);
        $role->name = $request->name;
        $role->slug = $request->slug;
        $role->description = $request->description;
        $role->save();

        return redirect('role')->with('message', 'Role berhasil diupdate');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $role = Role::find($id);
        
        try {
            $role->delete();
        } catch (QueryException $e) {
            return redirect('role')->with('error', 'Role gagal dihapus, data masih direferensikan');
        }

        DB::table('permissions')->where('name', 'like', '%'.$role->slug)->delete();

        return redirect('role')->with('message', 'Role berhasil dihapus');
    }
}
