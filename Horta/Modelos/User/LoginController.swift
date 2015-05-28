//
//  LoginController.swift
//  Horta
//
//  Created by Felipe R. de Luca on 5/27/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

//------------------------------------------------------------------------------------------
class LoginController {
    private let usuarioLogado: Bool;
    
    
    init(){
        usuarioLogado = false;
    }
    //------------------------------------------------------------------------------------------
    final func conectarUsuario( facebook: Bool, google: Bool, nome: String?, senha: String? ) -> ( nome: String?, email: String? ){
        
        var nomeUsuario : String?;
        var emailUsuario: String?;
        
        if facebook {
            // Conectar usando facebook
        }
        else if google {
            // Conectar usando gmail, google+
            
        }
        else if ( nome != nil && senha != nil ) {
            // Conectar através do próprio aplicativo
        }
        
        
        return ( nomeUsuario, emailUsuario );
    }
    //------------------------------------------------------------------------------------------
    
}
//------------------------------------------------------------------------------------------
