<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class reply extends Model
{
    
    protected $table='replies';
    protected $timestamp=true;
    public function ticket(){
    	return $this->hasMany('App\Models\User','ticket_id','ticket_id');
    }

    public function user(){
    	return $this->hasOne('App\Models\User','userid','userid');
    }
}

