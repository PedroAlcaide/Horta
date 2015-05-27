//
//  ExceptionFactory.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

class ExceptionFactory {
    
    
    func getOutOfBoundsReason(reason:String)->OutOfBoundsException{
        
        return  OutOfBoundsException().initWithReason(reason) as! OutOfBoundsException
        
    }
    
    func getDivergenceReason(reason:String)->DivergenceException{
        
        return DivergenceException().initWithReason(reason) as! DivergenceException
        
    }
    
    func getEmptyFieldReason(reason:String)->EmptyFieldException{
        
        return EmptyFieldException().initWithReason(reason) as! EmptyFieldException
        
    }
    
    func getUserNotFound(reason:String)->UserNotFound{
        
        return UserNotFound().initWithReason(reason) as! UserNotFound
        
    }
    
    
}