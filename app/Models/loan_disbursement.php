<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class loan_disbursement extends Model
{
    use HasFactory;
    protected $fillable = [
        'paystack_reference',
        'paystack_transfer_code',
        'loan_ID',
        'userid',
        'amount_disbursed',
       
    ];

}
