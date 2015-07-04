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
    
    func gardenSavedSuccessfull()
    
}

class GardenDAOCLoudKit {
    
    var container : CKContainer
    var publicBD : CKDatabase
    var delegate : GardenDAOCKDelegate?
    let NAME = "Nome"
    let PHOTO = "Foto"
    let GARDENDB = "GardenDB"
    let ADDRESS = "Endereco"
    
    let TABLE_PARTICIPANTE = "HORTA_PARTICIPANTE"
    let TABLE_ADMIN = "HORTA_ADMIN"
    let ID_GARDEN = "IDHorta"
    let ID_PART = "IDParticipante"
    let ID_ADMIN = "IDAdmin"
    
    
    init(){
        
        container = CKContainer.defaultContainer()
        publicBD = container.publicCloudDatabase
    }
    
    
    func saveGardenBD(newGarden:GardenDB){
        
        var record = CKRecord(recordType: GARDENDB)
        record.setObject(newGarden.name, forKey: NAME)
        record.setObject(newGarden.address, forKey: ADDRESS)
        record.setObject(newGarden.photo, forKey: PHOTO)
        
        var modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord] (arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicBD.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if  (error != nil && error.code != 23){
                    print("falha ao gravar jardim")
            }else{
                self.delegate?.gardenSavedSuccessfull()
            }
            
        })
        
        publicBD.addOperation(modify)
        
    }
    
    
    
    func updateGarden(garden :GardenDB){
        
        publicBD.fetchRecordWithID(garden.recordID, completionHandler: { (record, error) -> Void in
            
            if  error != nil{
                
                print("falar ao atualizar jardim")
                
            }else{
                print("atualizou garden")
            }
        })
        
    }
    
    
    func saveRelationshipParticipant(gardenRef:CKReference,userRef:CKReference){
        
        var record = CKRecord(recordType: TABLE_PARTICIPANTE)
        record.setObject(gardenRef, forKey: ID_GARDEN)
        record.setObject(userRef, forKey: ID_PART)
        
        var modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord] (arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicBD.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if  (error != nil && error.code != 23){
                //self.delegate?.errorThrowed(error)
            }else{
                print("Gravou participante")
            }
            
        })
        
        publicBD.addOperation(modify)
        
    }
    
    func saveRelationshipAdmin(gardenRef:CKReference,adminRef:CKReference){
        
        var record = CKRecord(recordType: TABLE_ADMIN)
        record.setObject(gardenRef, forKey: ID_GARDEN)
        record.setObject(adminRef, forKey: ID_ADMIN)
        
        var modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord] (arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicBD.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if  (error != nil && error.code != 23){
                //self.delegate?.errorThrowed(error)
            }else{
                print("Gravou admin")
            }
            
        })
        
        publicBD.addOperation(modify)
        
        
        
    }

    
    
}
