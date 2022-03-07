<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\User;

class LoginController extends Controller
{
 
 	public function checklogin(Request $request){
 		$data = $request->all();
 		$username="";
 		$password="";
 		$Array=array();
 		foreach ($data as $key => $value) {
 			array_push($Array, $value['username']);
 			array_push($Array, $value['password']);
 		}	
 		return response()->json(['message' => $Array[0],'status'=>'status']);	
 	}   
}
