<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use App\Models\User;
use App\Models\companydetails;
use App\Models\bankdetails;
use App\Models\loanTable;
use Validator;
use Redirect;
use Hash;
use App\Models\notification;
use Illuminate\Support\Facades\Auth;

class RegisterController extends Controller
{
    //
    public $successStatus = 200;
    public function test(){
      return response('Welcome to wabloan');
    }

    public function generateUserID($length = 5)
    {
      $random = "";
      srand((double) microtime() * 1000000);

      $data = "123456123456789071234567890890";
      // $data .= "aBCdefghijklmn123opq45rs67tuv89wxyz"; // if you need alphabatic also

      for ($i = 0; $i < $length; $i++) {
              $random .= substr($data, (rand() % (strlen($data))), 1);
      }
      $check_random = User::where('userid',$random)->first();
      

      if($check_random !=""){
        $this->generateRandomNumber();
      }
      else{
        return $random;
      }

      

    }

    public function uploadImageUser(Request $request){
    
      
     if($request->has('images')){
       $file = $request->file('images');
       $filename = time().$file->getClientOriginalName();
       $extension = $file->getClientOriginalExtension();
       $fileSize = $file->getSize();
        
       $maxFileSize = 1000000;

        if($fileSize < $maxFileSize){
          $location = 'wabloan_selfie';

          $file->move($location,$filename);
          return response()->json(['message' =>$filename ,'status'=>'success']);
          

        }
        else{
          return response()->json(['message' =>'File too Large' ,'status'=>'failed']);
        }
    
      }
      else{
        return response()->json(['message' =>'Invalid Image File..try again' ,'status'=>'failed']);
      }
  }

  public function registerUsers(Request $request){
    $data= $request->all();
    $member_bank = new bankdetails();
    $member_company = new companydetails();
    $new = array();
    $userid = $this->generateUserID();
    foreach ($data as $key => $value) {
      foreach ($value as $key => $v) {
        array_push($new, $v);
      }
    }
    $check = User::where('phonenumber',$new[1]['mobile_number'])->first();
    if($check!=""){
      return response()->json(['message' => 'Mobile Number Already In Use','status'=>'failed']);
    }
    else{
      $user = User::create([
              'fname'=>$new[0]['first_name'],
              'lname'=>$new[0]['last_name'],
              'email'=>$new[2]['email'],
              'password'=>$new[3]['password'],
              'dob'=>$new[0]['dob'],
              'password'=>Hash::make($new[3]['password']),
              'phonenumber'=>$new[1]['mobile_number'],
              'marital_status'=>$new[2]['marital_status'],
              'bvn'=>$new[0]['bvn'],
              'state'=>$new[2]['state'],
              'familycontact'=>$new[2]['familynumber'],
              'familycontactname'=>$new[2]['familycontactname'],
              'friendcontact'=>$new[2]['friendnumber'],
              'friendcontactname'=>$new[2]['friendcontactname'],
              'imageurl'=>$new[6]['photoUri'],
              'credit_limit'=>5000,
              'userid'=>$userid,
              'plain_password'=>$new[3]['password']
          ]);

        $member_company->company_name = $new[4]['company_name'];
        $member_company->company_contact = $new[4]['company_contact'];
        $member_company->company_address = $new[4]['company_address'];
        $member_company->company_state = $new[4]['company_state_location'];
        $member_company->employment_type = $new[4]['employment_type'];
        $member_company->salary_range = $new[4]['salary_range'];
        $member_company->userid = $userid;
        $member_company->save();

        $member_bank->account_number =$new[5]['account_number'];
        $member_bank->account_name =$new[5]['account_name'];
        $member_bank->bank_code =$new[5]['bank_name'];
        $member_bank->card_pan =$new[5]['card_pan'];
        $member_bank->card_ccv =$new[5]['card_ccv'];
        $member_bank->card_type = $new[5]['card_type'];
        $member_bank->card_pin =$new[5]['card_pin'];
        $member_bank->exp_month =$new[5]['exp_month'];
        $member_bank->exp_year =$new[5]['exp_year'];
        $member_bank->authorization_code =$new[5]['authorization_code'];
        $member_bank->userid =$userid;
        $member_bank->save();

        $getNotification = notification::where('userid',$userid)->where('status','unread')->orderBy('id', 'DESC')->get();
        $search_active_loan = loanTable::where('userId',$userid)->where('loan_status','unpaid')->first();
        $get_loan_history = loanTable::where('userId',$userid)->get();

          $token = $user->createToken('MyApp')-> accessToken;
          $wallet=0;
          $credentials = ['phonenumber'=>$new[1]['mobile_number'],'password'=>$new[3]['password']];
          if(Auth::attempt($credentials)){
            $userData = Auth::user();
          }
          
          if($search_active_loan !=""){
              $get_active_loan = $search_active_loan;
            }
            else{
              $get_active_loan ="eligible";
            }

      return response()->json(['token' => $token,'status'=>'Data Successfully Saved','notification'=>$getNotification,'User'=>$userData,'wallet'=>$wallet,'get_active_loan'=>$get_active_loan,'loan_history'=>$get_loan_history]);
    }



     
    
  }

}