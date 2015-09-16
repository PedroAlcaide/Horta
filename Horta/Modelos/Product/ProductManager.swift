//
//  ProductManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

protocol ProductManagerDelegate{
    
    func errorThrowed(error:NSError)
    func receiveProducts(productArray:Array<Product>)
    func operationSucessfull()
    
}

class ProductManager : ProductDAOCKDelegate {
    
    var daoCloudKit : ProductDAOCloudKit
    var delegate : ProductManagerDelegate?
    
    
    init(){
        
        daoCloudKit = DaoFactory().getProductCloudKit()
        
    }
    
    func creatProduct()->Product{
        
        return Product()
        
    }
    
    func saveProduct(product : Product, gardenID : CKRecordID){
        
        var gardenReference : CKReference = Tools().recordIDToReference(gardenID)
        
        daoCloudKit.saveProduct(product, gardenID: gardenReference)
        
    }
    
    func updateProduct(product : Product){
        daoCloudKit.updateProduct(product)
    }
    
    // ProductDAOCKDelegate
    
    func errorThrowed(error: NSError) {
        self.delegate?.errorThrowed(error)
    }
    
    func receiveProducts(productArray: Array<Product>) {
        // vamos ver
        
        self.delegate?.receiveProducts(productArray)
    }
    
    func operationSucessfull() {
        
        self.delegate?.operationSucessfull()
        
        
    }
    
    
    
//    var image = UIImage(named: "iphone.png")
//    var data = UIImagePNGRepresentation(image)
    
    
}