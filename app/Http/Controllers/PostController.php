<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use DB;

use App\Http\Requests;
use App\Post;

class PostController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $posts = DB::table('elearning.posting')
        ->select('elearning.posting.*')
        ->where('elearning.posting.user_id', '=', Auth::id())
        ->get();

        return view('post.index', ['posts' => $posts]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('post.create');
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
            'judul' => 'required',
            'text' => 'required',
            ]);

        // input biasa
        $post = new Post;
        $post->user_id = Auth::id();
        $post->judul = $request->judul;
        $post->text = $request->text;
        $post->save();

        return redirect('post')->with('message', 'Pengumuman baru berhasil ditambahkan');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $post = DB::table('elearning.posting')
        ->select('elearning.posting.*')
        ->where('elearning.posting.id', '=', $id)
        ->get();

        if(!$post) {
            abort('404');
        }

        return view('post.single')->with('post', $post);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $post = Post::find($id);

        if(!$post) {
            abort('404');
        }

        return view('post.edit')->with('post', $post);
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
            'judul' => 'required',
            'text' => 'required',
            ]);

        // input biasa
        $post = Post::find($id);
        $post->user_id = Auth::id();
        $post->judul = $request->judul;
        $post->text = $request->text;
        $post->save();

        return redirect('post')->with('message', 'Pengumuman berhasil diupdate');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $post = Post::find($id);
        try {
            $post->delete();
        } catch (QueryException $e) {
            return redirect('post')->with('error', 'Pengumuman gagal dihapus, data masih direferensikan');
        }

        return redirect('post')->with('message', 'Pengumuman berhasil dihapus');
    }
}
