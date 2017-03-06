<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/
Route::auth();

Route::get('/home', 'HomeController@index');
Route::get('/', 'HomeController@index');
Route::post('/compile', 'HomeController@compile');

Route::post('/plagiarism', 'PlagiarismController@check');
Route::get('/plagiarism/{course}/{quiz}/{filter}', 'PlagiarismController@index');
Route::get('/plagiarism/{course}/{quiz}/{filter}/{nrp}', 'PlagiarismController@show');

Route::post('/similarity', 'SimilarityController@check');
Route::get('/similarity/{course}/{quiz}', 'SimilarityController@index');
Route::get('/similarity/{course}/{quiz}/{nrp}', 'SimilarityController@show');

// Route::get('/', function () {
// 	return view('welcome');
// });

Route::group(['middleware' => ['auth', 'acl'],
	'is' => env('ROLE_ADMIN')],
	function () {
		Route::resource('/user', 'UserController');
		Route::resource('/roleuser', 'RoleUserController');
		Route::resource('/role', 'RoleController');
		Route::resource('/permissionrole', 'PermissionRoleController');
		Route::resource('/permission', 'PermissionController');
		Route::resource('/permissionuser', 'PermissionUserController');

		Route::resource('/period', 'PeriodController');
		Route::resource('/subject', 'SubjectController');

		Route::resource('/convention', 'ConventionController');
		Route::resource('/course', 'CourseController');

		Route::resource('/enroll', 'EnrollController');
	});


Route::group(['middleware' => ['auth', 'acl'],
	'is' => env('ROLE_DOSEN')],
	function () {
		Route::get('/enroll/{id}/quiz/create', 'QuizController@create');
		Route::post('/enroll/{id}/quiz', 'QuizController@store');
		Route::get('/enroll/{id}/quiz/{quiz_id}/edit', 'QuizController@edit');
		Route::put('/enroll/{id}/quiz/{quiz_id}', 'QuizController@update');
		Route::delete('/enroll/{id}/quiz/{quiz_id}', 'QuizController@destroy');

	});

Route::group(['middleware' => ['auth', 'acl'],
	'is' => env('ROLE_MHS')],
	function () {
		Route::get('/enroll/{id}/quiz/{quiz_id}/answer/create', 'AnswerController@create');
		Route::post('/enroll/{id}/quiz/{quiz_id}/answer', 'AnswerController@store');
		Route::get('/enroll/{id}/quiz/{quiz_id}/answer/{answer_id}/edit', 'AnswerController@edit');
		Route::put('/enroll/{id}/quiz/{quiz_id}/answer/{answer_id}', 'AnswerController@update');
		Route::delete('/enroll/{id}/quiz/{quiz_id}/answer/{answer_id}', 'AnswerController@destroy');
	});

Route::group(['middleware' => ['auth', 'acl'],
	'is' => env('ROLE_ADMIN').'|'.env('ROLE_DOSEN')],
	function () {
		Route::resource('/post', 'PostController');
	});

Route::group(['middleware' => ['auth', 'acl'],
	'is' => env('ROLE_DOSEN').'|'.env('ROLE_MHS')],
	function () {
		Route::get('/enroll', 'EnrollController@index');

		Route::get('/convention/getregex/{for}', 'ConventionController@getConventionRule');
		Route::get('/convention/getconvmessage/{for}', 'ConventionController@getConventionMessage');
		Route::get('/convention/getconvmin/{for}', 'ConventionController@getConventionMinimal');

		Route::get('/enroll/{id}/quiz', 'QuizController@index');
		Route::get('/enroll/{id}/quiz/{quiz_id}', 'QuizController@show');

		Route::get('/enroll/{id}/quiz/{quiz_id}/answer', 'AnswerController@index');
		Route::get('/enroll/{id}/quiz/{quiz_id}/answer/{answer_id}', 'AnswerController@show');
	});
