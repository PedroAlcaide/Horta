//
//  LayoutConfigurator.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 02/06/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import UIKit

class LayoutConfigurator {
    
    static func personalizeFieldError(textField:UITextField){
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            textField.layer.cornerRadius = 8.0
            textField.layer.masksToBounds = true
            textField.layer.borderColor = UIColor.redColor().CGColor
            textField.layer.borderWidth = 2.0
        })
        
    }
    
    static func removeTextFieldError(textField:UITextField){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            textField.layer.borderWidth = 0
            textField.layer.masksToBounds = false
        })
        
    }
    
    
}