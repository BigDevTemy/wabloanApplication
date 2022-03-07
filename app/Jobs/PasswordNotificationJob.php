<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Mail;
use App\Mail\PasswordNotificationMail;

class PasswordNotificationJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;
    protected $data;
    protected $emailFrom;
    protected $emailTo;
    protected $emailSubject;
    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($emailFrom,$emailTo,$emailSubject,$data)
    {
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
        Mail::to($this->emailTo)->send(new PasswordNotificationMail($this->emailSubject,$this->emailFrom,$this->data));
    }
}
