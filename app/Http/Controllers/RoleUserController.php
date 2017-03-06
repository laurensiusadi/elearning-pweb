<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\RoleUser;
use App\User;
use Kodeine\Acl\Models\Eloquent\Role;
use DB;

class RoleUserController extends Controller
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
        $user = User::find($id);

        $roles = DB::table('roles')
        ->leftJoin('role_user', function($join) use($id) {
            $join->on('role_user.role_id', '=', 'roles.id');
            $join->on('role_user.user_id', '=', DB::raw($id));
        })
        ->select('roles.*', 'role_user.user_id')
        ->get();

        return view('roleuser.single', ['roles' => $roles, 'userid' => $id, 'username' => $user->name]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $user = User::find($id);

        $roles = DB::table('roles')
        ->leftJoin('role_user', function($join) use($id) {
            $join->on('role_user.role_id', '=', 'roles.id');
            $join->on('role_user.user_id', '=', DB::raw($id));
        })
        ->select('roles.*', 'role_user.user_id')
        ->get();

        return view('roleuser.edit', ['roles' => $roles, 'userid' => $id, 'username' => $user->name]);
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
        $user = User::find($id);
        foreach ($request['roles_id'] as $role_id) {
            $isexist = DB::table('role_user')
            ->select(DB::raw(1))
            ->where('role_id', '=', $role_id)
            ->where('user_id', '=', $id)
            ->get();
            
            if(!empty($request['data::'.$role_id]) && empty($isexist)) {
                $user->assignRole($role_id);
            }
            else if(empty($request['data::'.$role_id]) && !empty($isexist)) {
                $user->revokeRole($role_id);
            }
        }

        return redirect('roleuser/'.$id)->with('message', 'Role berhasil diupdate');
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
