<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class superadmin_reviewmanager
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
         if(Auth::check()){

            if(Auth::user()->hasRole('super_admin') || Auth::user()->hasRole('review_teamlead') ){
                return $next($request);    
            }
            
        }
        else{
            
            return Redirect::route('admin.login');
        }
    }
}
