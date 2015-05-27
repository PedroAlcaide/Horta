//
//  File.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 25/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

 protocol UserDAO{
    
    func saveUser(user:User)
    func updateUser(user : User)
    //func saveUser(user:User, urlPhoto:NSURL)
    //func createUser(newUser :User)
    //func getUserWithEmail(email:String, password:String)
    //func getUserWithId(iduser:CKRecord)
   
    
    
    
}