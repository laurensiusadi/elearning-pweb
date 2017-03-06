<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\PermissionRole;
use Kodeine\Acl\Models\Eloquent\Permission;
use Kodeine\Acl\Models\Eloquent\Role;
use DB;

class PermissionRoleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        //
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        //
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
        $permissions = $role->getPermissions();

        return view('permissionrole.single', ['permissions' => Permission::hydrate($permissions), 'roleid' => $id, 'rolename' => $role->name]);
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
        $permissions = DB::table('permission_role')
                        ->leftJoin('permissions', 'permissions.id', '=', 'permission_role.permission_id')
                        ->select('permissions.*')
                        ->where('permission_role.role_id', '=', $id)
                        ->get();

        return view('permissionrole.edit', ['permissions' => Permission::hydrate($permissions), 'roleid' => $id, 'rolename' => $role->name]);
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
        foreach ($request['permissions_id'] as $permission_id) {
            // input biasa
            $permission = Permission::find($permission_id);
            $permission->update([
                'slug'        => [          // pass an array of permissions.
                    'create'     => !empty($request['create::'.$permission_id]) ? true : false,
                    'view'       => !empty($request['view::'.$permission_id]) ? true : false,
                    'update'     => !empty($request['update::'.$permission_id]) ? true : false,
                    'delete'     => !empty($request['delete::'.$permission_id]) ? true : false
                ],
            ]);
        }

        return redirect('permissionrole/'.$id)->with('message', 'Permission berhasil diupdate');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }
}
