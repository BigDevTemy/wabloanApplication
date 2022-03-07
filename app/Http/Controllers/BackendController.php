<?php
namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Validator;
use Redirect;
use App\Models\User;
use App\Models\companydetails;
use App\Models\repay;
use App\Models\reply;
use App\Models\bankdetails;
use Hash;
use App\Models\loanTable;
use Carbon\Carbon;
use GuzzleHttp\Client;
use App\Models\notification;
use App\Models\loan_disbursement;
use App\Jobs\LoanDisbursementMailJob;
use App\Jobs\PasswordNotificationJob;
use DB;
use App\Models\tickets;
use session;
use App\Charts\UserChart;
use App\Charts\LoanChart;
class BackendController extends Controller
{
    //

  public function sendOTP($mobile_number,$amount,$loanid){

        
        $client = new Client();
        
        $username = 'hademylola@gmail.com';
        $password='Ademilola2@';
        $sender='WabLoan';
        $message = "Dear Customer,\n Your Loan Request(".$loanid.") on WabLoan Lending App as been Approved.n\ The Sum of ".$amount." as requested for has been disbursed to your registered account with us.\n\n Thanks For Choosing WabLoan";

    try{
            $response = $client->request('GET', 'https://portal.nigeriabulksms.com/api', [
                
                'query' => [
                    "username" => $username,
                    "password" => $password,
                    "message" => $message,
                    "sender"=>'WabLoan',
                    "mobiles"=>$mobile_number,
                    
               ]

            ]);     
          $result =$response->getBody()->getContents();
              return [json_decode($result),$response->getStatusCode()];
                   
          }
          catch(\GuzzleHttp\Exception\RequestException $e){
            $response = $e->getResponse();
            $responseBodyAsString = json_decode($response->getBody()->getContents());
            return[$responseBodyAsString];
          }

    }
   public function generate_paystack_recipent_code($type,$description,$account_name,$bank,$account_number,$currency){

        
        $client = new Client();
      

        try{
            $res = $client->request('POST', 'https://api.paystack.co/transferrecipient', [
                'headers'  => ['Authorization' => 'Bearer sk_live_624987429bba85f4224571a38b5b35827dd624b8'],  
                'form_params' => [
                    "type" => $type,
                    "name" => $account_name,
                    "description" => $description,
                    "account_number"=>$account_number,
                    "bank_code"=>$bank,
                    "currency"=>$currency
               ]

            ]);


            $result = json_decode($res->getBody()->getContents());
            //return response()->json(['message' => $result->data->recipient_code,'status'=>'success']);
                return $result->data->recipient_code;
          }
          catch(\GuzzleHttp\Exception\RequestException $e){
            $response = $e->getResponse();
            $responseBodyAsString = json_decode($response->getBody()->getContents());
            //return response()->json(['message' => $responseBodyAsString,'status'=>'Error']);
            return [$responseBodyAsString];
          }

    }

    public function transfer_to_recipient_code($recipient_code,$amount,$userid,$loanid){
        //return['Amount'=>(float)$amount*100];
        $client = new Client();
        try{
            $res = $client->request('POST', 'https://api.paystack.co/transfer', [
                'headers'  => ['Authorization' => 'Bearer sk_live_624987429bba85f4224571a38b5b35827dd624b8'],
                'form_params' => [
                    "source" => 'balance',
                    "reason" => 'WabLoan Disbursement',
                    "amount" => (float)$amount*100,
                    "recipient"=>$recipient_code,
               ]

            ]);

            
            $result_all = json_decode($res->getBody()->getContents());
            
            $loan_disburse = new loan_disbursement([
                'paystack_reference'=> $result_all->data->reference,
                'paystack_transfer_code'=>$result_all->data->transfer_code,
                'amount_disbursed'=>$amount,
                'userid'=> $userid,
                'loan_ID'=>$loanid,
            ]);

            $loan_disburse->save();
            return [$result_all->status];
                 
          }
          catch(\GuzzleHttp\Exception\RequestException $e){
            $response = $e->getResponse();
            $responseBodyAsString = json_decode($response->getBody()->getContents());
            return $responseBodyAsString->status;
            
          }


    }

