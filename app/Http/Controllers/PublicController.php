<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use GuzzleHttp\Client;
use App\Models\mobileConfirmation;
use App\Models\User;
use App\Models\bankdetails;
use App\Models\companydetails;
use Illuminate\Support\Facades\Auth;
use App\Models\loanTable;
use App\Models\notification;
use Carbon\Carbon;
use App\Jobs\LoanDisbursementMailJob;
use App\Jobs\SendOTP;
class PublicController extends Controller
{

    public function start(){
        return view('start');
    }
    public function testPOST(Request $request){

      return response()->json(['Data'=> User::all()]);
    }

    public function test(){
      //$member = new notification();
        //$getNotification = $member::where('userid','51625')->get();
        return response(User::all());
    }
    public function generateRandomNumber($length = 4)
    {
      $random = "";
      srand((double) microtime() * 1000000);

      $data = "123456123456789071234567890890";
      // $data .= "aBCdefghijklmn123opq45rs67tuv89wxyz"; // if you need alphabatic also

      for ($i = 0; $i < $length; $i++) {
              $random .= substr($data, (rand() % (strlen($data))), 1);
      }
      $member = new mobileConfirmation();
      $check_random = $member::where('OTP',$random)->first();

      if($check_random !=""){
        $this->generateRandomNumber();
      }
      else{
        return $random;
      }

      

    }
    
    public function confirm_phonenumber(Request $request){
      
      $data =  $request->all();
      //$mobile_number = $request->mobilenumber;

      $mobile_number="";
      foreach ($data as $key => $value) {
        $mobile_number = $value['mobile_number'];
      }
      
      $exist = User::where('phonenumber',$mobile_number)->first();
       
        
      if($exist!=""){

        return response()->json(['message' => 'Mobile Number Already In use','status'=>'failed']);
      }
      else{
        
       
        $otp = $this->generateRandomNumber();
      
        //dispatch(new SendOTP($otp,$mobile_number));
            $result = $this->termiiOTP($mobile_number,$otp);
            if($result == "Insufficient balance"){
                return response()->json(['message' => 'OTP Server Failed..pls try again','status'=>'failed']);
            }
            else{
               $member = new mobileConfirmation();
            
                $check_mobile = $member::where('mobile_number',$mobile_number)->first();

                if($check_mobile!=""){
                        $update = $member::find($check_mobile->id);
                        $update->OTP = $otp;
                        $update->status = 'unverified';
                        $update->save();
                        return response()->json(['message' => 'A pin has been sent to your mobile phonenumber','status'=>'success']);
                        
                }
                else{
                    $member->OTP = $otp;
                    $member->mobile_number = $mobile_number;
                    $member->status = 'unverified';
                    $member->save();
                    return response()->json(['message' => 'A pin has been sent to your mobile phonenumber','status'=>'success']);
                }    
            }
        
      
      
      }
      
      
    }
    public function testOTP(Request $request){
      $result = $this->sendOTP($request->mobile_number);
      if($result[2] == "200"){
        $member = new mobileConfirmation();
        
        $check_mobile = $member::where('mobile_number',$request->mobile_number)->first();

        if($check_mobile!=""){
            $update = $member::find($check_mobile->id);
            $update->OTP = $result[1];
            $update->status = 'unverified';
            $update->save();

            return response('A Pin has been Sent to your Mobile');
        }
        else{
          $member->OTP = $result[1];

          $member->mobile_number = $request->mobile_number;
          $member->save();
          return response('A Pin has been Sent to your Mobile');
        } 
        
      }
          

    }

    public function confirm_otp(Request $request){

      $data =  $request->all();
      $otp="";
      $mobile_number="";
      foreach ($data as $key => $value) {
        $otp = $value['otp'];
        $mobile_number=$value['mobile_number'];
      } 

      $check = mobileConfirmation::where('mobile_number',$mobile_number)->where('OTP',$otp)->first();
      if($check!=""){
        $update = mobileConfirmation::find($check->id);
        $update->status = 'verified';
        $update->save();
        return response()->json(['message' => 'Mobile Number has been Verified','status'=>'success']);
        
      }
      else{
          return response()->json(['message' => 'Invalid Pin','status'=>'failed']);
          
      }


    }

