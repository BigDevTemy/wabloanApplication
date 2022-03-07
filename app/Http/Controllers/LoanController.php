<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\loanTable;
use App\Models\User;
use App\Models\wabloan;
use App\Models\loan_repayment;
use App\Models\repay;
use Carbon\Carbon;
use App\Models\notification;
use GuzzleHttp\Client;
use App\Jobs\LoanDisbursementMailJob;
class LoanController extends Controller
{
    //
  public function generateLoanID($length = 6)
    {
      $random = "";
      srand((double) microtime() * 1000000);

      $data = "123456123456789071234567890890";
      // $data .= "aBCdefghijklmn123opq45rs67tuv89wxyz"; // if you need alphabatic also

      for ($i = 0; $i < $length; $i++) {
              $random .= substr($data, (rand() % (strlen($data))), 1);
      }
      $member = new loanTable();
      $check_random = $member::where('loanID',$random)->first();

      if($check_random !=""){
        $this->generateRandomNumber();
      }
      else{
        return $random;
      }

    
    }

    public function generate_paystack_recipent_code($type,$description,$account_number,$account_name,$bank_name,$currency){

        $bank_code = new banks();
        $client = new Client();
        $get_bank_code = $bank_code::where('bank_bankname','=',$bank_name)->first();
        $code = $get_bank_code->bank_bankcode;

        try{
            $res = $client->request('POST', 'https://api.paystack.co/transferrecipient', [
                'headers'  => ['Authorization' => 'Bearer sk_test_d6005747b39cfb241b4e105157928cc9bc956d66'],  
                'form_params' => [
                    "type" => $type,
                    "name" => $account_name,
                    "description" => $description,
                    "account_number"=>$account_number,
                    "bank_code"=>$code,
                    "currency"=>$currency
               ]

            ]);


            $result = json_decode($res->getBody()->getContents());
                return $result->data->recipient_code;

                //$this->transfer_to_recipient_code($result->data->recipient_code,$amount);


               // return['Here'=>$amount];
          }
          catch(\GuzzleHttp\Exception\RequestException $e){
            $response = $e->getResponse();
            $responseBodyAsString = json_decode($response->getBody()->getContents());
            return[$responseBodyAsString];
          }

    }


    public function uploadImageLoanRequest(Request $request){
    
      
     if($request->has('images')){
       $file = $request->file('images');
       $filename = time().$file->getClientOriginalName();
       $extension = $file->getClientOriginalExtension();
       $fileSize = $file->getSize();
        
       $maxFileSize = 5000;
        
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
    
    

    public function loan_request(Request $request){
        
        
        foreach($request->data as $value){
            $loan_amount = $value['loan_amount'];
            $loan_tenure = $value['loan_tenure'];
            $loan_interest = $value['loan_interest'];
            $userid = $value['userid'];
            $bvn = $value['bvn'];
            $fname = $value['fname'];
            $lname = $value['lname'];
            $phonenumber = $value['phonenumber'];
        }
        
        $loan_total = floatval($loan_amount) + (floatval($loan_amount) * floatval($loan_interest));
        
        
        
        
      $loanID= $this->generateLoanID();
      $member = new loanTable();
      $member1 = new notification();
      
      $check_existing_request = loanTable::where('userId',$userid)->where('review_status','unreviewed')->orWhere('review_status','pending')->first();
         $check_existing_loan = loanTable::where('userId',$userid)->where('review_status','approved')->where('loan_status','unpaid')->first();
         
         if($check_existing_request != ""){
          return response()->json(['message'=>'You Already have a pending Loan Request','status'=>'failed']);
         }
         else if($check_existing_loan!=""){
          return response()->json(['message'=>'You have an Active Loan Scheduled on your Account','status'=>'failed']);   
         }
         else if($check_existing_loan == "" && $check_existing_request == ""){
         
            
             $member->loanID = $loanID;
             $member->userId = $userid;
             $member->loan_amount = $loan_amount;
             $member->loan_interest = $loan_interest;
             $member->loan_tenure = $loan_tenure;
             $member->loan_total =$loan_total;
             $member->loan_status='unapproved';
             $member->review_status='unreviewed';
            $member->assignTo='unassigned';
             $member->date_of_request = Carbon::now();
             $member->due_date = 'undefined';
             $member->bvn= $bvn;
             $member->phonenumber = $phonenumber;
             $member->fullname=$fname .' '. $lname;
             $member->save();
             
             $message = 'Your loan request with Loan ID ('.$loanID.') is currently receiving attention.';
             $member1->message = $message;
             $member1->userid = $userid;
             $member1->status = 'unread';
             $member1->save();
             
             $get = User::where('userid',$userid)->first();
             $update = User::find($get->id);
             $update->loan_image_url = $request->filename;
             $update->save();
             
             
             
            return response()->json(['message'=>'Loan Has Submitted For Review','status'=>'success']);
         }
        
    }


    public function repay_loan(Request $request){
      $member = new loan_repayment();
      $id = loanTable::where('loanID',$request->loanid)->first();

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
        $member->paystack_refernce = $request->paystack_reference;
        $member->userid =$request->userid;
        $member->loanid = $request->loanid;
        $member->amount_paid=$request->loan_amount;
        $member->save();
    
        $id_user = User::where('userid',$request->userid)->first();
        $update_credit_limit = User::find($id_user->id);
        $update_credit_limit->credit_limit = '5000';
        $update_credit_limit->save();
        
        
    
        return response()->json(['message'=>'Loan Repayment was Successful','status'=>'success']);


      }
      else{
        return response()->json(['message'=>'Internal Server Errr','status'=>'failed']);
      }

      
    }
}
