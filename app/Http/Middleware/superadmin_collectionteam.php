<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class superadmin_collectionteam
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

            if(Auth::user()->hasRole('super_admin') || Auth::user()->hasRole('collection_team_member_S0') || Auth::user()->hasRole('collection_team_member_S1') || Auth::user()->hasRole('collection_team_member_S2') || Auth::user()->hasRole('collection_team_member_M1') || Auth::user()->hasRole('collection_team_member_m2') ){
                return $next($request);    
            }
            
        }
        else{
            abort(405);
            //return Redirect::route('login');
        }
    }
}
