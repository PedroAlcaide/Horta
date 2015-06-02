//
//  LoginController.swift
//  Horta
//
//  Created by Felipe R. de Luca on 5/27/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//  
//  Controlador de login do usuário.

import Foundation
//import FBSDKCoreKit
//import FBSDKLoginKit

//------------------------------------------------------------------------------------------
class LoginController {
    static let sharedInstance = LoginController(); // Singleton
    
    // 0: não conectado
    // 1: app
    // 2: facebook
    // 3: google
    private var userLogged: Int?;
    
    private var classId: Int = 0; // Id da instancia atual da classe
    
    private let facebookLoginManager = FBSDKLoginManager();
    private var facebookConnectionStatus: Int? = 0 // 0: recusado, 1: cancelado, 2: conectado

    private var nomeUsuario : NSString!;
    private var emailUsuario: NSString!;
    private var userIsAdmin : Bool;
//    private var userFBPicture: FBSDKProfilePictureView = FBSDKProfilePictureView?;//UIImage = UIImage();
    
    init(){
//        println( "Conectar inicializado" );
        FBSDKProfile.enableUpdatesOnAccessTokenChange( true );
        classId      += 1;
        nomeUsuario   = "";
        emailUsuario  = "";
        userLogged    = 0;
        userIsAdmin   = false;
        
        println("Class id: \(classId)");
    }
    //------------------------------------------------------------------------------------------
    final func getUserStatus() -> Int {
        return self.userLogged!;
    }
    //------------------------------------------------------------------------------------------
    final func getUserPicture() -> UIView? {
//        println("recuperando imagem");
//        if self.userLogged == 2 {
//           FBSDKProfilePictureView().profileID = FBSDKProfile.currentProfile().userID;
//            return FBSDKProfilePictureView();
//        }
        
        return nil;
    }
    //------------------------------------------------------------------------------------------
    final func getUserName() -> String? {
        if self.userLogged == 2 {
            println( "Get facebook user name: \(FBSDKProfile.currentProfile().name)" );
            self.nomeUsuario = FBSDKProfile.currentProfile().name;
        }

        return nomeUsuario! as String;
    }
    //------------------------------------------------------------------------------------------
    final func getUserEmail() -> String? {
//        if self.userLogged == 2 {
//            println( "Get facebook user email: \(FBSDKProfile.currentProfile())" );
//            self.nomeUsuario = FBSDKProfile.currentProfile().name;
//        }

        return emailUsuario! as String;
    }
    //------------------------------------------------------------------------------------------
    final func loginFacebook() -> ( nome: String?, email: String? ) {

        self.userLogged   = 0;
        self.nomeUsuario  = "";
        self.emailUsuario = "";
        facebook();
        
        return ( nomeUsuario! as String, emailUsuario! as String );
    }
    //------------------------------------------------------------------------------------------
    func logout() {
        println( "User logged out." );
        userLogged = 0;
        closeAllLoggedAccounts();
    }
    //------------------------------------------------------------------------------------------
    private func closeAllLoggedAccounts() -> () {

        println( "Desconectando todas as contas..." );
        facebookLoginManager.logOut();
                
    }
    //------------------------------------------------------------------------------------------
    private func facebook() -> Bool {
        println( "conectando com Facebook..." );
        
        // Usuário não está logado
        if FBSDKAccessToken.currentAccessToken() == nil {
        
            println( "conectando usuário com o Facebook..." );
            
            facebookLoginManager.logInWithReadPermissions( ["public_profile"], handler: {
                (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> () in

                if error != nil {
                    println( "\(error.description)" );
                }
                
                if result.grantedPermissions != nil {
                    if  result.grantedPermissions!.contains( "public_profile" ) {
                        self.userLogged  = 2;
                    }
                }

            })
        }
        else {
            self.userLogged = 2;
            println( "Conectado com o Facebook. \(self.userLogged)" );
        }
        
        return false;
    }
}
//------------------------------------------------------------------------------------------
