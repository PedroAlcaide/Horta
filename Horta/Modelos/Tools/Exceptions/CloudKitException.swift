//
//  CloudKitException.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

class CloudKitException : NSException{
    
    func returnStringToError(error:NSError)->String{
        var exceptionName:String
        
        switch (error.code){
        case 3,4:
            exceptionName = "InternetProblem"
            break
        case 6:
            exceptionName = "ServiceUnavailable"
            break
        case 7:
            exceptionName = "RequestRateLimited"
            break;
        default:
            exceptionName = "InternalError"
            
        }
        return exceptionName
    }
    
    
}
