//
//  Messenger.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 08/06/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import UIKit

class Messenger {
    
    
    static func alertErrorCloudKit(code : Int)->UIAlertView{
        
        var alert : UIAlertView?
        let title = "Erro de requisição"
        switch (code){
        
        case 3,4:
           alert = UIAlertView(title: title, message: "Sem conexão com a internet", delegate: nil, cancelButtonTitle: "OK")
            break
        case 6:
            alert = UIAlertView(title: title, message: "Serviço indisponivel no momento, tente novamente em segundos", delegate: nil, cancelButtonTitle: "OK")
            break
        case 7:
            alert = UIAlertView(title: title, message: "Tempo limite de conexão", delegate: nil, cancelButtonTitle: "OK")
            break;
        default:
            alert = UIAlertView(title: title, message: "Erro interno, tente novamente em segundos", delegate: nil, cancelButtonTitle: "OK")
            
        }
        
        return alert!
        
    }
    
    static func alertErrorEmailCadastrado()->UIAlertView{
        
       let alert = UIAlertView(title: "Erro ao cadastrar", message: "Erro, E-mail já cadastrado.", delegate: nil, cancelButtonTitle: "OK")
        
        return alert
        
    }
    
    static func alertErrorUserNotFound()->UIAlertView{
        
        let alert = UIAlertView(title: "Erro no login", message: "Usuario não localizado", delegate: nil, cancelButtonTitle: "OK")
        
        return alert
        
        
    }
    
    static func alertErrorUnconnectedCloudKit()->UIAlertView{
        
        let alert = UIAlertView(title: "Erro", message: "É necessário que o dispositivo esteja logado no cloudKit", delegate: nil, cancelButtonTitle: "OK")
        
        return alert

        
    }
    
    static func alertErrorCharactersPassword()->UIAlertView{
        
        let alert = UIAlertView(title: "Erro", message: "A senha requer no mínimo 6 caracteres", delegate: nil, cancelButtonTitle: "OK")
        
        return alert
        
    }
    
    static func alertErrorDivergentFields()->UIAlertView{
        
        let alert = UIAlertView(title: "Erro", message: "Campos Divergentes", delegate: nil, cancelButtonTitle: "OK")
        
        return alert
        
    }
    
    static func alertErrorEmptyFields()->UIAlertView{
        
        let alert = UIAlertView(title: "Erro", message: "Campos não preenchidos", delegate: nil, cancelButtonTitle: "OK")
        
        return alert
        
    }
    
    
    static func alertErrorUnknow()->UIAlertView{
        
        let alert = UIAlertView(title: "Erro", message: "Erro desconhecido", delegate: nil, cancelButtonTitle: "OK")
        
        return alert
    }
    
    
    
    
}
