<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\loanTable;
use App\Models\User;
use Carbon\Carbon;

class SendSms extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'User:Notification';
     

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Loan Notification Alert';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        \Log::info("Cron is working fine!");

        $this->info('Demo:Cron Cummand Run successfully!');

    }
}
