<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\tickets;
use App\Models\reply;
use Illuminate\Support\Facades\Auth;
use App\Jobs\TicketJobMail;
class TicketController extends Controller
{



  public function generateTicketId($length = 5)
    {
      $random = "";
      srand((double) microtime() * 1000000);

      $data = "123456123456789071234567890890";
      // $data .= "aBCdefghijklmn123opq45rs67tuv89wxyz"; // if you need alphabatic also

      for ($i = 0; $i < $length; $i++) {
              $random .= substr($data, (rand() % (strlen($data))), 1);
      }
      $member = new tickets();
      $check_random = $member::where('ticket_id',$random)->first();

      if($check_random !=""){
        $this->generateTicketId();
      }
      else{
        return $random;
      }

      

    }

    public function submit_ticket(Request $request){

      $member = new tickets();
      $ticket_id = $this->generateTicketId();
      $member->fullname = $request->fname;
      $member->email = $request->email;
      $member->subject = $request->subject;
      $member->userid = $request->userid;
      $member->message = $request->message;
      $member->status = 'open';
      $member->ticket_id ='TKT'.$ticket_id;
      

      $emailFrom = 'Hello@wabloan.com';
      $emailSubject = 'TKT'.$ticket_id.'Notification';
      $emailTo=$request->email;
      $fullname = $request->fname;
      
      $member->save(); 

      return response()->json(["message"=>'Ticket has been Submitted Successfully','status'=>'success']);
      $data = [];
      array_push($data,'TKT'.$ticket_id);
      array_push($data,$fullname);

      dispatch(new TicketJobMail($emailFrom,$emailTo,$emailSubject,$data));

      
    }

    public function get_ticket(Request $request){

      $gettickets = tickets::where('userid',$request->userid)->get();

      return response()->json(['message'=>$gettickets,'status'=>'success']);
    }
    public function reply_ticket(Request $request){
      
      $role="";

      foreach(Auth::user()->Roles as $role){
        $role = $role->name;
      }
      
     $member = new reply ();
      $member->ticket_id = $request->ticket_id;
      $member->subject = $request->subject;
      $member->reply_message = $request->reply_message;
      $member->userid = Auth::user()->userid;
      $member->reply_name = Auth::user()->fname .''. Auth::user()->lname;
      $member->role = $role;
      $member->save();

      if($request->close !=""){
        $getId = tickets::where('ticket_id',$request->ticket_id)->first();
        $update = tickets::find($getId->id);
        $update->status = 'close';
        $update->userid_close_ticket = Auth::user()->userid;
        $update->save();


      }
      return response('Reply was successfully saved');

    }

    public function get_reply(Request $request){
      $get_reply = reply::where('ticket_id',$request->ticket_id)->get();

      return response()->json(['message'=>$get_reply,'status'=>'success']);
    }

    public function post_reply(Request $request){
      $role="";

      foreach(Auth::user()->Roles as $role){
        $role = $role->name;
      }
      
      $member = new reply ();
      $member->ticket_id = $request->ticket_id;
      $member->subject = $request->subject;
      $member->reply_message = $request->reply_message;
      $member->userid = Auth::user()->userid;
      $member->reply_name = Auth::user()->fname .' '. Auth::user()->lname;
      $member->role = 'User';
      $member->save();

      $get_latest = reply::where('ticket_id',$request->ticket_id)->orderBy('id','DESC')->get();
      
      return response()->json(['message'=>$get_latest,'status'=>'success']);
    }
    
     public function alltickets(){
      $alltickets = tickets::where('status','close')->get();
      return view('wabloan.all_tickets',compact('alltickets'));
    }

    public function viewticket($ticket_id){

      $get_details = reply::where('ticket_id',$ticket_id)->get();
      
      $ticket_details = tickets::where('ticket_id',$ticket_id)->first();
      return view('wabloan.viewcloseticket',compact('get_details','ticket_details'));
    }



}
