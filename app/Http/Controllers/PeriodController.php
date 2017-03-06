<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Period;

class PeriodController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */

    // protected $fillable = ['tahun', 'semester'];

    public function index()
    {
        $periods = Period::all();
        return view('period.index', ['periods' => $periods]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('period.create');
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
            'nama' => 'required',
            'tahun' => 'required|digits:4',
            'semester' => 'required|digits:1',
            'mulai' => 'date',
            'selesai' => 'date',
        ]);

        // input biasa
        $period = new Period;
        $period->nama = $request->nama;
        $period->tahun = $request->tahun;
        $period->semester = $request->semester;
        $period->mulai = $request->mulai;
        $period->selesai = $request->selesai;
        $period->save();

        return redirect('period')->with('message', 'Periode baru berhasil ditambahkan');
        // mass assignment
        // protected $guarded  = ['tahun', 'semester'];
        // $period = Period::create([
        //     'tahun' => $request->tahun, 
        //     'semester' => $request->semester
        //     ]);
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $period = Period::find($id);

        if(!$period) {
            abort('404');
        }

        return view('period.single')->with('period', $period);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $period = Period::find($id);

        if(!$period) {
            abort('404');
        }

        return view('period.edit')->with('period', $period);
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
            'nama' => 'required',
            'tahun' => 'required|digits:4',
            'semester' => 'required|digits:1',
            'mulai' => 'date',
            'selesai' => 'date',
        ]);

        // input biasa
        $period = Period::find($id);
        $period->nama = $request->nama;
        $period->tahun = $request->tahun;
        $period->semester = $request->semester;
        $period->mulai = $request->mulai;
        $period->selesai = $request->selesai;
        $period->save();

        return redirect('period')->with('message', 'Periode berhasil diupdate');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $period = Period::find($id);

        try {
            $period->delete();
        } catch (QueryException $e) {
            return redirect('period')->with('error', 'Periode gagal dihapus, data masih direferensikan');
        }

        return redirect('period')->with('message', 'Periode berhasil dihapus');
    }
}
