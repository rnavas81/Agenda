<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AuthController extends Controller
{
    // Funcion de login
    public function login(Request $request)
    {
        // TODO: Controlar el numero de intentos de acceso desde una ip

        $loginData = $request->validate([
            'username' => 'required',
            'password' => 'required'
        ]);
        if (!auth()->attempt($loginData)) {
            //return response(['message' => 'Login incorrecto. Revise las credenciales.'], 400);
            return response()->noContent(403);
        }
        $user = auth()->user();
        $accessToken = auth()->user()->createToken('authToken')->accessToken;
        return response()->json(['user' => $user, 'token' => $accessToken], 200);
    }
    public function logout(Request $request)
    {
        $request->user()->token()->revoke();
        return response()->noContent(200);
    }
}
