<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;

use Exception;

class HasToken
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure(\Illuminate\Http\Request): (\Illuminate\Http\Response|\Illuminate\Http\RedirectResponse)  $next
     * @return \Illuminate\Http\Response|\Illuminate\Http\RedirectResponse
     */
    public function handle($request, Closure $next, ...$claims)
    {

        try {
            $payload = Auth::parseToken()->getPayload();
            $checkClaim = $payload->get('claims') ?? [];
            if (!is_array($checkClaim)) {
                $checkClaim = [];
            }
            $isClaim = false;
            foreach ($claims as $claimValue) {
                if (in_array(trim($claimValue), $checkClaim) == 1) {
                    $isClaim = true;
                    break;
                }
            }
            if ($isClaim == false) {
                return response(['Unauthorized Access'], 403);
            }
        } catch (Exception $e) {
            return response(['Unauthorized Access: ' . $e->getMessage()], 401);
        }


        // $checkClaim = Auth::parseToken()->getPayload()->get('claims');

        // if(in_array($claim, $checkClaim) == false) {
        //   //  abort(403);
        //     return response(['Unauthorized Access'],403);
        // }
        return $next($request);
    }
}
