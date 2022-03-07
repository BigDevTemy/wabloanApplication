<?php

namespace App\Jobs;

use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;
use Twilio\Exceptions\ConfigurationException;
use Twilio\Exceptions\TwilioException;
use Twilio\Rest\Client;

class SendOTP implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $otp;
    protected $mobilenumber;
    protected $twilioClient;

    /**
     * Create a new job instance.
     *
     * @return void
     */
    public function __construct($otp,$mobilenumber)
    {
        //
        $this->otp =$otp;
        $this->mobilenumber = $mobilenumber;
        $sid = config('services.twilio.account_sid');
        $token = config('services.twilio.auth_token');
        $this->twilioClient = new Client($sid, $token);

    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {

        //
        $template = "Thank you for choosing Wabloan\n Your OTP is ". $this->otp."\n This OTP expires in the next 20mins.\n WabLoan.";
        $body = sprintf($template, 'WabLoan');
        $message = $this->twilioClient->messages->create(
            $this->mobilenumber,
            [
                'from' => '+12026847334',
                'body' => $body
            ]
        );
        
    }
}
