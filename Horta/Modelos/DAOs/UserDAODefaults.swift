//
//  UserDAODefaults.swift
//  Mini Challenge II
//
//  Created by Joao Sisanoski on 5/21/15.
//  Copyright (c) 2015 RJG. All rights reserved.
//

import Foundation
@objc protocol UserDAODDelegate{
    optional
    func faznada()
}
class UserDAODefaults{
    let NAME = "NAME"
    let PASSWORD = "PASSWORD"
    let EMAIL = "EMAIL"
    let RECORDID = "RECORDID"
    var delegate :UserDAODDelegate?
    let userDefaults = NSUserDefaults.standardUserDefaults()
    func saveUser(user: User){
        userDefaults.setValue(user.email, forKey: EMAIL)
        userDefaults.setValue(user.name, forKey: NAME)
        userDefaults.setValue(user.password, forKey: PASSWORD)
        userDefaults.setValue(user.recordID?.recordName, forKey: RECORDID)
        
    }
    func getUserLogged() -> User{
        let nameSave : String =  userDefaults.objectForKey(NAME) as! String
        let emailSave : String = userDefaults.objectForKey(EMAIL) as! String
        let passwordSave : String = userDefaults.objectForKey(PASSWORD) as! String
        var user : User = User(name: nameSave, email: emailSave, password: passwordSave)
        return user
    }
}