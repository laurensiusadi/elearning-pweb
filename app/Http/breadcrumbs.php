<?php

// home
Breadcrumbs::register('', function($breadcrumbs) {
    $breadcrumbs->push('Home', url(''));
});
Breadcrumbs::register('home', function($breadcrumbs) {
    $breadcrumbs->push('Home', url('home'));
});

// post
Breadcrumbs::register('post', function($breadcrumbs) {
	$breadcrumbs->parent('home');
    $breadcrumbs->push('Pengumuman', url('post'));
});

// user
Breadcrumbs::register('user', function($breadcrumbs) {
	$breadcrumbs->parent('home');
    $breadcrumbs->push('Pengguna', url('user'));
});

// role
Breadcrumbs::register('role', function($breadcrumbs) {
	$breadcrumbs->parent('home');
    $breadcrumbs->push('Role', url('role'));
});

// permission
Breadcrumbs::register('permission', function($breadcrumbs) {
	$breadcrumbs->parent('home');
    $breadcrumbs->push('Permission', url('permission'));
});

// roleuser
Breadcrumbs::register('roleuser', function($breadcrumbs) {
	$breadcrumbs->parent('user');
    $breadcrumbs->push('Role User', url('roleuser'));
});

// permissionrole
Breadcrumbs::register('permissionrole', function($breadcrumbs) {
	$breadcrumbs->parent('role');
    $breadcrumbs->push('Permission Role', url('permissionrole'));
});

// permissionuser
Breadcrumbs::register('permissionuser', function($breadcrumbs) {
	$breadcrumbs->parent('home');
    $breadcrumbs->push('Permission User', url('permissionuser'));
});

// period
Breadcrumbs::register('period', function($breadcrumbs) {
	$breadcrumbs->parent('home');
    $breadcrumbs->push('Periode Perkuliahan', url('period'));
});

// subject
Breadcrumbs::register('subject', function($breadcrumbs) {
	$breadcrumbs->parent('home');
    $breadcrumbs->push('Matakuliah', url('subject'));
});

// course
Breadcrumbs::register('course', function($breadcrumbs) {
	$breadcrumbs->parent('home');
    $breadcrumbs->push('Kursus', url('course'));
});

// enroll
Breadcrumbs::register('enroll', function($breadcrumbs) {
	$breadcrumbs->parent('home');
    $breadcrumbs->push('Enrollment', url('enroll'));
});

// quiz
Breadcrumbs::register('quiz', function($breadcrumbs) {
	$breadcrumbs->parent('enroll');
    $breadcrumbs->push('Penugasan', url('quiz'));
});

// answer
Breadcrumbs::register('answer', function($breadcrumbs) {
	$breadcrumbs->parent('quiz');
    $breadcrumbs->push('Jawaban', url('answer'));
});

// convention
Breadcrumbs::register('convention', function($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('Konvensi Gaya Penulisan Kode', url('convention'));
});

// plagiarism
Breadcrumbs::register('plagiarism', function($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('Plagiarism Check', url('plagiarism'));
});

// similarity
Breadcrumbs::register('similarity', function($breadcrumbs) {
    $breadcrumbs->parent('home');
    $breadcrumbs->push('Student Feedback', url('similarity'));
});
?>