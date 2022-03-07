<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Mail;
use App\Mail\SendTicketJobMail;
class TicketJobMail implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    protected $data;
    protected $emailFrom;
    protected $emailTo;
    protected $emailSubject;
    public function __construct($emailFrom,$emailTo,$emailSubject,$data)
    {
        //
        $this->data = $data;
        $this->emailFrom = $emailFrom;
        $this->emailTo = $emailTo;
        $this->emailSubject = $emailSubject;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        //
         $this->emailFrom;
        $this->emailTo;
        $this->emailSubject;
        
        
        Mail::to($this->emailTo)->send(new SendTicketJobMail($this->emailSubject,$this->emailFrom,$this->data));
    }
}
