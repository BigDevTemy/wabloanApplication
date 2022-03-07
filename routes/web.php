<?php
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/','App\Http\Controllers\PublicController@start')->name('start');
Route::get('wabloan/aboutus','App\Http\Controllers\PublicController@aboutus')->name('aboutus');
Route::get('/wabloan/contactus','App\Http\Controllers\PublicController@contactus')->name('contactus');
Route::get('/wabloan/faq','App\Http\Controllers\PublicController@faq')->name('faq');
Route::get('/clear-cache', function() {
 $exitCode = Artisan::call('optimize');
 return 'Application cache cleared';
});

Route::get('/test-artisan', function() {
    $output = [];
    \Artisan::call('make:controller testController', $output);
    dd($output);
});
//Route::view('/{path?}', 'app');
Route::get('/backend/change/password','App\Http\Controllers\BackendController@changepassword')->name('changepassword');
Route::post('/backend/save/password','App\Http\Controllers\BackendController@save_changepassword')->name('post_changepassword');
Route::get('/admin/login/backend','App\Http\Controllers\BackendController@admin_login')->name('admin.login');
Route::post('/admin/checklogin','App\Http\Controllers\BackendController@admin_logincheck')->name('admin.loginCheck');
Route::get('/admin/register/backend','App\Http\Controllers\BackendController@admin_register')->name('admin.register');
Route::post('/admin/save_registration','App\Http\Controllers\BackendController@admin_save_registration')->name('admin.save_registration');


Route::get('logout','App\Http\Controllers\BackendController@logout')->name('logout');


Route::get('/backend/dashboard','App\Http\Controllers\BackendController@index')->name('index');

Route::group(["middleware"=>"superadmin"],function(){

Route::get('backend/create/staff','App\Http\Controllers\BackendController@create_staff')->name('admin.create_staff');
Route::post('backend/create_staff_profile','App\Http\Controllers\BackendController@create_staff_profile')->name('admin.create_staff_profile');

Route::get('backend/users/staff','App\Http\Controllers\BackendController@allstaffs')->name('admin.allstaffs');
Route::get('backend/getstaff/profile','App\Http\Controllers\BackendController@getstaffprofile')->name('admin.getstaffprofile');

Route::post('backend/resetstaffpassword','App\Http\Controllers\BackendController@resetstaffpassword')->name('admin.resetstaffpassword');
Route::get('backend/suspend/staff','App\Http\Controllers\BackendController@suspend_staff')->name('admin.suspend_staff');
Route::post('backend/suspend/staff/action','App\Http\Controllers\BackendController@suspend_activate')->name('admin.suspend_activate');
Route::get('loans/management/report','App\Http\Controllers\BackendController@loan_management')->name('admin.loan_management');
Route::get('view/customerloan/details/{id}','App\Http\Controllers\BackendController@view_loan_details')->name('admin.viewloandetails');

Route::get('/loan/getreport','App\Http\Controllers\BackendController@get_report')->name('admin.report');
Route::post('render/fetch/loan/details','App\Http\Controllers\BackendController@render_fetch_loan')->name('admin.render_fetch');

});

Route::get('/all/open/tickets/','App\Http\Controllers\BackendController@super_customer_care')->name('super_customer_care');
Route::get('/all/due_loans/review/s0','App\Http\Controllers\BackendController@super_admin_s0')->name('collection1');
	Route::get('/all/due_loans/review/s1','App\Http\Controllers\BackendController@super_admin_s1')->name('collection2');
	Route::get('/all/due_loans/review/s2','App\Http\Controllers\BackendController@super_admin_s2')->name('collection3');
	Route::get('/all/due_loans/review/m1','App\Http\Controllers\BackendController@super_admin_m1')->name('collection4');
	Route::get('/all/due_loans/review/m2','App\Http\Controllers\BackendController@super_admin_m2')->name('collection5');
Route::get('/getpending/count','App\Http\Controllers\BackendController@getpending')->name('ajax_pending');

Route::get('sendmail','App\Http\Controllers\BackendController@sendmail')->name('sendmail');


Route::group(["middleware"=>"superadmin_reviewmanager"],function(){
	
Route::get('backend/review_manager/awaiting/loan/review','App\Http\Controllers\BackendController@awaiting_loan_request')->name('awaiting_loan_request');
Route::post('backend/review_manager/awaiting/loan/assign','App\Http\Controllers\BackendController@assignReviewJob')->name('assignReviewJob');
Route::get('backend/review_manager/assigned/loan/team','App\Http\Controllers\BackendController@all_assigned_loan_order')->name('all_assigned_loan_order');
Route::post('/reassign','App\Http\Controllers\BackendController@reassign')->name('reassign');
Route::get('backend/review_manager/all/order/request','App\Http\Controllers\BackendController@all_loan_order')->name('all_loan_order');


});

Route::group(["middleware"=>"superadmin_reviewmember"],function(){
Route::group(["prefix"=>'review_member'], function(){
	Route::get('/backend/dashboard','App\Http\Controllers\BackendController@review_member')->name('review_member_dashboard');
	Route::get('/assigned/loanreview','App\Http\Controllers\BackendController@assignedloanReview')->name('assignedloanreview');
Route::post('/appoveloan/loanreview','App\Http\Controllers\BackendController@update_review_status')->name('update_review_status');
Route::get('/all/order/review','App\Http\Controllers\BackendController@all_order_reviewed')->name('all_order_reviewed');
Route::post('/search/review','App\Http\Controllers\BackendController@search_review')->name('search_review');


	
});

});



Route::group(["middleware"=>"superadmin_collectionteam"],function(){
Route::group(["prefix"=>'collection_team'], function(){
    Route::get('/backend/customer_details/{id}','App\Http\Controllers\BackendController@get_customer_details')->name('get_customer_details');
	Route::post('/backend/automatic_debit/','App\Http\Controllers\BackendController@autodebit')->name('autodebit');
	
	Route::post('/backend/clear_loan/','App\Http\Controllers\BackendController@clear_loan')->name('clear_loan');
	
});


});


Route::group(["middleware"=>"superadmin_customercare"],function(){
Route::group(["prefix"=>'customer_care'], function(){
Route::post('/reply/ticket','App\Http\Controllers\TicketController@reply_ticket')->name('reply_ticket');	
Route::get('/all/tickets','App\Http\Controllers\TicketController@alltickets')->name('alltickets');

Route::get('/view/ticket/id/{ticket_id}','App\Http\Controllers\TicketController@viewticket')->name('viewticket');
	
});

});
