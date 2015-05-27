//
//  User.swift
//  Mini Challenge II
//
//  Created by Joao Sisanoski on 5/21/15.
//  Copyright (c) 2015 RJG. All rights reserved.
//

import UIKit
import CloudKit
class User {
    var name: String?
    var surname: String?
    var email: String?
    var password: String?
    var recordID: CKRecordID?
    
    init(){
        self.name = nil
        self.surname = nil
        self.email = nil
        self.password = nil
        
    }
    init(name : String, surname : String , email : String , password : String){
        self.name = name
        self.surname = surname
        self.email = email
        self.password = password
    }
}

//#import <Foundation/Foundation.h>
//#import <CloudKit/CloudKit.h>x
//
//@interface User : NSObject
//
////REQUIRED
//@property (nonatomic) CKRecordID *idUser;
//@property (nonatomic) NSString *name;
//@property (nonatomic) NSString *email;
//@property (nonatomic) NSString *password;
//
//
////OPTIONAL
//@property (nonatomic) UIImage *photo;
//@property (nonatomic) NSString *country;
//@property (nonatomic) NSString *userDescription;
