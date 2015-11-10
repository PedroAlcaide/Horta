//
//  UserManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 26/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation


protocol UserManagerDelegate{
    
    
    func errorCloudKitThrowed(error:NSError)
    func userOperationSucessfull(user:User)
    func othersErrosThrowed(errorIndex:Int)
    
}

class UserManager : UserDAOCKDelegate{
    
    var daoCloudKit : UserDAOCloudKit
    var daoDefaults : UserDAODefaults
    var delegate :UserManagerDelegate?
    
    init(){
        
        daoCloudKit = DaoFactory().getUserDAOCloudKit()
        
        daoDefaults = DaoFactory().getUserDAODefaults()
        daoCloudKit.delegate = self
        
    }
    
    
    func creatuser()->User{
        
        return User()
        
    }
    
    func rodaScript(user:User){
        daoCloudKit.saveUser(user)
    }
    
    func saveUser(user:User){
        
        //daoCloudKit.consultUserEmail(user, aux: 1)
        daoCloudKit.saveUser(user)
    }
    
    func editUser(user:User){
        
        daoCloudKit.consultUserEmail(user, aux: 2)
        
    }
    
    func toAuthentication(email:String, password:String){
        
        daoCloudKit.getUser(email, password: password)
        
    }
    
    
    func getUserLogged()->User?{
        
        let user = daoDefaults.getUserLogged(self.creatuser())
        if  (user == nil){
            return nil
        }
        
        //print( user!.email )
        return user
        
    }
    
    // UserDAOCloudKit Delegate
    
    func saveSuccefull(user: User) {
        daoDefaults.saveUser(user)
        ////print("usuario salvo daoDefault")
        self.delegate?.userOperationSucessfull(user)
        
    }
    
    func errorCloudKitThrowed(error: NSError) {
        self.delegate?.errorCloudKitThrowed(error)
    }
    
    func getUserAuthenticated(user:User){
        daoDefaults.saveUser(user)
        self.delegate?.userOperationSucessfull(user)
    }
    
    func othersErrosThrowed(errorIndex:Int){
        self.delegate?.othersErrosThrowed(errorIndex)
    }
    
    
    
    func logoutUser(){
        daoDefaults.logoutUser()
    }
    
}