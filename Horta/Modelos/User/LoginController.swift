//
//  LoginController.swift
//  Horta
//
//  Created by Felipe R. de Luca on 5/27/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//  
//  Controlador de login do usuário.

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

//------------------------------------------------------------------------------------------
class LoginController {
    private var userLogged: Int? {
        // 0: não conectado
        // 1: app
        // 2: facebook
        // 3: google
        didSet {
            closeAllLoggedAccounts(); // Não deixa que haja mais de uma conta ativa ao mesmo tempo
        }
    }
    
    private let facebookLoginManager = FBSDKLoginManager();
    private var facebookLoginResult  = FBSDKLoginManagerLoginResult();
    private var facebookError        = NSError();
    private var facebookLoginHandler: FBSDKLoginManagerRequestTokenHandler?;
    private var facebookConnectionStatus: Int? = 0 // 0: recusado, 1: cancelado, 2: conectado

    private var nomeUsuario : String?;
    private var emailUsuario: String?;
    private var userIsAdmin : Bool;
    
    init(){
//        println( "Conectar inicializado" );
        nomeUsuario   = nil;
        emailUsuario  = nil;
        userLogged    = 0;
        userIsAdmin   = false;
    }
    //------------------------------------------------------------------------------------------
    final func loginFacebook() -> ( nome: String?, email: String? ) {

        userLogged = 0; // desconecta todas as conexoes
        facebook();
        
        return ( nomeUsuario, emailUsuario );
    }
    //------------------------------------------------------------------------------------------
    private func closeAllLoggedAccounts() -> () {

        facebookLoginManager.logOut();
        
    }
    //------------------------------------------------------------------------------------------
    private func facebook() -> Bool {
        facebookLoginManager.logInWithReadPermissions( ["public_profile"], handler: facebookLoginHandler );
        
//        loginFacebook.
//        [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//            if (error) {
//                // Process error
//            } else if (result.isCancelled) {
//                // Handle cancellations
//            } else {
//                // If you ask for multiple permissions at once, you
//                // should check if specific permissions missing
//                if ([result.grantedPermissions containsObject:@"email"]) {
//                    // Do work
//                }
//            }
//        }];
        
        
        return false;
    }
}
//------------------------------------------------------------------------------------------
