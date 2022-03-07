<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\loanTable;
use Carbon\Carbon;
use App\Jobs\LoanDisbursementMailJob;
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:api')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/login','App\Http\Controllers\PublicController@login')->name('login');
Route::get('/checkbvn','App\Http\Controllers\PublicController@checkbvnstatus')->name('checkbvn');
Route::post('/checkbvnstatus','App\Http\Controllers\PublicController@checkbvnstatus')->name('checkstatus');
Route::post('/testPOST','App\Http\Controllers\PublicController@testPOST')->name('testPOST');
Route::post('/checkloginUser','App\Http\Controllers\PublicController@checklogin')->name('checklogin');
Route::get('/terms/and/conditions','App\Http\Controllers\PublicController@terms_and_conditions')->name('terms_and_conditions');

Route::get('/test','App\Http\Controllers\PublicController@termiiOTP')->name('termiiOTP');
Route::post('/confirm_phonenumber','App\Http\Controllers\PublicController@confirm_phonenumber')->name('confirm_phonenumber');
Route::post('/confirm_otp','App\Http\Controllers\PublicController@confirm_otp')->name('confirm_otp');
Route::post('/resolveAccountnumber','App\Http\Controllers\PublicController@resolveAccountnumber')->name('resolveAccountnumber');
Route::post('/confirm_emailaddress','App\Http\Controllers\PublicController@confirmEmailAddress')->name('confirmEmailAddress');
Route::post('/refresh_dashboard','App\Http\Controllers\PublicController@refresh_dashboard')->middleware('auth:api');

Route::post('/upload','App\Http\Controllers\PublicController@uploadImage')->name('uploadImage');

Route::post('/register','App\Http\Controllers\RegisterController@uploadImageUser')->name('uploadImageUser');
Route::post('/registerUsers','App\Http\Controllers\RegisterController@registerUsers')->name('registerUsers');
Route::get('/getloan', 'App\Http\Controllers\PublicController@getloan')->middleware('auth:api');

Route::post('/uploadImageLoanRequest', 'App\Http\Controllers\LoanController@uploadImageLoanRequest')->name('uploadImageLoanRequest');

Route::post('/loanrequest', 'App\Http\Controllers\LoanController@loan_request')->middleware('auth:api');
Route::post('/updatePhoto', 'App\Http\Controllers\PublicController@update_photo')->middleware('auth:api');

Route::post('/repay_loan', 'App\Http\Controllers\LoanController@repay_loan')->middleware('auth:api');
Route::post('/submit_ticket', 'App\Http\Controllers\TicketController@submit_ticket')->middleware('auth:api');
Route::post('/get_ticket', 'App\Http\Controllers\TicketController@get_ticket')->middleware('auth:api');
Route::post('/get_reply', 'App\Http\Controllers\TicketController@get_reply')->middleware('auth:api');
Route::post('/post_reply', 'App\Http\Controllers\TicketController@post_reply')->middleware('auth:api');

Route::post('/getUserData', 'App\Http\Controllers\PublicController@getUserData')->middleware('auth:api');

Route::post('/updateBankDetails', 'App\Http\Controllers\PublicController@updateBankDetails')->middleware('auth:api');

Route::post('/updateUserDetails', 'App\Http\Controllers\PublicController@updateUserDetails')->middleware('auth:api');
Route::post('/updateCompanyDetails','App\Http\Controllers\PublicController@updateCompanyDetails')->middleware('auth:api');
Route::post('/updateCardDetails', 'App\Http\Controllers\PublicController@updateCardDetails')->middleware('auth:api');