    public function resolveAccountnumber(Request $request){
      
      $data = $request->all();
      $account_number = "";
      $bank_name = "";
      foreach ($data as $key => $value) {
        $account_number = $value['account_number'];
        $bank_name = $value['bank_name'];
      }



          $curl = curl_init();
    
        curl_setopt_array($curl, array(
        CURLOPT_URL => "https://api.paystack.co/bank/resolve?account_number=".$account_number."&bank_code=".$bank_name,
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_ENCODING => "",
        CURLOPT_MAXREDIRS => 10,
        CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
        CURLOPT_CUSTOMREQUEST => "GET",
        CURLOPT_HTTPHEADER => array(
          "Authorization: Bearer sk_live_624987429bba85f4224571a38b5b35827dd624b8",
          "Cache-Control: no-cache",
        ),
      ));
      
      $response = curl_exec($curl);
      $err = curl_error($curl);
      
      curl_close($curl);
      
      if ($err) {
        //return response("cURL Error #:" . $err);
        return response()->json(['message' => $err,'status'=>'failed']);
      } else {
        $phpArray = json_decode($response,true);
        return response()->json(['message' => $phpArray,'status'=>'success']);
      }
  }

  public function getloan(){
    return 'Verified';
  }

  public function login(){
    return 'Please Login';
  }

  public function uploadImage(Request $request){

    $file = $request->file('photo');
    if($request->has('photo')){
      $filename = time().$file->getClientOriginalName();
      $extension = $file->getClientOriginalExtension();
      $fileSize = $file->getSize();


      $maxFileSize = 2097152;

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
      return response()->json(['message' =>'Internal Server Error..try again' ,'status'=>'failed']);
    }
    
  }

    public function checklogin(Request $request){
         $data = $request->all();

         $member = new notification(); 

         if($request->mobile!="" && $request->fingerprintAuth == 'success' ){
            $getpassword = User::where('phonenumber',$request->mobile)->first();
            $credentials = ['phonenumber'=>$request->mobile,'password'=>$getpassword->plain_password];
            if(Auth::attempt($credentials)){
                
                 $token = Auth::user()->createToken('MyApp')-> accessToken;
            $getNotification = $member::where('userid',Auth::user()->userid)->where('status','unread')->orderBy('id', 'ASC')->limit(3)->get();
            
            $search_active_loan = loanTable::where('userId',Auth::user()->userid)->where('loan_status','unpaid')->first();
            $loan_history = loanTable::where('userId',Auth::user()->userid)->where('loan_status','paid')->orderBy('id','DESC')->get();
            
            if($search_active_loan !=""){
              $get_active_loan = $search_active_loan;
            }
            else{
              $get_active_loan ="eligible";
            }


            return response()->json(['message'=>'Welcome to WabLoan','status'=>'success','token'=>$token,'User'=>Auth::user(),'notification'=>$getNotification,'get_active_loan'=>$get_active_loan,'loan_history'=>$loan_history]);
            }
            else{
                 return response()->json(['message' => 'Invalid Mobile Number/Password','status'=>'failed']);
            }
         }
         else if($request->mobile!="" && $request->password !="" ){

            $credentials = ['phonenumber'=>$request->mobile,'password'=>$request->password];
            //return response($credentials);
        //$credentials = ['phonenumber'=>$request->mobile,'password'=>$request->password]
        
        if(Auth::attempt($credentials)){
          
            $token = Auth::user()->createToken('MyApp')-> accessToken;

            $getNotification = $member::where('userid',Auth::user()->userid)->where('status','unread')->orderBy('id','ASC')->limit(3)->get();

            $search_active_loan = loanTable::where('userId',Auth::user()->userid)->where('loan_status','unpaid')->first();
            $loan_history = loanTable::where('userId',Auth::user()->userid)->where('loan_status','paid')->orderBy('id','DESC')->get();
            
            if($search_active_loan !=""){
              $get_active_loan = $search_active_loan;
            }
            else{
              $get_active_loan ="eligible";
            }

            return response()->json(['message'=>'Welcome to WabLoan','status'=>'success','token'=>$token,'User'=>Auth::user(),'notification'=>$getNotification,'get_active_loan'=>$get_active_loan,'loan_history'=>$loan_history]);
        }
        else{
            return response()->json(['message' => 'Invalid Mobile Number/Password','status'=>'failed']);
        }
           
         }
        
    }   

