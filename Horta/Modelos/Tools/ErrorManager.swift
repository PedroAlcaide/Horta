//
//  ErrorManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 08/06/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

class ErrorManager {
    
    
    static let ERROR1 = 1
    static let ERROR2 = 2
    static let ERROR3 = 3
    static let ERROR4 = 4
    static let ERROR5 = 5
    static let ERROR6 = 6
    static let ERROR7 = 7
    static let ERROR8 = 8
    
    
    
    
    
    func errorToIndex(index:Int)->UIAlertView{
        
        var alert : UIAlertView?
        
        switch (index){
            
        case 1:
           alert = Messenger.alertErrorEmailCadastrado()
            break
        case 2:
            alert = Messenger.alertErrorUserNotFound()
            break
        case 3:
            alert = Messenger.alertErrorUnconnectedCloudKit()
            break
        case 4:
            alert = Messenger.alertErrorCharactersPassword()
            break
        case 5:
            alert = Messenger.alertErrorDivergentFields()
            break
        case 6:
            alert = Messenger.alertErrorEmptyFields()
            break
        default:
            alert = Messenger.alertErrorUnknow()
            
        }
        
        return alert!
        
    }
    
    func errorsCloudKit(code: Int)->UIAlertView{
        
        return Messenger.alertErrorCloudKit(code)
        
    }
    
    
}