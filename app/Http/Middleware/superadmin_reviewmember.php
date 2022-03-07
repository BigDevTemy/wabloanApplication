<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
class superadmin_reviewmember
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

            if(Auth::user()->hasRole('super_admin') || Auth::user()->hasRole('review_team_member') ){
                return $next($request);    
            }
            
        }
        else{
            abort(405);
            //return Redirect::route('login');
        }
    }
}