   public function confirmEmailAddress(Request $request){
      $data = $request->all();
        $Array = array();
        foreach ($data as $key => $value) {
          array_push($Array,$value['email']);
        }
        $confirm = User::where('email',$Array[0])->first();

        if($confirm!=""){
            return response()->json(['message' => 'Email Already in Use','status'=>'failed']);
        }
        else{
          return response()->json(['message' => 'Email is unique','status'=>'success']);
        }
   }

     public function indexpage(){
        return 'Welcome to WabLoan Backend';
    }

    public function refresh_dashboard(Request $request){

        if($request->userid!=""){
            $get = User::where('userid',$request->userid)->first();

            $credentials = ["phonenumber"=>$get->phonenumber,"password"=>$get->plain_password];
        
          if(Auth::user()){
              $token = Auth::user()->createToken('MyApp')-> accessToken;
              $getNotification = notification::where('userid',Auth::user()->userid)->where('status','unread')->orderBy('id', 'ASC')->limit(3)->get();
            $search_active_loan = loanTable::where('userId',Auth::user()->userid)->where('loan_status','unpaid')->first();
            $loan_history = loanTable::where('userId',Auth::user()->userid)->where('loan_status','paid')->orderBy('id','DESC')->get();
            if($search_active_loan !=""){
              $get_active_loan = $search_active_loan;
            }
            else{
              $get_active_loan ="eligible";
            }


            return response()->json(['message'=>'Welcome to WabLoan','status'=>'success','token'=>$token,'User'=>Auth::user(),'notification'=>$getNotification,'get_active_loan'=>$get_active_loan,'wallet_infor'=>Auth::user()->wallet(),'loan_history'=>$loan_history]);
            }
            else{
              return response()->json(['message'=>'Internal Server Error','status'=>'failed']);
            }
        }
        else{
          return response()->json(['message'=>'Internal Server Error','status'=>'failed']);
        }
    }

    public function terms_and_conditions(){
      return view('wabloan.terms_n_condition');
    }

public function checkbvnstatus(Request $request){
    $bvn = '22147069551';
    $check =  User::where('bvn',$request->bvn)->first();

    if($check !=""){
        return response()->json(['message'=>'BVN Already in Use..','status'=>'failed']);
    }
    else{
        return response()->json(['message'=>'BVN Already in Available','status'=>'success']);   
    }
}
public function checkbvn(){
    return 'BVN';
}
public function termii_send(){
        //Wabloan confirmation code".$otp."
        $otp=12345;
        $mobile_number='07089960448';
        $mobile = substr($mobile_number,1);
        $curl = curl_init();
        $data = array("to" => '234'.$mobile,"from" => "N-Alert",
        "sms"=>"Wabloan Lending Enterprise Confirmation code is ".$otp.". Valid for 10 minutes, one time use only","type" => "plain","channel" => "dnd","api_key" => "TLqcjIeX9CMBYW4iHAqzqaoYZcIGIUilPxWlNZc4tyiFSPmJzsTLdvT1WQlZjm",  );

        $post_data = json_encode($data);

        curl_setopt_array($curl, array(
          CURLOPT_URL => "https://termii.com/api/sms/send",
          CURLOPT_RETURNTRANSFER => true,
          CURLOPT_ENCODING => "",
          CURLOPT_MAXREDIRS => 10,
          CURLOPT_TIMEOUT => 0,
          CURLOPT_FOLLOWLOCATION => true,
          CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
          CURLOPT_CUSTOMREQUEST => "POST",
          CURLOPT_POSTFIELDS => $post_data,
          CURLOPT_HTTPHEADER => array(
            "Content-Type: application/json"
          ),
        ));

        $response = curl_exec($curl);
        curl_close($curl);
        return  $response;
        

    }

public function termiiOTP($mobile_number,$otp){
        
        //$otp=12345;
        //$mobile_number='07089960448';
        $mobile = substr($mobile_number,1);
        $curl = curl_init();
        $data = array("to" => '234'.$mobile,"from" => "N-Alert",
        "sms"=>"W a b l o a n Lending Company Limited Confirmation code is ".$otp.". Valid for 10 minutes, one time use only","type" => "plain","channel" => "dnd","api_key" => "TLqcjIeX9CMBYW4iHAqzqaoYZcIGIUilPxWlNZc4tyiFSPmJzsTLdvT1WQlZjm",  );

        $post_data = json_encode($data);

        curl_setopt_array($curl, array(
          CURLOPT_URL => "https://termii.com/api/sms/send",
          CURLOPT_RETURNTRANSFER => true,
          CURLOPT_ENCODING => "",
          CURLOPT_MAXREDIRS => 10,
          CURLOPT_TIMEOUT => 0,
          CURLOPT_FOLLOWLOCATION => true,
          CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
          CURLOPT_CUSTOMREQUEST => "POST",
          CURLOPT_POSTFIELDS => $post_data,
          CURLOPT_HTTPHEADER => array(
            "Content-Type: application/json"
          ),
        ));

        $response = curl_exec($curl);
        curl_close($curl);
        return  $response;
        

    }
     public function aboutus(){
      return view('aboutus');
    }
     public function contactus(){
      return view('contact');
    }
    public function faq(){
      return view('faq');
    }
    
