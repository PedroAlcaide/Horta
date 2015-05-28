//
//  ProductManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

protocol ProductManagerDelegate{
    
    func errorThrowed(error:NSError)
    
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
    
    func saveProduct(product : Product){
        
        daoCloudKit.saveProduct(product)
        
    }
    
    func updateProduct(product : Product){
        daoCloudKit.updateProduct(product)
    }
    
    // ProductDAOCKDelegate
    
    func errorThrowed(error: NSError) {
        self.delegate?.errorThrowed(error)
    }
    
    
    
//    var image = UIImage(named: "iphone.png")
//    var data = UIImagePNGRepresentation(image)
    
    
}