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
    func errorCloudKitThrowed(error : NSError)
    func getUserAuthenticated(user:User)
    func othersErrosThrowed(errorIndex:Int)
    
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
        
        let predicate = NSPredicate(format: "EMAIL = %@", String(newUser.email!))
        
        let query = CKQuery(recordType: USER, predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil, completionHandler: {
            (records: [CKRecord]?, error: NSError?) in
            
            if error != nil{
                // DEU ERRO NO CLOUD KIT
                self.delegate?.errorCloudKitThrowed(error!)
            } else {
                if records!.count != 0 {
                    // DADOS JA CADASTRADOS
                    self.delegate?.othersErrosThrowed(ErrorManager.ERROR1)
                    //print("usuario ja existe")
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
    /*
    func getUserWithEmail(email : String , password : String){
        var predicate = NSPredicate(format: "EMAIL = %@ && PASSWORD = %@", email , password)
        
        var query = CKQuery(recordType: USER, predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil, completionHandler: {
            (records: [AnyObject]!, error: NSError!) in
            
            if error != nil{
               // self.delegate?.errorThrowed(error)
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

    */
    
    
    func saveUser(user : User){
        let record = CKRecord(recordType: USER)
        record.setObject(user.name, forKey: NAME)
        record.setObject(user.surname, forKey: SURNAME)
        record.setObject(user.email, forKey: EMAIL)
        record.setObject(user.password, forKey: PASSWORD)
        let modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord](arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        publicDB.saveRecord(record, completionHandler: { (record, error) in
            
            if error != nil {
                // ERROR NO CLOUD KIT
                self.delegate?.errorCloudKitThrowed(error!)
                
            } else {
                // USUARIO SALVO
                user.recordID = record!.recordID
                //print("usuario salvo")
                self.delegate?.saveSuccefull(user)
                
            }
        })
        publicDB.addOperation(modify)
    }
    
    
    func updateUser(user : User){
        
        
        publicDB.fetchRecordWithID(user.recordID!, completionHandler: { (record, error) -> Void in
            
            
            record!.setObject(user.name, forKey: self.NAME)
            record!.setObject(user.surname, forKey: self.SURNAME)
            record!.setObject(user.email, forKey: self.EMAIL)
            record!.setObject(user.password, forKey: self.PASSWORD)
            
            if  error != nil{
                
                // ERROR CLOUD KIT
                
                self.delegate?.errorCloudKitThrowed(error!)
                
                
                
                
            }else{
                
                // USUARIO ATUALIZADO
                
                self.delegate?.saveSuccefull(user)
            }
            
        })
        
    }
    
    func getUser(email:String, password:String){
        
        let predicate = NSPredicate(format: "\(EMAIL) = %@ && \(PASSWORD) = %@", email , password)
        let query = CKQuery(recordType: USER, predicate: predicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            
            if  (error == nil){
                
                if  (results!.count > 0){
                    
                    // USUARIO LOCALIZADO
                    
                    for result in results!{
                        
                        let queryResult = result
                        let user = UserManager().creatuser()
                        
                        user.recordID = queryResult.recordID
                        user.name = queryResult.objectForKey(self.NAME) as? String
                        user.surname = queryResult.objectForKey(self.SURNAME) as? String
                        user.email = queryResult.objectForKey(self.EMAIL) as? String
                        user.password = queryResult.objectForKey(self.PASSWORD) as? String
                        
                        self.delegate?.getUserAuthenticated(user)

                    }
                    
                    
                }else{
                    // USUARIO NAO LOCALIZADO
                    self.delegate?.othersErrosThrowed(ErrorManager.ERROR2)
                    //print("Usuario nao localizado")
                }
                
            }else{
                
                // ERROR CLOUD KIT
                
                self.delegate?.errorCloudKitThrowed(error!)
            }
            
            
        }
        
    }
    
}
    



