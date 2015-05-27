//
//  UserNotFound.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

class UserNotFound : NSException{
    
    
    func initWithReason(reason:String)->NSException{
        
        return NSException(name: "UserNotFound", reason: reason, userInfo: nil)
        
    }
    
    
}