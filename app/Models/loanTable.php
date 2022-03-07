<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class loanTable extends Model
{
    protected $table='loans';
    protected $timestamp =true;

    public function user(){
    	return $this->hasOne('App\Models\User','userid','userId');
    }
    public function user_assign(){
    	return $this->hasOne('App\Models\User','userid','assignTo');
    }
    public function loan_disbursement(){
    	return $this->hasOne('App\Models\User','loan_ID','loanID');
    }

}
