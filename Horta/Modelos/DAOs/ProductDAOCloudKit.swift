//
//  ProductDAOCloudKit.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

protocol ProductDAOCKDelegate{
    
    func errorThrowed(error : NSError)
}

class ProductDAOCloudKit{
    
    var container : CKContainer
    var publicDB : CKDatabase
    var delegate : ProductDAOCKDelegate?
    let NAME = "Nome"
    let DESCRIPTION = "Descricao"
    let QUANTITY = "Quantidade"
    let PHOTO = "Foto"
    let PRODUCT = "Product"
    
    
    init(){
        
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        
    }
    
    func saveProduct(newProduct:Product){
        
        var record = CKRecord(recordType: PRODUCT)
        record.setObject(newProduct.name, forKey: NAME)
        record.setObject(newProduct.description, forKey: DESCRIPTION)
        record.setObject(newProduct.photo, forKey: PHOTO)
        record.setObject(newProduct.quantity, forKey: QUANTITY)
        
        var modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord] (arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicDB.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if error != nil{
                self.delegate?.errorThrowed(error)
            }
        })
        publicDB.addOperation(modify)
        
    }
    
    
    func updateProduct(product :Product){
        
        publicDB.fetchRecordWithID(product.recordID, completionHandler: { (record, error) -> Void in
            
            if  error != nil{
                
                self.delegate?.errorThrowed(error)
                
            }
        })
        
    }
    
    
}