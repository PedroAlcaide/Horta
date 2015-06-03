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
    
    func errorThrowedValidator(error:String)
    func iCloudAccountAvaliable()
    
    
}

class Validator {
  
    var delegate : ValidatorDelegate?
    
    
    func iCloudAccountValidation(){
      
        CKContainer.defaultContainer().accountStatusWithCompletionHandler { (accountStatus, error) -> Void in
            
            if (accountStatus == CKAccountStatus.NoAccount){
                print("nao logado cloud kit")
                self.delegate?.errorThrowedValidator("Sign in to your iCloud account to write records. On the Home screen, launch Settings, tap iCloud, and enter your Apple ID. Turn iCloud Drive on. If you don't have an iCloud account, tap Create a new Apple ID.")
                
                
            }else{
                print("logado clodkit")
                self.delegate?.iCloudAccountAvaliable()
            }
            
            
        }
    }
    /*
    -(void)icloudAccountValidation{
    //VERIFICA SE O USUÁRIO NÃO ESTÁ LOGADO NO ICLOUD
    
    [[CKContainer defaultContainer] accountStatusWithCompletionHandler:^(CKAccountStatus accountStatus, NSError *error) {
    if (accountStatus == CKAccountStatusNoAccount) {
    [self performSelectorOnMainThread:@selector(showUnconnectedIcloud) withObject:nil waitUntilDone:NO];
    }
    else {
    // Insert your just-in-time schema code here
    }
    }];
    
    }
    
    -(void)showUnconnectedIcloud{
    [alertLoading close];
    UnconnectedIcloud *exception = [ExceptionFactory getUnconnectedIcloudReason:@"Sign in to your iCloud account to write records. On the Home screen, launch Settings, tap iCloud, and enter your Apple ID. Turn iCloud Drive on. If you don't have an iCloud account, tap Create a new Apple ID."];
    
    [self showAlertWithTitle:exception.name message:exception.reason];
    }
    
    */
    
    
    func validateDataSignUp(fields:Array<UITextField>)->Bool{
        
        
        
        
        if (self.isAllFilledFields(fields) == true){
            
            if (self.compareEqualFields(fields[2], field2: fields[3]) && self.compareEqualFields(fields[4], field2: fields[5])){
                
                if (self.checkPassword(fields[4]) == false){
                    
                    self.delegate?.errorThrowedValidator("Requerido 6 caracteres")
                    return false
                    
                }
                
            }else{
                self.delegate?.errorThrowedValidator("Campos Divergentes")
                return false
            }
            
            
        }else{
            self.delegate?.errorThrowedValidator("Campos não preenchidos")
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
