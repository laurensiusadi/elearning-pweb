<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use DB;

use App\Http\Requests;
use App\Course;
use App\Period;
use App\Subject;

use Illuminate\Database\QueryException;

class CourseController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $courses = DB::table('elearning.kursus as k')
        ->join('elearning.periode as p', 'p.id', '=', 'k.periode_id')
        ->join('elearning.matakuliah as m', 'm.id', '=', 'k.mk_id')
        ->select('k.*', 'p.nama as namaperiode', 'm.nama as namamatakuliah')
        ->get();

        return view('course.index', ['courses' => $courses]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        $periods = Period::all();
        $subjects = Subject::all();

        return view('course.create', ['periods' => $periods, 'subjects' => $subjects]);
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
            'periode_id' => 'required',
            'mk_id' => 'required',
            'nama' => 'required',
            ]);

        // input biasa
        $course = new Course;
        $course->periode_id = $request->periode_id;
        $course->mk_id = $request->mk_id;
        $course->nama = $request->nama;
        $course->save();
        
        if(!file_exists($course->id)) {
            mkdir('kumpulan_sourcecode/'.$course->id);
        }

        return redirect('course')->with('message', 'Kursus baru berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $course = DB::table('elearning.kursus as k')
        ->join('elearning.periode as p', 'p.id', '=', 'k.periode_id')
        ->join('elearning.matakuliah as m', 'm.id', '=', 'k.mk_id')
        ->select('k.*', 'p.nama as namaperiode', 'm.nama as namamatakuliah')
        ->where('k.id', '=', $id)
        ->get();

        if(!$course) {
            abort('404');
        }

        return view('course.single')->with('course', $course);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $course = Course::find($id);
        $periods = Period::all();
        $subjects = Subject::all();

        if(!$course) {
            abort('404');
        }

        return view('course.edit', ['periods' => $periods, 'subjects' => $subjects, 'course' => $course]);
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
            'periode_id' => 'required',
            'mk_id' => 'required',
            'nama' => 'required',
            ]);

        // input biasa
        $course = Course::find($id);
        $course->periode_id = $request->periode_id;
        $course->mk_id = $request->mk_id;
        $course->nama = $request->nama;
        $course->save();
        
        return redirect('course')->with('message', 'Kursus berhasil diupdate');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $course = Course::find($id);
        
        try {
            $course->delete();
        } catch (QueryException $e) {
            return redirect('course')->with('error', 'Kursus gagal dihapus, data masih direferensikan');
        }

        if(file_exists($id)) {
            $status = rmdir($id);
        }

        return redirect('course')->with('message', 'Kursus berhasil dihapus');
    }
}
