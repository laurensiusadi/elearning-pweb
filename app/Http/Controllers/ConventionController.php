<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Convention;
use DB;

class ConventionController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $dbconventions = Convention::all();
        return view('convention.index', ['dbconventions' => $dbconventions]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $conventions = config('conventionmap');
        return view('convention.create', ['conventions' => $conventions]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $this->validate($request,[
            'for' => 'required',
            'regex' => 'required',
            'deskripsi' => 'required',
            'min' => 'required',
            'pesanmin' => 'required',
            ]);

        // input biasa
        $convention = new Convention;
        $convention->for = $request->for;
        $convention->regex = $request->regex;
        $convention->deskripsi = $request->deskripsi;
        $convention->min = $request->min;
        $convention->pesanmin = $request->pesanmin;
        $convention->save();

        return redirect('convention')->with('message', 'Konvensi kode baru berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $convention = Convention::find($id);
        if(!$convention) {
            abort('404');
        }

        return view('convention.single')->with('convention', $convention);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $conventions = config('conventionmap');

        $convention = Convention::find($id);
        if(!$convention) {
            abort('404');
        }

        return view('convention.edit', ['conventions' => $conventions, 'convention' => $convention]);
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
        $this->validate($request,[
            'for' => 'required',
            'regex' => 'required',
            'deskripsi' => 'required',
            'min' => 'required',
            'pesanmin' => 'required',
            ]);

        // input biasa
        $convention = Convention::find($id);
        $convention->for = $request->for;
        $convention->regex = $request->regex;
        $convention->deskripsi = $request->deskripsi;
        $convention->min = $request->min;
        $convention->pesanmin = $request->pesanmin;
        $convention->save();
        return redirect('convention')->with('message', 'Konvensi kode berhasil diupdate');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $convention = Convention::find($id);
        try {
            $convention->delete();
        } catch (QueryException $e) {
            return redirect('convention')->with('error', 'Konvensi kode gagal dihapus, data masih direferensikan');
        }

        return redirect('convention')->with('message', 'Konvensi kode berhasil dihapus');
    }

    /**
     * Get the specified regex for code convention check.
     *
     * @param  string  $for
     * @return string  $regex
     */
    public function getConventionRule($for)
    {
        $regex = DB::table('elearning.convention')
        ->select('regex')
        ->where('for', '=', $for)
        ->get();

        return $regex;
    }

    /**
     * Get the specified message for code convention check.
     *
     * @param  string  $for
     * @return string  $message
     */
    public function getConventionMessage($for)
    {
        $message = DB::table('elearning.convention')
        ->select('deskripsi')
        ->where('for', '=', $for)
        ->get();

        return $message;
    }

    /**
     * Get the specified minimal length for code convention check.
     *
     * @param  string  $for
     * @return string  $min
     */
    public function getConventionMinimal($for)
    {
        $min = DB::table('elearning.convention')
        ->select('min', 'pesanmin')
        ->where('for', '=', $for)
        ->get();

        return $min;
    }
}
