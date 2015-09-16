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
    func receiveProducts(productArray : Array<Product>)
    func operationSucessfull()
    
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
    let HORTA = "HortaID"
    
    
    init(){
        
        container = CKContainer.defaultContainer()
        publicDB = container.publicCloudDatabase
        
    }
    
    func saveProduct(newProduct:Product, gardenID : CKReference){
        
        var record = CKRecord(recordType: PRODUCT)
        record.setObject(newProduct.name, forKey: NAME)
        record.setObject(newProduct.description, forKey: DESCRIPTION)
        record.setObject(newProduct.photo, forKey: PHOTO)
        record.setObject(newProduct.quantity, forKey: QUANTITY)
        record.setObject(gardenID, forKey: HORTA)
        
        var modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord] (arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicDB.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if error != nil{
                // HOUVE ALGUM ERRO
                
                self.delegate?.errorThrowed(error)
            }else{
                
                // Gravou com sucesso
                
                self.delegate?.operationSucessfull()
            }
        })
        
        publicDB.addOperation(modify)
        
    }
    
    
    func updateProduct(product :Product){
        
        publicDB.fetchRecordWithID(product.recordID, completionHandler: { (record, error) -> Void in
            
            if  error != nil{
                
                self.delegate?.errorThrowed(error)
                
            }else{
                
                // Grabou com sucesso
                
                self.delegate?.operationSucessfull()
            }
        })
        
    }
    
    func getAllProductsInGarden(gardenReference : CKReference){
        
        var predicate = NSPredicate(format: "\(HORTA) = %@", gardenReference)
        
        var query = CKQuery(recordType: PRODUCT, predicate: predicate)
        
        publicDB.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            
            
            if  (error == nil){
                
                
                if  (results.count > 0){
                    
                    var productsArray : Array<Product> = self.transformArrayProducts(results)
                    self.delegate?.receiveProducts(productsArray)
                    
                }
                
                
            }
            
        }
        
    }
    
    func transformArrayProducts(results : AnyObject) -> Array<Product>{
        
        var productArray : Array<Product> = []
        
        for var i = 0 ;i < results.count;++i{
            
            var product = ProductManager().creatProduct()
            var record = results[0] as! CKRecord
            
            product.recordID = record.recordID
            product.name = record.objectForKey(self.NAME) as? String
            product.description = record.objectForKey(self.DESCRIPTION) as? String
            product.quantity = record.objectForKey(self.QUANTITY) as? Int
            product.photo = record.objectForKey(self.PHOTO) as? String
            product.gardenID = record.objectForKey(self.HORTA) as? CKReference
            
            productArray.append(product)
            
        }
        /*
        for record in results{
            
            var product = ProductManager().creatProduct()
            
            product.recordID = record.recordID
            product.name = record.objectForKey(self.NAME) as? String
            product.description = record.objectForKey(self.DESCRIPTION) as? String
            product.quantity = record.objectForKey(self.QUANTITY) as? Int
            product.photo = record.objectForKey(self.PHOTO) as? String
            product.gardenID = record.objectForKey(self.HORTA) as? CKReference
            
            productArray.append(product)
            
            
            
        }*/
        
        return productArray
    }
    
    
}