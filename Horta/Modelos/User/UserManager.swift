//
//  UserManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 26/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

class UserManager {
    
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
    
}