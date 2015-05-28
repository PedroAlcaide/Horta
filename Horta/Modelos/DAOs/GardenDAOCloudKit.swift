//
//  GardenDAOCloudKit.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 28/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

protocol GardenDAOCKDelegate{
    
    func errorThrowed(error:NSError)
    
}

class GardenDAOCLoudKit {
    
    var container : CKContainer
    var publicBD : CKDatabase
    var delegate : GardenDAOCKDelegate?
    let NAME = "Nome"
    let PHOTO = "Foto"
    let GARDEN = "Garden"
    let ADDRESS = "Endereco"
    
    
    init(){
        
        container = CKContainer.defaultContainer()
        publicBD = container.publicCloudDatabase
    }
    
    func saveGarden(newGarden:Garden){
        
        var record = CKRecord(recordType: GARDEN)
        record.setObject(newGarden.name, forKey: NAME)
        record.setObject(newGarden.address, forKey: ADDRESS)
        record.setObject(newGarden.photo, forKey: PHOTO)
        
        var modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord] (arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicBD.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if  error != nil
            
            
            
        })
        
        
        
    }
    
    
}
