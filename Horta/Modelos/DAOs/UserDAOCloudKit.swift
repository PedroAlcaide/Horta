//
//  UserDAOCloudKit.swift
//  Mini Challenge II
//
//  Created by Joao Sisanoski on 5/21/15.
//  Copyright (c) 2015 RJG. All rights reserved.
//

import Foundation
import CloudKit

protocol UserDAOCKDelegate{


    func saveSuccefull(user:User)
    func errorThrowed(error : NSError)
    func getUserAuthenticated(ser:User)
    
/*
    func getUserWithPassword(user : User , password : String)
    func saveUserFinished(validate : Bool , user : User!)
    func getUserFinished(user : User! )
    
    func updateSuccesfull()

*/
}

class UserDAOCloudKit: UserDAO{
    var container : CKContainer
    var publicDB : CKDatabase
    let NAME = "Nome"
    let SURNAME = "Sobrenome"
    let EMAIL = "EMAIL"
    let PASSWORD = "PASSWORD"
    let USER = "USER"
    
    init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
    }
    var delegate: UserDAOCKDelegate?
    
    
    func consultUserEmail(newUser: User,aux:Int){
        
        var predicate = NSPredicate(format: "EMAIL = %@", String(newUser.email!))
        
        var query = CKQuery(recordType: USER, predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil, completionHandler: {
            (records: [AnyObject]!, error: NSError!) in
            
            if error != nil{
                //self.delegate?.errorThrowed(error)
            } else {
                if records.count != 0 {
                    //self.delegate?.saveUserFinished(false, user: nil)
                }
                else {
                    
                    switch (aux){
                    case 1:
                        self.saveUser(newUser)
                        break
                    default:
                        self.updateUser(newUser)
                    }
                    
                    
                }
                
            }
            
        })
        
    }
    
    func getUserWithEmail(email : String , password : String){
        var predicate = NSPredicate(format: "EMAIL = %@ && PASSWORD = %@", email , password)
        
        var query = CKQuery(recordType: USER, predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil, completionHandler: {
            (records: [AnyObject]!, error: NSError!) in
            
            if error != nil{
                //self.delegate?.errorThrowed(error)
            } else {
                if records.count != 0 {
                    
                    // retorno Login Efetuado
                    
                    
                    /*
                    var record: CKRecord = records[0] as! CKRecord
                    var user : User = User(name: record.objectForKey("NAME") as! String, email: record.objectForKey("EMAIL") as! String, password: record.objectForKey("PASSWORD") as! String)
                    //self.delegate?.getUserFinished(user) */
                }
                else {
                    
                    // usuário ou senha incorretos
                    //self.delegate?.getUserFinished(nil)
                }
                
            }
            
        })
        
    }

    
    
    
    func saveUser(user : User){
        var record = CKRecord(recordType: USER)
        record.setObject(user.name, forKey: NAME)
        record.setObject(user.surname, forKey: SURNAME)
        record.setObject(user.email, forKey: EMAIL)
        record.setObject(user.password, forKey: PASSWORD)
        var modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord](arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        publicDB.saveRecord(record, completionHandler: { (record, error) in
            
            if error != nil {
                self.delegate?.errorThrowed(error)
                
            } else {
                user.recordID = record.recordID
                self.delegate?.saveSuccefull(user)
                //self.delegate?.saveUserFinished(true, user: user)
            }
        })
        publicDB.addOperation(modify)
    }
    
    
    func updateUser(user : User){
        
        
        publicDB.fetchRecordWithID(user.recordID, completionHandler: { (record, error) -> Void in
            
            
            record.setObject(user.name, forKey: self.NAME)
            record.setObject(user.surname, forKey: self.SURNAME)
            record.setObject(user.email, forKey: self.EMAIL)
            record.setObject(user.password, forKey: self.PASSWORD)
            
            if  error != nil{
                
                self.delegate?.saveSuccefull(user)
                //self.delegate?.saveUserFinished(true, user: user)
                
                
            }else{
                self.delegate?.errorThrowed(error)
            }
            
        })
        
    }
    
    func getUser(email:String, password:String){
        
        var predicate = NSPredicate(format: "\(EMAIL) = %@ && \(PASSWORD) = %@", email , password)
        var query = CKQuery(recordType: USER, predicate: predicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            
            if  (error == nil){
                
                if  (results.count > 0){
                    
                    var queryResult = results[0] as! CKRecord
                    var user = UserManager().creatuser()
                    
                    user.recordID = queryResult.recordID
                    user.name = queryResult.objectForKey(self.NAME) as? String
                    user.surname = queryResult.objectForKey(self.SURNAME) as? String
                    user.email = queryResult.objectForKey(self.EMAIL) as? String
                    user.password = queryResult.objectForKey(self.PASSWORD) as? String
                    
                    self.delegate?.getUserAuthenticated(user)
                    
                }else{
                    print("Usuario nao localizado")
                }
                
            }else{
                self.delegate?.errorThrowed(error)
            }
            
            
        }
        
    }
    
}
    



