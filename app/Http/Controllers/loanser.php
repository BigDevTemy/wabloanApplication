         
         $getUsername = loanTable::where('userId',$Array[3])->first();
         $check_existing_request = loanTable::where('userId',$Array[3])->where('review_status','pending')->first();
         $check_existing_loan = loanTable::where('userId',$Array[3])->where('review_status','approved')->where('loan_status','unpaid')->first();
         if($check_existing_request!=""){
         	return response()->json(['message'=>'You Already have a pending Loan Request','status'=>'failed']);
         }
         else if($check_existing_loan!=""){
         	return response()->json(['message'=>'You have an Active Loan Scheduled on your Account','status'=>'failed']);		
         }
         elseif($check_existing_loan=="" && $check_existing_request ==""){


         $member->loanID = $loanID;
         $member->userId = $Array[3];
         $member->loan_amount = $Array[0];
         $member->loan_interest = $Array[2];
         $member->loan_tenure = $Array[1];
         $member->loan_total = ((float)$Array[0] * (float)$Array[2]) + (float)$Array[0];
         $member->loan_status='unapproved';
         $member->review_status='unreviewed';
         $member->assignTo='unassigned';
         $member->date_of_request = $now;
         $member->due_date = 'undefined';
         $member->bvn= Auth::user()->bvn;
         $member->phonenumber = Auth::user()->phonenumber;
         $member->fullname=Auth::user()->fname '..'Auth::user()->lname;

         
         $message = 'Your loan request with Loan ID ('.$loanID.') is currently receiving attention.';
         $member1->message = $message;
         $member1->userid = $Array[3];
         $member1->status = 'unread';
         $member1->save();
         $member->save();
         

         return response()->json(['message'=>'Loan Has Submitted For Review','status'=>'success']);
         }
         else{
         	return response()->json(['message'=>'Internal Server Error..pls retry','status'=>'failed']);
         }