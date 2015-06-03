//
//  UserManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 26/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation


protocol UserManagerDelegate{
    
    
    func errorThrowed(error:NSError)
    func userSaveSucessfull()
    
}

class UserManager : UserDAOCKDelegate{
    
    var daoCloudKit : UserDAOCloudKit
    var daoDefaults : UserDAODefaults
    var delegate :UserManagerDelegate?
    
    init(){
        
        daoCloudKit = DaoFactory().getUserDAOCloudKit()
        daoDefaults = DaoFactory().getUserDAODefaults()
        
    }
    
    
    func creatuser()->User{
        
        return User()
        
    }
    
    func rodaScript(user:User){
        daoCloudKit.saveUser(user)
    }
    
    func saveUser(user:User){
        daoCloudKit.consultUserEmail(user, aux: 1)
        //daoCloudKit.saveUser(user)
    }
    
    func editUser(user:User){
        
        daoCloudKit.consultUserEmail(user, aux: 2)
        
    }
    
    func toAuthentication(email:String, password:String){
        
        daoCloudKit.getUser(email, password: password)
        
    }
    
    
    func getUserLogged()->User{
        
        return daoDefaults.getUserLogged(self.creatuser())
        
    }
    
    // UserDAOCloudKit Delegate
    
    func saveSuccefull(user: User) {
        daoDefaults.saveUser(user)
        self.delegate?.userSaveSucessfull()
        
    }
    
    func errorThrowed(error: NSError) {
        self.delegate?.errorThrowed(error)
    }
    
    func getUserAuthenticated(user:User){
        daoDefaults.saveUser(user)
    }
    
    
    
}