    public function getUserData(Request $request){
        
        if($request->userid !=""){
            $company = companydetails::where('userid',$request->userid)->get
            ();
            $user = User::where('userid',$request->userid)->get();
            $bank = bankdetails::where('userid',$request->userid)->get();
            
            return response()->json(['status'=>'success','userprofile'=>$user,'bankdetails'=>$bank,'companydetails'=>$company]);
        }
        
        
        
    }
    
    public function updateUserDetails(Request $request){
        
        if($request->userid !=""){
            
            $id = User::where('userid',$request->userid)->first();
            $update =  User::find($id->id);
            
            $update->familycontact = $request->contactI;
            $update->friendcontact = $request->contactII;
            $update->save();
            return response()->json(['status'=>'success','message'=>'Update was Successful']);
            
        }
        else{
            return response()->json(['status'=>'failed','message'=>'Update Failed...try again']);
        }
    }
    
    
     public function updateBankDetails(Request $request){
        
        if($request->userid !=""){
           
           $id = bankdetails::where('userid',$request->userid)->first();
            
            $update =  bankdetails::find($id->id);
            $update->account_number = $request->account_number;
            $update->account_name = $request->account_name;
            $update->bank_code = $request->bank;
            $update->save();
            return response()->json(['status'=>'success','message'=>'Update was Successful']);
        }
        else{
            return response()->json(['status'=>'failed','message'=>'Update Failed...try again']);
        }
    }
    
     public function updateCompanyDetails(Request $request){
        
        if($request->userid !=""){
            $id = companydetails::where('userid',$request->userid)->first();
            
            $update =  companydetails::find($id->id);
            $update->company_name = $request->employer;
            $update->company_contact = $request->company_contact;
            $update->save();
            return response()->json(['status'=>'success','message'=>'Update was Successful']);
        }
        else{
            return response()->json(['status'=>'failed','message'=>'Update Failed...try again']);
        }
    }
    
     public function updateCardDetails(Request $request){
        
        if($request->userid !=""){
            
            $id = bankdetails::where('userid',$request->userid)->first();
            
            
            $update =  bankdetails::find($id->id);
            $update->card_pan =$request->card_pan;
            $update->card_pin =$request->card_pin;
            $update->card_ccv =$request->card_ccv;
            $update->card_type =$request->card_type;
            $update->exp_month =$request->expiry_month;
            $update->exp_year =$request->expiry_year;
            $update->authorization_code =$request->auth_code;
        
            $update->save();
            return response()->json(['status'=>'success','message'=>'Update was Successful']);
            
            
            
            
        }
        else{
            return response()->json(['status'=>'failed','message'=>'Update Failed...try again']);
        }
    }
    
    public function update_photo(Request $request){
        
        $getid = User::where('userid',$request->userid)->first();
        
        $update = User::find($getid->id);
        if($update){
            $update->imageurl = $request->filename;
            $update->save();
            return response()->json(['status'=>'success','message'=>'Update was Successful Made']);
        }
        else{
             return response()->json(['failed'=>'failed','message'=>'Internal Server Error..try Again later']);    
        }
        
            
    }
    

}