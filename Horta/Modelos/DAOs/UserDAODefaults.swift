//
//  UserDAODefaults.swift
//  Mini Challenge II
//
//  Created by Joao Sisanoski on 5/21/15.
//  Copyright (c) 2015 RJG. All rights reserved.
//

import Foundation
import CloudKit

@objc protocol UserDAODDelegate{
    optional
    func userSalveinDefaults()
}
class UserDAODefaults{
    let NAME = "NAME"
    let SURNAME = "SURNAME"
    let PASSWORD = "PASSWORD"
    let EMAIL = "EMAIL"
    let RECORDID = "RECORDID"
    var delegate :UserDAODDelegate?
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    
    func saveUser(user: User){
        userDefaults.setValue(user.email, forKey: EMAIL)
        userDefaults.setValue(user.name, forKey: NAME)
        userDefaults.setValue(user.surname, forKey: SURNAME)
        userDefaults.setValue(user.password, forKey: PASSWORD)
        userDefaults.setValue(user.recordID?.recordName, forKey: RECORDID)
        userDefaults.synchronize()
    }
    
    
    func getUserLogged(user : User) -> User{
        
        user.name = userDefaults.objectForKey(NAME) as? String
        user.surname = userDefaults.objectForKey(SURNAME) as? String
        user.email = userDefaults.objectForKey(EMAIL) as? String
        user.password = userDefaults.objectForKey(PASSWORD) as? String
        user.recordID = userDefaults.objectForKey(RECORDID) as? CKRecordID
        return user
    }
}