    public function index(){
      if(Auth::user()->hasRole('super_admin')){

          $total_loan_disbursed_sum = loan_disbursement::all()->sum('amount_disbursed');
          $total_sum_repayment_sum = loanTable::where('loan_status','paid')->sum('loan_amount');
          $total_loan_outstanding = loanTable::where('loan_status','unpaid')->sum('loan_amount');
          $members = count(User::WhereDoesntHave('roles')->get());
          
          $loan_count = count(loanTable::all());

          $repayment_count = count(loanTable::where('loan_status','paid')->get());
          $outstanding_count= count(loanTable::where('loan_status','unpaid')->get());
          
                return view('wabloan.sa_dashboard',compact('total_loan_disbursed_sum','total_sum_repayment_sum','total_loan_outstanding','members','loan_count','repayment_count','outstanding_count'));
            }   
            elseif (Auth::user()->hasRole('review_team_member')) {
                
                  return Redirect::route('review_member_dashboard');
            }
            elseif (Auth::user()->hasRole('review_teamlead')) {
                $review_members = User::whereHas('roles', function ($query) {
              $query->where('name', '=', 'review_team_member');
              })->get();
       
              $all_pending_request_loan = loanTable::where('review_status','unreviewed')->where('assignTo','unassigned')->get();
              
                foreach ($all_pending_request_loan as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
              
              return view('wabloan.awaiting_loanrequest',compact('all_pending_request_loan','review_members'));
              
            }
            elseif(Auth::user()->hasRole('collection_team_member_S0'))  {

              $get_due_date_loans = loanTable::where('loan_status','unpaid')->whereDate('due_date', Carbon::today())->get();
                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));

            }  
            elseif(Auth::user()->hasRole('collection_team_member_S1'))  {
                
              $all_loans = loanTable::where('loan_status','unpaid')->get();
              $now = Carbon::now();
              $get_due_date_loans = [];
                  
                  foreach ($all_loans as $key => $value) {
                    
                

                array_push($get_due_date_loans,loanTable::whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  > 0 ")->whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  <= 7 ")->where('loan_status','unpaid')->get());  

                }
                
                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                  
                }
                
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));
              
    
              
            
                
            } 
            elseif(Auth::user()->hasRole('collection_team_member_S2'))  {
              $all_loans = loanTable::where('loan_status','unpaid')->get();
              $now = Carbon::now();
              $get_due_date_loans = [];
              foreach ($all_loans as $key => $value) {
                $due_date = Carbon::parse($value->due_date);

                $result = $now->diffInDays($due_date);
                

                array_push($get_due_date_loans,loanTable::whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  > 7 ")->whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  <= 15 ")->where('loan_status','unpaid')->get());  

              }

                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));
              
            } 
            elseif(Auth::user()->hasRole('collection_team_member_M1'))  {
              $all_loans = loanTable::where('loan_status','unpaid')->get();
              $now = Carbon::now();
              $$get_due_date_loans = [];
              foreach ($all_loans as $key => $value) {
                $due_date = Carbon::parse($value->due_date);

                $result = $now->diffInDays($due_date);
                

                array_push($get_due_date_loans,loanTable::whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  > 15 ")->whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  <= 30 ")->where('loan_status','unpaid')->get());  

              }

                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));
            } 
            elseif(Auth::user()->hasRole('collection_team_member_m2'))  {
              $all_loans = loanTable::where('loan_status','unpaid')->get();
              $now = Carbon::now();
              $get_due_date_loans=[];
              foreach ($all_loans as $key => $value) {
                $due_date = Carbon::parse($value->due_date);

                $result = $now->diffInDays($due_date);
                

                array_push($get_due_date_loans,loanTable::whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  > 30 ")->where('loan_status','unpaid')->get());  

              }

                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));
              
            }
            else if(Auth::user()->hasRole('customer_care')){
                    
              $getPendingTickets = tickets::where('status','open')->get();
              
                foreach ($getPendingTickets as $key => $value) {
                  $update = tickets::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
                $allusers = User::all();
                $allreply = reply::orderBy('id','DESC')->get();
                
                return view('wabloan.customer_care',compact('getPendingTickets','allusers','allreply'));
            }

            

    }
    public function generateUserId($length = 4)
    {
      $random = "";
      srand((double) microtime() * 1000000);

      $data = "123456123456789071234567890890";
      // $data .= "aBCdefghijklmn123opq45rs67tuv89wxyz"; // if you need alphabatic also

      for ($i = 0; $i < $length; $i++) {
              $random .= substr($data, (rand() % (strlen($data))), 1);
      }
      $member = new User();
      $check_random = $member::where('userid',$random)->first();

      if($check_random !=""){
        $this->generateUserId();
      }
      else{
        return $random;
      }

    }
    public function generatePassword($length = 5)
    {
      $random = "";
      srand((double) microtime() * 1000000);

      $data = "123456123456789071234567890890";
      // $data .= "aBCdefghijklmn123opq45rs67tuv89wxyz"; // if you need alphabatic also

      for ($i = 0; $i < $length; $i++) {
              $random .= substr($data, (rand() % (strlen($data))), 1);
      }
      return $random;
      

    }

    public function admin_login(){
      return view('wabloan.login');
    }

    public function admin_logincheck(Request $request){
      $validator = Validator::make($request->all(),[
            'username' => 'required|string',
            'password' => 'required|string',  
           
        ]);

        if ($validator->fails()) {
            $exp = response()->json(['error'=>$validator->errors()]);
            //return $exp;
           return Redirect::back()->withErrors($validator->errors())->withInput();
        }

        $credentials = ["fname"=>$request->username,"password"=>$request->password];

        if(Auth::attempt($credentials)){
          
           if(Auth::user()->status == 'active'){
                    
           return Redirect::route('index');
          }
          else{
            return Redirect::back()->withErrors('Account Suspended..Contact admininstrator')->withInput();
          }

        }
        else{
          return Redirect::back()->withErrors('Invalid username/password')->withInput();
        }
    }

    public function admin_register(){
        return view('wabloan.registerAdminUser');
    }

    public function admin_save_registration(Request $request){
        $validator = Validator::make($request->all(),[
            'fname' => 'required|string|unique:users',
            'lastname' => 'required|string', 
            'email' => 'required|string|unique:users',
            'phonenumber' => 'required|string',
            'password' => 'required|string',  
           
        ]);

        if ($validator->fails()) {
            $exp = response()->json(['error'=>$validator->errors()]);
            //return $exp;
           return Redirect::back()->withErrors($validator->errors())->withInput();
        }
        $userid = $this->generateUserId();

        $member = new User();
        $user = new User([
            'fname' => $request->fname,
            'lname' => $request->lastname,
            'email' => $request->email,
            'phonenumber' => $request->phonenumber,
            'password' => Hash::make($request->password),
            'userid' => $userid

        ]);
        $user->save();
        $user->assignRole('super_admin');

        return Redirect::back()->withErrors('Registration was Successful..Login');
    }

    

    public function awaiting_loan_request(){
       $review_members = User::whereHas('roles', function ($query) {
            $query->where('name', '=', 'review_team_member');
        })->get();
       
      $all_pending_request_loan = loanTable::where('review_status','unreviewed')->where('assignTo','unassigned')->get();
      return view('wabloan.awaiting_loanrequest',compact('all_pending_request_loan','review_members'));
    }

    public function create_staff(){

      return view('wabloan.create_staff');
    }

    public function create_staff_profile(Request $request){
      $validator = Validator::make($request->all(),[
            'fname' => 'required|string|unique:users',
            'lastname' => 'required|string', 
            'email' => 'required|string|unique:users',
            'phonenumber' => 'required|string',
            'password' => 'required|string',
            'role' => 'required|string',  
           
        ]);

        if ($validator->fails()) {
            $exp = response()->json(['error'=>$validator->errors()]);
            //return $exp;
           return Redirect::back()->withErrors($validator->errors())->withInput();
        }

        $userid = $this->generateUserId();
        

        $member = new User();
        $user = new User([
            'fname' => $request->fname,
            'lname' => $request->lastname,
            'email' => $request->email,
            'phonenumber' => $request->phonenumber,
            'password' => Hash::make($request->password),
            'userid' => $userid,
            'status'=>'active'

        ]);
        $emailFrom = 'Hello@wabloan.com';
        $emailSubject = 'Password Notification';
        $emailTo=$request->email;
        $fullname = $request->fname.' '.$request->lastname;
        $password = $request->password;
            
        $user->save();
        $user->assignRole($request->role);
        $data = [];
        array_push($data,$password);
        array_push($data,$fullname);
        
        return Redirect::back()->withErrors('User Successfully Created.A copy of the Password has been Sent to the registered Email');
    }

    public function assignReviewJob(Request $request){
      
       $validator = Validator::make($request->all(),[
            'checkbox' => 'required|array',
            'role_userid'=>'required|string'
        ]);

        if ($validator->fails()) {
            $exp = response()->json(['error'=>$validator->errors()]);
            //return $exp;
           return Redirect::back()->withErrors($validator->errors());
        }

      foreach ($request->checkbox as $key => $value) {
        $member = new loanTable();
        $update = $member::find($value);
        $update->assignTo = $request->role_userid;
        $update->save();
      }

      return Redirect::back()->withErrors('Order Successfully Assigned');

    }
    
    
        public function termiiOTP_repayment($mobile_number,$amount){
        
        //$otp=12345;
        //$mobile_number='07089960448';
        $mobile = substr($mobile_number,1);
        $curl = curl_init();
        $data = array("to" => '234'.$mobile,"from" => "N-Alert",
        "sms"=>"W a b l o a n. Your Loan repayment of ".$amount." was  successfully carried out. You are now Eligible to make another loan request. Thank you for choosing Us","type" => "plain","channel" => "dnd","api_key" => "TLqcjIeX9CMBYW4iHAqzqaoYZcIGIUilPxWlNZc4tyiFSPmJzsTLdvT1WQlZjm",  );

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
    
    
    
    public function termiiOTP($mobile_number,$amount){
        
        //$otp=12345;
        //$mobile_number='07089960448';
        $mobile = substr($mobile_number,1);
        $curl = curl_init();
        $data = array("to" => '234'.$mobile,"from" => "N-Alert",
        "sms"=>"W a b l o a n. Your Loan request of N".$amount." has been disbursed successfully. Thank you for choosing Us","type" => "plain","channel" => "dnd","api_key" => "TLqcjIeX9CMBYW4iHAqzqaoYZcIGIUilPxWlNZc4tyiFSPmJzsTLdvT1WQlZjm",  );

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

    public function assignedloanReview(){
      $getassigned = loanTable::where('assignTo',Auth::user()->userid)->where('review_status','unreviewed')->orderBy('id', 'DESC')->get();
      $getallUsers = User::all();
      $getall_companyDetails = companydetails::all();
      $getall_bankDetails = bankdetails::all();
      $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
      return view('wabloan.assignedloanReview',compact('getassigned','getallUsers','getall_companyDetails','getall_bankDetails','loan_history'));
    }

    public function update_review_status(Request $request){
        
      if($request->review_status == "Approved"){
          
          $get_bank_details = bankdetails::where('userid',$request->userid)->first();
          $loan_details = loanTable::where('userId',$request->userid)->where('loan_status','unapproved')->first();
        if($get_bank_details!=""){

          $type = 'nuban';
          $description = 'WabLoan Disbursement';
          $account_number = $get_bank_details->account_number;
          $bank = $get_bank_details->bank_code;
          $account_name = $get_bank_details->account_name;
          $currency='NGN';
          $amount = $loan_details->loan_amount;
          $response_paystack = $this->generate_paystack_recipent_code($type,$description,$account_name,$bank,$account_number,$currency,$amount);

            if($response_paystack){
                    
              
              $transfer = $this->transfer_to_recipient_code($response_paystack,$amount,$request->userid,$loan_details->loanID);
              $get_number = User::where('userid',$request->userid)->first();
              
              if($transfer){
                    
                
                
                $update_credit_limit_id = User::where('userid',$request->userid)->first();
                $member1 = new notification();
                $getID = loanTable::where('userId',$request->userid)->where('review_status','unreviewed')->first();
                $due_date = Carbon::now()->addDays($getID->loan_tenure);
                
                $update = loanTable::find($getID->id);
                $update->review_status = $request->review_status;
                $update->loan_status = 'unpaid';
                $update->due_date = $due_date;
                $update->remark = $request->remark;
                $update->assignTo = Auth::user()->userid;
                $update->repayment_amount=0;
                $update->balance=0;

                $update_limit = User::find($update_credit_limit_id->id);
                $update_limit->credit_limit = (int)$update_limit->credit_limit - (int)$amount;


                $message = 'Congratulations...your Loan Request with Loan ID('.$getID->loanID.') has been approved';
                $member1->message = $message;
                $member1->userid = $request->userid;
                $member1->status = 'unread';

                $member1->save();
                $update->save();
                $update_limit->save();
                $result = $this->termiiOTP($get_number->phonenumber,$amount);
                
                 return Redirect::back()->withErrors('Review Status Update was Successful');
                 
                
                
              }
              else{
                  
                  return Redirect::back()->withErrors('Please Contact Your PayStack Administrator');
                  
              }
              
              
            }
          
        }
      }
      else if ($request->review_status!=""){
          
        $getid = loanTable::where('userId',$request->userid)->where('review_status','unreviewed')->first();
        $member1 = new notification();
        $update=loanTable::find($getid->id);
        if($update){
          $update->review_status = $request->review_status;
          $update->remark = $request->review_status;
          $update->assignTo = Auth::user()->userid;
          $update->loan_status='unapproved';
          $update->save();
          $message = 'Dear'.$getid->user->fname.',\n Your Loan Request (LoanID:'.$getid->loanID.') was disapproved with  reason:'.$request->review_status.'\n Thank You for Choosing Wabloan';
          $member1->message = $message;
          $member1->userid = $request->userid;
          $member1->status = 'unread';
          $member1->save();
          
          $result = $this->termiiOTP_DISAPPROVED($getid->user->fname,$getid->user->phonenumber,$request->review_status);
                
          return Redirect::back()->withErrors('Review Status was Successfully');
        }
      }
      else{
          return Redirect::back()->withErrors('Kindly Select A Review Category');
      }
      
          
    }

    public function all_assigned_loan_order(Request $request){
      $review_members = User::whereHas('roles', function ($query) {
              $query->where('name', '=', 'review_team_member');
              })->get();

      $get_all_assigned = loanTable::where('review_status','unreviewed')->where('assignTo','<>','unassigned')->get();
      return view('wabloan.all_assigned_order',compact('get_all_assigned','review_members'));
    }

    public function reassign(Request $request){
      
      if($request->id!=""){

        $update = loanTable::find($request->id);
        $update->assignTo = $request->reassign_select;
        $update->save();
        return Redirect::back()->withErrors('Loan has Been Re-assigned');

      }
      return Redirect::back()->withErrors('Internal Server Error..pls try again');
    }

    public function all_loan_order(){
      $orders = loanTable::where('review_status','unreviewed')->get();
      return view('wabloan.all_loan_order',compact('orders'));
    }

    public function all_order_reviewed(){
      $all_order_reviewed = loanTable::where('assignTo',Auth::user()->userid)->get();
      return view('wabloan.all_order_reviewed',compact('all_order_reviewed'));
    }

    public function logout(){
      Auth::logout();
      return Redirect::route('admin.login');
    }
    public function getpending(Request $request){

      if(Auth::user()->hasRole('collection_team_member_S0')){
        

        $get_due_date_loans = loanTable::whereDate('due_date', Carbon::today())->where('ajax_read',null)->get();
        

        return response()->json(['count'=>count($get_due_date_loans),'data'=>$get_due_date_loans]);
      }
      else if(Auth::user()->hasRole('customer_care')){
        $get_all_pending = tickets::where('ajax_read',null)->get();
        return response()->json(['count'=>count($get_all_pending),'data'=>$get_all_pending]);
      }
      else if(Auth::user()->hasRole('review_teamlead')){
        
       
        $all_pending_request_loan = loanTable::where('review_status','unreviewed')->where('assignTo','unassigned')->where('ajax_read',null)->get();
              

        return response()->json(['count'=>count($all_pending_request_loan),'data'=>$all_pending_request_loan]);
      }
        else if(Auth::user()->hasRole('review_team_member')){
        

        $getassigned = loanTable::where('assignTo',Auth::user()->userid)->where('review_status','unreviewed')->where('ajax_read',null)->get();
        
        return response()->json(['count'=>count($getassigned),'data'=>$getassigned]);
      }
      else{

        return response()->json(['count'=>0,'data'=>0]);
      }
      
    }

    public function sendmail(){
            $emailFrom = 'Hello@wabloan.com';
            $emailSubject = 'Loan Repayment Notification';
            $emailTo='segunodewumi12@gmail.com';
            $fullname = Auth::user()->fname;
            $data = [];
            array_push($data,'5000');
            array_push($data,$fullname);
         
            dispatch(new LoanDisbursementMailJob($emailFrom,$emailTo,$emailSubject,$data));
            return response('Mail Sent');
    }
    public function super_admin_s0(){
      $get_due_date_loans = loanTable::where('loan_status','unpaid')->whereDate('due_date', Carbon::today())->get();
                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));

    }
    public function super_admin_s1(){
      
                $all_loans = loanTable::where('loan_status','unpaid')->get();
              $now = Carbon::now();
              $get_due_date_loans = [];
                  
                  foreach ($all_loans as $key => $value) {
                    
                

                array_push($get_due_date_loans,loanTable::whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  > 0 ")->whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  <= 7 ")->where('loan_status','unpaid')->get());  

                }
                
                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                  
                }
                
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));
    }
    public function super_admin_s2(){

      $all_loans = loanTable::where('loan_status','unpaid')->get();
              $now = Carbon::now();
              $get_due_date_loans = [];
              foreach ($all_loans as $key => $value) {
                $due_date = Carbon::parse($value->due_date);

                $result = $now->diffInDays($due_date);
                

                array_push($get_due_date_loans,loanTable::whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  > 7 ")->whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  <= 15 ")->where('loan_status','unpaid')->get());  

              }

                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));
    }
    public function super_admin_m1(){
        $all_loans = loanTable::where('loan_status','unpaid')->get();
              $now = Carbon::now();
              $get_due_date_loans = [];
              foreach ($all_loans as $key => $value) {
                $due_date = Carbon::parse($value->due_date);

                $result = $now->diffInDays($due_date);
                

                array_push($get_due_date_loans,loanTable::whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  > 15 ")->whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  <= 30 ")->where('loan_status','unpaid')->get());  

              }

                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));
    }
    public function super_admin_m2(){
        $all_loans = loanTable::where('loan_status','unpaid')->get();
              $now = Carbon::now();
              $get_due_date_loans=[];
              foreach ($all_loans as $key => $value) {
                $due_date = Carbon::parse($value->due_date);

                $result = $now->diffInDays($due_date);
                

                array_push($get_due_date_loans,loanTable::whereRaw("DATEDIFF('" . Carbon::now() . "',due_date)  > 30 ")->where('loan_status','unpaid')->get());  

              }

                foreach ($get_due_date_loans as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
               $getallUsers = User::all();
               $getall_companyDetails = companydetails::all();
               $getall_bankDetails = bankdetails::all();
               $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
               return view('wabloan.due_date_loan',compact('get_due_date_loans','getall_bankDetails','getall_companyDetails','getallUsers','loan_history'));
    }

    public function changepassword(){
      return view('wabloan.changepassword');
    }

    public function save_changepassword(Request $request){
      $validator = Validator::make($request->all(),[
            'oldpassword' => 'required|string',
            'newpassword' => 'required|string',
            'confirmnewpassword' => 'required|string',  
           
        ]);

        if ($validator->fails()) {
            $exp = response()->json(['error'=>$validator->errors()]);
            //return $exp;
           return Redirect::back()->withErrors($validator->errors())->withInput();
        }

        $credentials = ['password'=>$request->oldpassword,'userid'=>Auth::user()->userid];

        if(Auth::attempt($credentials)){
          if($request->newpassword == $request->confirmnewpassword){
            $update = User::find(Auth::user()->id);
          $update->password = Hash::make($request->newpassword);
          $update->save();
          return Redirect::back()->withErrors('Password has been Updated');
          }
          else{
            return Redirect::back()->withErrors('New Password and Confirmpassword are not the same')->withInput();
          }
          
        }
        else{
          return Redirect::back()->withErrors('Invalid Old Password')->withInput();
        }
    }

    public function review_member(Request $request){
        if(Auth::user()->hasRole('super_admin') ||Auth::user()->hasRole('review_teamlead')){
            $getassigned = loanTable::where('review_status','unreviewed')->orderBy('id', 'DESC')->get();

                  $get_all_loan= loanTable::all()->load('user');
                  $getallUsers = User::all();
                  $getall_companyDetails = companydetails::all();
                  $getall_bankDetails = bankdetails::all();
                  $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
                  return view('wabloan.review_member',compact('getallUsers','getall_companyDetails','getall_bankDetails','loan_history','get_all_loan'))->with('getassigned',$getassigned)->with('get_all_loan',$get_all_loan)->with('getallUsers',$getallUsers)->with('getall_companyDetails',$getall_companyDetails)->with('getall_bankDetails',$getall_bankDetails);
        }
        
      if(Auth::user()){
        $getassigned = loanTable::where('assignTo',Auth::user()->userid)->where('review_status','unreviewed')->orderBy('id', 'DESC')->get();
        
            foreach ($getassigned as $key => $value) {
                  $update = loanTable::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }

                  $get_all_loan= loanTable::all()->load('user');
                  $getallUsers = User::all();
                  $getall_companyDetails = companydetails::all();
                  $getall_bankDetails = bankdetails::all();
                  $loan_history = loanTable::where('loan_status','paid')->orderBy('id','DESC')->get();
                  return view('wabloan.review_member',compact('getallUsers','getall_companyDetails','getall_bankDetails','loan_history','get_all_loan'))->with('getassigned',$getassigned)->with('get_all_loan',$get_all_loan)->with('getallUsers',$getallUsers)->with('getall_companyDetails',$getall_companyDetails)->with('getall_bankDetails',$getall_bankDetails);
      }
      else{
        return Redirect::route('admin.login');
      }
      
    }
    public function search_review(Request $request){
      $query = loanTable::query();
      
    
      if($request->ordersearch !=""){
        $query=$query->where('loanID',$request->ordersearch)->orWhere('bvn',$request->ordersearch)->orWhere('fullname','like',$request->ordersearch.'%')->orWhere('phonenumber',$request->ordersearch);
      }
      if($request->start_date!="" && $request->end_date == null ){
        
        $query=$query->whereDate('created_at',Carbon::parse($request->start_date));
        
      } 
      if($request->end_date!="" && $request->start_date == null){
        
        $query=$query->whereDate('created_at',Carbon::parse($request->end_date));
        
      }
      if($request->start_date!="" && $request->end_date!=""){
        if(Carbon::parse($request->end_date)->gt(Carbon::parse($request->start_date)) or Carbon::parse($request->end_date)->eq(Carbon::parse($request->start_date))){
          $query = $query->where('created_at','>=',Carbon::parse($request->start_date)->startOfDay())->where('created_at','<=',Carbon::parse($request->end_date)->endOfDay());
        }
        else{
          return response()->json(['data'=>'Invalid Date','status'=>'failed']);
        }

      }
      if($request->loanstatus !=""){
         $query=$query->where('loan_status',$request->loanstatus);
      }
      if($request->order_sort!=""){
        $getassigned= $query->where('assignTo',Auth::user()->userid)->orderBy($request->order_sort,'DESC')->get();
      }
      else{
       $getassigned= $query->where('assignTo',Auth::user()->userid)->get(); 
      }
        
        
          return response()->json(['data'=>$getassigned,'status'=>'success']);
        }
      
    
     public function get_customer_details($id){
         
      $userid = loanTable::where('loanID',$id)->first();
      $getUserDetails = User::where('userid',$userid->userId)->first();
      $getBankDetails = bankdetails::where('userid',$userid->userId)->first();
      $getCompanyDetails = companydetails::where('userid',$userid->userId)->first();
      $get_loans = loanTable::where('userId',$userid->userId)->get();
      $loan_count = count($get_loans);
      $get_sum_loans = loanTable::where('userId',$userid->userId)->sum('loan_amount');
      $get_sum_repaid = loanTable::where('userId',$userid->userId)->where('loan_status','paid')->sum('loan_amount');
      $get_outstanding = loanTable::where('userId',$userid->userId)->where('loan_status','unpaid')->first();
      $get_loan_disbursed = loan_disbursement::where('userid',$userid->userId)->select(DB::raw("MONTH(created_at) as months") , DB::raw("(SUM(amount_disbursed)) as Amount_disbursed"))
            ->orderBy('created_at')
            ->groupBy(DB::raw("MONTH(created_at)"))
            ->get();
      $data = [];
      $months = [];
      
        foreach($get_loan_disbursed as $disbursed){
            array_push($data, $disbursed->Amount_disbursed);
            array_push($months, date('F', mktime(0, 0, 0, $disbursed->months, 10)));
        }
        
       
      return view('wabloan.customer_details')->with('userdetails',$getUserDetails)->with('bankdetails',$getBankDetails)->with('companydetails',$getCompanyDetails)->with('loan_history',$get_loans)->with('loan_count',$loan_count)->with('total_loan',$get_sum_loans)->with('total_repaid',$get_sum_repaid)->with('outstanding',$get_outstanding->loan_amount);
    }


    public function autodebit(Request $request){
      $authorization_code = bankdetails::where('userid',$request->id)->first();
      $email = User::where('userid',$request->id)->first();
      $amount = loanTable::where('userId',$request->id)->where('loan_status','unpaid')->first();
      $generate = $this->GuzzlePaystack($authorization_code->authorization_code,$email->email,$amount->loan_total);
      
        $data=[];
        foreach ($generate as $key => $value) {
            
            foreach($value->data as $v){
                array_push($data,$v);
            }
            
        }
        
        if($data[3] == "success"){
            
            $id = loanTable::where('loanID',$amount->loanID)->first();
            $user = User::where('userid',$request->id)->first();
         if($id!=""){
                $update = loanTable::find($id->id);
                $update->loan_amount = $request->loan_amount; 
                $update->loan_status = 'paid';
                if (Carbon::parse($id->due_date)->gt(Carbon::now())){
                  $update->repayment_level = "Early Payment";
                }
                if (Carbon::parse($id->due_date)->eq(Carbon::now())){
                  $update->repayment_level = "Normal Payment";
                }
                if (Carbon::parse($id->due_date)->lt(Carbon::now())){
                  $update->repayment_level = "Late Payment";
                }
                    $update->save();
                    
                $member = new repay();
                $member->paystack_refernce = 'Autodebit';
                $member->userid =$request->userid;
                $member->loanid = $request->loanid;
                $member->amount_paid=$request->loan_amount;
                $member->save();
            
                $id_user = User::where('userid',$request->userid)->first();
                $update_credit_limit = User::find($id_user->id);
                $update_credit_limit->credit_limit = '5000';
                $update_credit_limit->save();
                
                $phonenumber = $user->phonenumber;
                $this->termiiOTP_repayment($phonenumber,$amount->loan_total);
                
            
                return response()->json(['status'=>'true','message'=>'Auto-Debit was Successfully Made']);
        
        
              }
              else{
                  
                return response()->json(['message'=>'Internal Server Errr..pls try again','status'=>'false']);
              }
        }
        else if($data[3]== 'failed'){
                 
                
            return response()->json(['status'=>'false','message'=>$data[7]]);
        }
        
       

      
    }

    public function GuzzlePaystack($Authcode,$email,$amount){
    
      $client = new Client();
    
      try{
            $res = $client->request('POST', 'https://api.paystack.co/transaction/charge_authorization', [
                'headers'  => ['Authorization' => 'Bearer sk_live_624987429bba85f4224571a38b5b35827dd624b8'],  
                'form_params' => [
                    "authorization_code" => $Authcode,
                    "email" => $email,
                    "amount" => floatval($amount) * 100,
                    
               ]

            ]);


            $result = json_decode($res->getBody()->getContents());
            
                return [$result];

                //$this->transfer_to_recipient_code($result->data->recipient_code,$amount);


               // return['Here'=>$amount];
          }
          catch(\GuzzleHttp\Exception\RequestException $e){
            $response = $e->getResponse();
            $responseBodyAsString = json_decode($response->getBody()->getContents());
            return[$responseBodyAsString];
          }
        

    }
    
  
    public function super_customer_care(){
         $getPendingTickets = tickets::where('status','open')->get();
              
                foreach ($getPendingTickets as $key => $value) {
                  $update = tickets::find($value->id);
                  $update->ajax_read = 'read';
                  $update->save();
                }
                $allusers = User::all();
                $allreply = reply::orderBy('id','DESC')->get();
                
                return view('wabloan.customer_care',compact('getPendingTickets','allusers','allreply'));
    }
    
    
    public function makeUpdate(){

      $get_unpaid = loanTable::where('loan_status','unpaid')->get();
        foreach ($get_unpaid as $value) {
            
          $now = Carbon::now();
          $jst_date = $now->toDateString();
          $due_date = Carbon::parse($value->due_date)->subDays(1)->toDateString();
          
          if($jst_date == $due_date){
            $user = User::where('userid',$value->userId)->first();
            $this->termiiOTP_alert($user->fname,$user->phonenumber); 
          }
          
        }
        if(Carbon::now()->gt(Carbon::parse($value->due_date))){
          $user = User::where('userid',$value->userId)->first();
          
            if($value->loan_tenure == 5){
              $loan = loanTable::find($value->id);
              $update = floatval($loan->loan_total) + 75;
              $loan->loan_total = $update;
              $loan->save();
              $this->termiiOTP_reminder($user->fname,$user->phonenumber,$update);
            }
            else if($value->loan_tenure == 10){
              $loan = loanTable::find($value->id);
              $update = floatval($loan->loan_total) + 75;
              $loan->loan_total = $update;
              $loan->save();
              $this->termiiOTP_reminder($user->fname,$user->phonenumber,$update);
            }
            else if($value->loan_tenure == 5){
              $loan = loanTable::find($value->id);
              $update = floatval($loan->loan_total) + 75;
              $loan->loan_total = $update;
              $loan->save();
              $this->termiiOTP_reminder($user->fname,$user->phonenumber,$update);
            }
            
          }
        

    
    }
    public function termiiOTP_alert($name,$phone){
        
        //$otp=12345;
        //$mobile_number='07089960448';
        $mobile = substr($phone,1);
        $curl = curl_init();
        $data = array("to" => '234'.$mobile,"from" => "N-Alert",
        "sms"=>"Dear ".$name.", Kindly be reminded of your loan repayment which will be due for payment tomorrow. W a b l o a n","type" => "plain","channel" => "dnd","api_key" => "TLqcjIeX9CMBYW4iHAqzqaoYZcIGIUilPxWlNZc4tyiFSPmJzsTLdvT1WQlZjm",  );

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
    
    
    public function termiiOTP_DISAPPROVED($name,$phone,$reason){
        
        //$otp=12345;
        //$mobile_number='07089960448';
        $mobile = substr($phone,1);
        $curl = curl_init();
        $data = array("to" => '234'.$mobile,"from" => "N-Alert",
        "sms"=>"Dear ".$name.", Your Loan request was dissaproved.(Reason): ".$reason." Kindly regularise and make another loan request. W a b l o a n","type" => "plain","channel" => "dnd","api_key" => "TLqcjIeX9CMBYW4iHAqzqaoYZcIGIUilPxWlNZc4tyiFSPmJzsTLdvT1WQlZjm",  );

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
    
    public function termiiOTP_reminder($name,$phone,$update){
        
        //$otp=12345;
        //$mobile_number='07089960448';
        $mobile = substr($phone,1);
        $curl = curl_init();
        $data = array("to" => '234'.$mobile,"from" => "N-Alert",
        "sms"=>"Dear ".$name.", an interest has been added to your loan total amount as its already overdue for repayment.Your new refund total is N".$update.".Please Pay now, to avoid daily interest charge (W a b l o a n)","type" => "plain","channel" => "dnd","api_key" => "TLqcjIeX9CMBYW4iHAqzqaoYZcIGIUilPxWlNZc4tyiFSPmJzsTLdvT1WQlZjm",  );

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
    
    public function clear_loan(Request $request){
        if($request->has('images')){
            
           $file = $request->file('images');
           $filename = time().$file->getClientOriginalName();
           $extension = $file->getClientOriginalExtension();
           $fileSize = $file->getSize();
            
           $maxFileSize = 50000;
           
            if($extension == 'jpg' or $extension == 'jpeg' or $extension == 'png' || $extension == 'pdf'){
                if($fileSize < $maxFileSize){
                  $location = 'transfer_reciept';
                    $check_loan_status = loanTable::where('userId',$request->userid)->where('loan_status','unpaid')->first();
                    if($check_loan_status !=""){
                        $file->move($location,$filename);
                        
                        //Start
                        
                        $id = loanTable::where('userId',$request->userid)->where('loan_status','unpaid')->first();
                        
                            $user = User::where('userid',$request->userid)->first();
                         if($id!=""){
                                $update = loanTable::find($id->id);
                                $update->loan_amount = $request->loan_amount; 
                                $update->loan_status = 'paid';
                                if (Carbon::parse($id->due_date)->gt(Carbon::now())){
                                  $update->repayment_level = "Early Payment";
                                }
                                if (Carbon::parse($id->due_date)->eq(Carbon::now())){
                                  $update->repayment_level = "Normal Payment";
                                }
                                if (Carbon::parse($id->due_date)->lt(Carbon::now())){
                                  $update->repayment_level = "Late Payment";
                                }
                                    $update->save();
                                    
                                $member = new repay();
                                $member->paystack_refernce = 'transfer';
                                $member->userid =$request->userid;
                                $member->loanid = $id->loanID;
                                $member->amount_paid=$id->loan_total;
                                $member->image_url = $filename;
                                $member->save();
                            
                                $id_user = User::where('userid',$request->userid)->first();
                                $update_credit_limit = User::find($id_user->id);
                                $update_credit_limit->credit_limit = '5000';
                                $update_credit_limit->save();
                                
                                $phonenumber = $user->phonenumber;
                                $this->termiiOTP_repayment($phonenumber,$id->loan_total);
                                
                                return Redirect::back()->withErrors('Tranfer/Clear Loan was Successfully Made')->withInput();
                        
                        
                              }
                              else{
                                  
                               return Redirect::back()->withErrors('Internal Server Error')->withInput();
                              }
                                        
                    
                        
                        //End
                        
                        
                        return Redirect::back()->withErrors('Upload was Successful')->withInput();
                    }
                    else{
                       
                       return Redirect::back()->withErrors('No Active Loan On the User Account')->withInput();
                    }
                  
                  return response()->json(['message' =>$filename ,'status'=>'success']);
                }
                else{
                  return Redirect::back()->withErrors('File Too Large')->withInput();
                }
                
            }
            else{
                return Redirect::back()->withErrors('Invalid File Format...Strictly jpg|jpeg|png|pdf')->withInput();
            }
            
        
          }
          else{
            return Redirect::back()->withErrors('Internal Server Error..Contact Administrator')->withInput();
          }
        }
  public function allstaffs(){
      $allstaffs = User::whereHas('roles', function ($query) {
              $query->where('name', '<>', 'User');
              })->paginate(25);
      $count_staffs = count($allstaffs);

      return view('wabloan.allbackenduser',compact('allstaffs','count_staffs'));
    }

    public function getstaffprofile(){
      $allprofile = User::whereHas('roles', function ($query) {
              $query->where('name', '<>', 'User')->where('name', '<>', 'super_admin');
              })->get();
      return view('wabloan.resetuserpassword',compact('allprofile'));
    }

    public function resetstaffpassword(Request $request){
      $validator = Validator::make($request->all(),[
            'profile_id' => 'required|string',
            
           
        ]);

        if ($validator->fails()) {
            $exp = response()->json(['error'=>$validator->errors()]);
            //return $exp;
           return Redirect::back()->withErrors($validator->errors())->withInput();
        }

        $update = User::find($request->profile_id);
        $defaultpassword = 'secret';
        $update->password = Hash::make($defaultpassword);
        $update->save();

        return Redirect::back()->withErrors('Password Successfully Reset')->withInput();

    }

    public function suspend_staff(){

      $suspend_staff = User::whereHas('roles', function ($query) {
              $query->where('name', '<>', 'User')->where('name', '<>', 'super_admin');
              })->get();
      return view('wabloan.suspenduser',compact('suspend_staff'));
    }

    public function suspend_activate(Request $request){
      $validator = Validator::make($request->all(),[
            'profile_id' => 'required|string',
            'action' => 'required|string',
            
           
        ]);

        if ($validator->fails()) {
            $exp = response()->json(['error'=>$validator->errors()]);
            //return $exp;
           return Redirect::back()->withErrors($validator->errors())->withInput();
        }


        $update = User::find($request->profile_id);
        if($request->action == 'suspend'){

          $update->status = $request->action;
          $update->save();
          return Redirect::back()->withErrors('Profile Suspended')->withInput();
          }
        else if($request->action == 'active'){
          $update->status = $request->action;
          $update->save();
          return Redirect::back()->withErrors('Profile Activated')->withInput();
          }
        }
        
        
        public function loan_management(){
          $allloans = loanTable::where('review_status','Approved')->get();
          $loan_total = loanTable::where('review_status','Approved')->sum('loan_amount');
          $get_loan_disbursed = loanTable::where('review_status','Approved')->select(DB::raw("MONTH(created_at) as months") , DB::raw("(SUM(loan_amount)) as Amount_disbursed"))
            ->orderBy('created_at')
            ->groupBy(DB::raw("MONTH(created_at)"))
            ->get();
            $data = [];
            $months = [];
              foreach($get_loan_disbursed as $disbursed){
                  array_push($data, $disbursed->Amount_disbursed);
                  array_push($months, date('F', mktime(0, 0, 0, $disbursed->months, 10)));
              }
              $usersChart = new UserChart;
              $usersChart->labels($months);
              $usersChart->dataset('Loan Disbursed', 'line', $data)->options([
                  'fill' => 'true',
                  'borderColor' => '#51C1C0'
              ]);
              $loanChart = new LoanChart;
              $loanChart->labels($months);
              $loanChart->dataset('Loan Disbursed', 'pie', $data)->options([
                  'fill' => 'true',
                  'borderColor' => '#51C1C0'
              ]);;

          return view('wabloan.loanmanagment',['usersChart'=> $usersChart,'loanChart'=> $loanChart])->with('allloans',$allloans)->with('loan_total',$loan_total);
        }

    public function view_loan_details($id){
            $userid = loanTable::where('loanID',$id)->first();
      $getUserDetails = User::where('userid',$userid->userId)->first();
      $getBankDetails = bankdetails::where('userid',$userid->userId)->first();
      $getCompanyDetails = companydetails::where('userid',$userid->userId)->first();

      $get_loans = loanTable::where('userId',$userid->userId)->get();
      $loan_count = count($get_loans);
      $get_sum_loans = loanTable::where('userId',$userid->userId)->sum('loan_amount');
      $get_sum_repaid = loanTable::where('userId',$userid->userId)->where('loan_status','paid')->sum('loan_amount');
      $get_outstanding = loanTable::where('userId',$userid->userId)->where('loan_status','unpaid')->first();
      
      $get_loan_disbursed = loan_disbursement::where('userid',$userid->userId)->select(DB::raw("MONTH(created_at) as months") , DB::raw("(SUM(amount_disbursed)) as Amount_disbursed"))
            ->orderBy('created_at')
            ->groupBy(DB::raw("MONTH(created_at)"))
            ->get();
      $early_repayment = loanTable::where('loanID',$id)->where('repayment_level','Early Repayment')->get();
      $normal_repayment = loanTable::where('loanID',$id)->where('repayment_level','Normal Repayment')->get();
      $late_repayment = loanTable::where('loanID',$id)->where('repayment_level','Late Repayment')->get();
      $data = [];
      $months = [];
        foreach($get_loan_disbursed as $disbursed){
            array_push($data, $disbursed->Amount_disbursed);
            array_push($months, date('F', mktime(0, 0, 0, $disbursed->months, 10)));
        }
        $usersChart = new UserChart;
        $usersChart->labels($months);
        $usersChart->dataset('Loan Disbursed', 'line', $data)->options([
            'fill' => 'true',
            'borderColor' => '#51C1C0'
        ]);;

       
      return view('wabloan.viewloandetails',['usersChart'=> $usersChart])->with('userdetails',$getUserDetails)->with('bankdetails',$getBankDetails)->with('companydetails',$getCompanyDetails)->with('loan_history',$get_loans)->with('loan_count',$loan_count)->with('total_loan',$get_sum_loans)->with('total_repaid',$get_sum_repaid)->with('outstanding',$get_outstanding)->with('unpaid',$get_outstanding->loan_total)->with('early_repayment',$early_repayment)->with('normal_repayment',$normal_repayment)->with('late_repayment',$late_repayment);
    }

    public function get_report(){
          
          return view('wabloan.report');
    }

    public function render_fetch_loan(Request $request){
      

      if($request->startdate !=""){
        if($request->enddate ==""){
          $start_date = Carbon::parse($request->startdate);
          $end_date = Carbon::now();
        }
        else{
          $start_date = Carbon::parse($request->startdate);
        $end_date = Carbon::parse($request->enddate);
        }
        

        if($end_date->gt($start_date)){
          $allloans= loanTable::where('review_status','Approved')->whereBetween('created_at',[$start_date->startOfDay(),$end_date->endofDay()])->get();
          $repaid= repay::whereBetween('created_at',[$start_date->startOfDay(),$end_date->endofDay()])->get()->sum('amount_paid');
          $loan_total = loanTable::where('review_status','Approved')->whereBetween('created_at',[$start_date->startOfDay(),$end_date->endofDay()])->get()->sum('loan_total');
          $outstanding = loanTable::where('review_status','Approved')->where('loan_status','unpaid')->whereBetween('created_at',[$start_date->startOfDay(),$end_date->endofDay()])->get()->sum('loan_total');
          $get_loan_disbursed = loanTable::where('review_status','Approved')->whereBetween('created_at',[$start_date->startOfDay(),$end_date->endofDay()])->select(DB::raw("MONTH(created_at) as months") , DB::raw("(SUM(loan_amount)) as Amount_disbursed"))
            ->orderBy('created_at')
            ->groupBy(DB::raw("MONTH(created_at)"))
            ->get();
            $data = [];
            $months = [];
              foreach($get_loan_disbursed as $disbursed){
                  array_push($data, $disbursed->Amount_disbursed);
                  array_push($months, date('F', mktime(0, 0, 0, $disbursed->months, 10)));
              }
             
              $usersChart = new UserChart;
              $usersChart->labels($months);
              $usersChart->dataset('Loan Disbursed', 'line', $data)->options([
                  'fill' => 'true',
                  'borderColor' => '#51C1C0'
              ]);
              $loanChart = new LoanChart;
              $loanChart->labels($months);
              $loanChart->dataset('Loan Disbursed', 'pie', $data)->options([
                  'fill' => 'true',
                  'borderColor' => '#51C1C0'
              ]);

          return Redirect::back()->withInput(array('allloans'=>$allloans,'startdate'=>$request->startdate,'enddate'=>$request->enddate,'loan_total'=>$loan_total,'repaid'=>$repaid,'outstanding'=>$outstanding,'usersChart'=>$usersChart,'loanChart'=>$loanChart));
        }
        else{
          return Redirect::back()->withErrors('Invalid Date Input Format')->withInput();    
        }
      }
      else{
        return Redirect::back()->withErrors('Start Date Is Mandatory')->withInput();  
      }
      

    }
               
}


