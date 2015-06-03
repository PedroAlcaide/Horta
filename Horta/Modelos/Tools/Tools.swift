//
//  Tools.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 28/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

class Tools {
    
    func recordIDToReference(recordID:CKRecordID!)->CKReference{
        
        return CKReference(recordID: recordID, action: CKReferenceAction.None)
        
    }
    
    
    func TRIM(oldSrting:String)-> String{
        
        var trimString : String = oldSrting.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
       return trimString
        
    }
    
}


