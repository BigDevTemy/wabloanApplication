<?php

namespace App\Mail;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class SendTicketJobMail extends Mailable
{
    use Queueable, SerializesModels;

    protected $data;
    protected $emailFrom;
    protected $emailSubject;
    /**
     * Create a new message instance.
     *
     * @return void
     */
    public function __construct($emailSubject,$emailFrom,$data)
    {
        //
        $this->data = $data;
        $this->emailFrom = $emailFrom;
        $this->emailSubject = $emailSubject;
    }

    /**
     * Build the message.
     *
     * @return $this
     */
    public function build()
    {
         return $this->from($this->emailFrom,'WabLoan Lending Enterprise')
                    ->subject($this->emailSubject)
                    ->view('wabloan.email.ticketmail')->with('data',$this->data);
    }
}
