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
    func getUserWithPassword(user : User , password : String)
    func saveUserFinished(validate : Bool , user : User!)
    func getUserFinished(user : User! )
    func errorThrowed(error : NSError)
    func updateSuccesfull()
}
class UserDAOCloudKit: UserDAOProtocol{
    var container : CKContainer
    var publicDB : CKDatabase
    let NAME = "FULL_NAME"
    let EMAIL = "EMAIL"
    let PASSWORD = "PASSWORD"
    let USER = "USER"
    
    init() {
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
    }
    var delegate: UserDAOCKDelegate?
    

    func createUser(user: User){
        var predicate = NSPredicate(format: "EMAIL = %@", String(user.email!))
        
        var query = CKQuery(recordType: USER, predicate: predicate)
        publicDB.performQuery(query, inZoneWithID: nil, completionHandler: {
            (records: [AnyObject]!, error: NSError!) in
            
            if error != nil{
                self.delegate?.errorThrowed(error)
            } else {
                if records.count != 0 {
                    self.delegate?.saveUserFinished(false, user: nil)
                }
                else {
                    self.insertUser(user)
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
                self.delegate?.errorThrowed(error)
            } else {
                if records.count != 0 {
                    var record: CKRecord = records[0] as! CKRecord
                    var user : User = User(name: record.objectForKey("NAME") as! String, email: record.objectForKey("EMAIL") as! String, password: record.objectForKey("PASSWORD") as! String)
                    self.delegate?.getUserFinished(user)
                }
                else {
                    self.delegate?.getUserFinished(nil)
                }
                
            }
            
        })
        
    }
    func insertUser(user : User){
        var record = CKRecord(recordType: USER)
        record.setObject(user.name, forKey: NAME)
        record.setObject(user.email, forKey: EMAIL)
        record.setObject(user.password, forKey: PASSWORD)
        var modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord](arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        publicDB.saveRecord(record, completionHandler: { (record, error) in
            
            if error != nil {
                self.delegate?.errorThrowed(error)
                
            } else {
                
                self.delegate?.saveUserFinished(true, user: user)
            }
        })
        publicDB.addOperation(modify)
    }
    func updateUser(user : User){
        publicDB.fetchRecordWithID(user.recordID, completionHandler: { (record , error) -> Void in
            if error != nil {
                self.delegate?.updateSuccesfull()
            }
            else {
                self.delegate?.errorThrowed(error)
            }
        })
    }
}


