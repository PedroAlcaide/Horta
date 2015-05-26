//
//  UserManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 26/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

class UserManager : UserDAOCKDelegate{
    
    var daoCloudKit : UserDAOCloudKit
    var daoDefaults : UserDAODefaults
    
    init(){
        
        daoCloudKit = DaoFactory().getUserDAOCloudKit()
        daoDefaults = DaoFactory().getUserDAODefaults()
        
    }
    
    
    func creatuser()->User{
        
        return User()
        
    }
    
    func saveUser(user:User){
        
        daoCloudKit.createUser(user)
        
    }
    
    
    func getUserLogged(user:User)->User{
        
       return daoDefaults.getUserLogged(user)
        
    }
    
    // UserDAOCloudKit Delegate
    
    func saveSuccefull(user: User) {
        daoDefaults.saveUser(user)
        
    }
    
    
    
}