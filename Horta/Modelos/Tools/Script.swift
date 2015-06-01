//
//  Script.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 29/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

class Script {
    
    func generateUsersData(quant:Int){
        
        for (var i = 0;i < quant;i++){
            
            var user = User()
            user.name = "name\(i)"
            user.surname = "surname\(i)"
            user.email = "email\(i)@gmail.com"
            user.password = "password\(i)"
            
            UserManager().rodaScript(user)
        }
        
    }
    
    
    
}
