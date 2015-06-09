//
//  Validator.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 02/06/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit


protocol ValidatorDelegate{
    
    func errorThrowedValidator(errorIndex:Int)
    func iCloudAccountAvaliable()
    
    
    
}

class Validator {
  
    var delegate : ValidatorDelegate?
    
    
    func iCloudAccountValidation(){
      
        CKContainer.defaultContainer().accountStatusWithCompletionHandler { (accountStatus, error) -> Void in
            
            if (accountStatus == CKAccountStatus.NoAccount){
                // DISPOSITIVO NAO LOGADO NO CLOUD KIT
                
                self.delegate?.errorThrowedValidator(ErrorManager.ERROR3)
                
                
            }else{
                // DISPOSITIVO LOGADO NO CLOUD KIT
                self.delegate?.iCloudAccountAvaliable()
            }
            
            
        }
    }
    
    func validateDataSignUp(fields:Array<UITextField>)->Bool{
        
        
        
        
        if (self.isAllFilledFields(fields) == true){
            
            if (self.compareEqualFields(fields[2], field2: fields[3]) && self.compareEqualFields(fields[4], field2: fields[5])){
                
                if (self.checkPassword(fields[4]) == false){
                    
                    self.delegate?.errorThrowedValidator(ErrorManager.ERROR4)
                    return false
                    
                }
                
            }else{
                self.delegate?.errorThrowedValidator(ErrorManager.ERROR5)
                return false
            }
            
            
        }else{
            self.delegate?.errorThrowedValidator(ErrorManager.ERROR6)
            return false
            
        }
        return true
        
    }
    
    func validateDataSignIn(fields:Array<UITextField>)->Bool{
        
        
        if  (self.isAllFilledFields(fields) == true){
            
            if (self.checkPassword(fields[1])  != true){
                
                self.delegate?.errorThrowedValidator(ErrorManager.ERROR4)
                return false
                
            }
            
            
        }else{
            self.delegate?.errorThrowedValidator(ErrorManager.ERROR6)
            return false
        }
        
        return true
        
    }

    
    
    func isAllFilledFields(fields:Array<UITextField>)->Bool{
        
        var isCorrect = true
        
        for textField in fields{
            
            var stringTrim = Tools().TRIM(textField.text)
            
            if (count(stringTrim) < 1){
                
                LayoutConfigurator.personalizeFieldError(textField)
                
                isCorrect = false
                
                
            }else{
                LayoutConfigurator.removeTextFieldError(textField)
            }
            
            
        }
        
        return isCorrect
    }
    
    func compareEqualFields(field1:UITextField,field2:UITextField)->Bool{
        
        
        if (field1.text == field2.text){
            LayoutConfigurator.removeTextFieldError(field1)
            return true
        }
        
        LayoutConfigurator.personalizeFieldError(field1)
        LayoutConfigurator.personalizeFieldError(field2)
        return false
    }
    
    func checkPassword(textField:UITextField)->Bool{
        
        if  (count(textField.text) < 6){
            LayoutConfigurator.personalizeFieldError(textField)
            return false
            
        }else{
            LayoutConfigurator.removeTextFieldError(textField)
            return true
        }
        
    }
    
    
    
}
