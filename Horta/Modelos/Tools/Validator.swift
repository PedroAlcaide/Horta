//
//  Validator.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 02/06/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

class Validator {
    
    static func isAllFilledFields(fields:Array<UITextField>)->Bool{
        
        var isCorrect = true
        
        for textField in fields{
            
            var stringTrim = Tools().TRIM(textField.text)
            
            if (count(stringTrim) < 1){
                
                LayoutConfigurator.personalizeFieldError(textField)
                
            }
            
            
        }
        
        return isCorrect
    }
    
    static func compareEqualFields(field1:UITextField,field2:UITextField)->Bool{
        
        
        if (field1.text == field2.text){
            LayoutConfigurator.removeTextFieldError(field1)
            return true
        }
        
        LayoutConfigurator.personalizeFieldError(field1)
        LayoutConfigurator.personalizeFieldError(field2)
        return false
    }
    
    
    
}
