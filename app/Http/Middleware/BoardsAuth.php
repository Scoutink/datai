<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Exception;

/**
 * Middleware for Boards web routes (Blade pages)
 * Handles JWT authentication from cookie and RBAC claims checking
 */
class BoardsAuth
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string  ...$requiredClaims
     * @return mixed
     */
    public function handle(Request $request, Closure $next, ...$requiredClaims)
    {
        try {
            // Try to get token from cookie first, then from Authorization header
            $token = $request->cookie('token') ?? $request->bearerToken();
            
            if (!$token) {
                return $this->redirectToLogin($request, 'No authentication token found');
            }
            
            // Set the token for parsing
            Auth::setToken($token);
            
            // Validate token and get payload
            $payload = Auth::parseToken()->getPayload();
            $userId = $payload->get('userId');
            $claims = $payload->get('claims') ?? [];
            
            if (!$userId) {
                return $this->redirectToLogin($request, 'Invalid token payload');
            }
            
            // Check required claims if specified
            if (!empty($requiredClaims)) {
                $hasAccess = false;
                foreach ($requiredClaims as $claim) {
                    if (in_array(trim($claim), $claims)) {
                        $hasAccess = true;
                        break;
                    }
                }
                
                if (!$hasAccess) {
                    return response()->view('boards.errors.unauthorized', [
                        'message' => 'You do not have permission to access Boards.'
                    ], 403);
                }
            }
            
            // Get user data
            $user = DB::table('users')->where('id', $userId)->first();
            
            if (!$user) {
                return $this->redirectToLogin($request, 'User not found');
            }
            
            // Share user and claims with views
            view()->share('authUser', $user);
            view()->share('authClaims', $claims);
            view()->share('authToken', $token);
            
            // Also store in request for controllers
            $request->merge([
                'auth_user' => $user,
                'auth_claims' => $claims,
                'auth_token' => $token
            ]);
            
            return $next($request);
            
        } catch (Exception $e) {
            return $this->redirectToLogin($request, 'Authentication failed: ' . $e->getMessage());
        }
    }
    
    /**
     * Redirect to Angular login page
     */
    protected function redirectToLogin(Request $request, $message = null)
    {
        // Store intended URL for redirect after login
        session(['boards_intended_url' => $request->fullUrl()]);
        
        // Redirect to Angular login
        return redirect('/login');
    }
    
    /**
     * Check if user has a specific claim
     */
    public static function hasClaim($claims, $claim)
    {
        return in_array($claim, $claims);
    }
}
