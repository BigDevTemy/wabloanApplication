<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class tickets extends Model
{
    use HasFactory;
    public function user(){
    	return $this->hasOne('App\Models\User','userid','userid');
    }
    public function userassigned(){
    	return $this->hasOne('App\Models\User','userid','userid_close_ticket');
    }
}
