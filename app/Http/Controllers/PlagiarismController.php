<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Http\Requests;
use App\Course;
use App\Quiz;

class PlagiarismController extends Controller
{
    /**
     * @param $request from ajax
     * @return "true"
     */
    public function check(Request $request) {
        set_time_limit(0);
    	chdir('plagiarism_plugin');
    	$inputfile = fopen('inputPath/input.txt', 'w');
    	$input = "input/".$request->courseid."/".$request->quizid. "/\r\n" . $request->courseid . "\r\n" . $request->quizid;
    	fwrite($inputfile, $input);
    	fclose($inputfile);
        shell_exec("ulimit -t 600");
        shell_exec("java -jar " . trim(env('PLAGIARISM'),"'") . " 2> /dev/null & echo $!");
        chdir('..');
        return "true";
    }

    /**
     * @param $course course id
     * @param $quiz quiz id
     * @param $filter filter cluster
     * @return view
     */
    public function index($courseid, $quizid, $filter) {
        $course = Course::find($courseid);
        $quiz = Quiz::find($quizid);
        $enrollid = $quiz->enroll_id;

        try {
            $result = @file_get_contents('plagiarism_plugin/outputCluster/Hasil_Cluster'.$courseid.'_'.$quizid.'.txt');
        } catch (ErrorException $e) {
            return view('plagiarism.index', ['listcluster' => array(), 'fixedcluster' => array(), 'courseid' => $courseid, 'enrollid' => $enrollid, 'quizid' => $quizid, 'selected' => $filter, 'course' => $course, 'quiz' => $quiz, 'proc' => array(), 'listclusterforchart' => json_encode(array()), 'standardeviasiforchart' => json_encode(array())]);
        }
        
        if($result == "") {
            return view('plagiarism.index', ['listcluster' => array(), 'fixedcluster' => array(), 'courseid' => $courseid, 'enrollid' => $enrollid, 'quizid' => $quizid, 'selected' => $filter, 'course' => $course, 'quiz' => $quiz, 'proc' => array(), 'listclusterforchart' => json_encode(array()), 'standardeviasiforchart' => json_encode(array())]);
        }

        $clusterdirty = explode('-----------------------------------------------JUMLAH CLUSTER = ', $result);
        $i = 0;
        $listcluster = array();
        $fixedcluster = array();
        $standardeviasi = array();
        foreach ($clusterdirty as $scrumbled) {
            ++$i;
            if($i == 1) {
                continue;
            }
            $numbersplited = explode('-----------------------------------------------', $scrumbled);
            $cluster = $numbersplited[0];
            $listcluster[] = (int)$cluster;
            $fixedcluster[$cluster] = array();
            $proc[$cluster] = array();

            $memberdirty = $numbersplited[1];
            $stdsplited = preg_split('\'\n\n\'', $memberdirty);

            $clustermember = $stdsplited[0];
            $arrmember = preg_split('\'\n\'', $clustermember);
            $j = 0;
            foreach ($arrmember as $memberdirty) {
                ++$j;
                if($j == 1) {
                    continue;
                }

                $mixedmember = explode('%', $memberdirty);
                $memberonly = $mixedmember[0];
                $member = explode(' ', $memberonly);
                $fixedcluster[$cluster][] = $member;
                if(!empty($mixedmember[1])) {
                    $prosentase = $mixedmember[1];
                    $proc[$cluster][] = $prosentase;
                }
            }

            $stdwithvar = $stdsplited[1];
            $stdwithspace = trim($stdwithvar, "STD =");
            $std = preg_split('\'\n\'', $stdwithspace);

            $fixedcluster[$cluster][] = $std[0];
            $standardeviasi[] = (double)$std[0];
        }
        if($filter == 0) {
            $filter = $listcluster[0];
        }

        return view('plagiarism.index', ['listcluster' => $listcluster, 'fixedcluster' => $fixedcluster[$filter], 'courseid' => $courseid, 'enrollid' => $enrollid, 'quizid' => $quizid, 'selected' => $filter, 'course' => $course, 'quiz' => $quiz, 'listclusterforchart' => json_encode(array_reverse($listcluster)), 'standardeviasiforchart' => json_encode(array_reverse($standardeviasi)), 'proc' => $proc[$filter]]);
    }

    /**
     * @param $course course id
     * @param $quiz quiz id
     * @param $filter filter cluster
     * @param $nrp nrp mahasiswa
     * @return view
     */
    public function show($courseid, $quizid, $filter, $nrp) {
        $course = Course::find($courseid);
        $quiz = Quiz::find($quizid);

        $filepath = '/'.$courseid.' '.$quizid.' '.$nrp.'--.+?\.cpp/';

        $answer = '';
        chdir('plagiarism_plugin/input/'.$courseid.'/'.$quizid);
        foreach (glob($courseid." ".$quizid." ".$nrp."--*.cpp") as $filename) {
            if(preg_match($filepath, $filename)) {
                $answer = @file_get_contents($filename);
            }
        }
        chdir("../../../..");
        return view('plagiarism.single', ['course' => $course, 'quiz' => $quiz, 'filter' => $filter, 'answer' => $answer, 'nrp' => $nrp]);
    }
}
