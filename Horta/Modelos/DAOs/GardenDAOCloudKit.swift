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
    
    
    // GET GARDEN BY ADMIN AND PARTICIPANT
    
    func getGardenByUser(userID:CKRecordID, isAdmin:Bool){
        
        var predicate : NSPredicate?
        var query : CKQuery?
        
        if  (isAdmin){
            
            // QUERY FOR FETCH GARDEN BY ADMIN
            
            predicate = NSPredicate(format: "\(ID_ADMIN) == %@", userID)
            var query = CKQuery(recordType: TABLE_ADMIN, predicate: predicate)

            
        }else{
            
            // QUERY FOR FETCH GARDEN ON PARTICIPANT
            
            predicate = NSPredicate(format: "\(ID_PART) == %@", userID)
            var query = CKQuery(recordType: TABLE_PARTICIPANTE, predicate: predicate)
        }
        
        
        self.publicBD.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            
            
            // VERIFICA SE DEU ERRO
            
            if  (error != nil){
                
                // VERIFICA SE RECUPEROU ALGUM VALOR DO BD
                
                if  (results.count > 0){
                    
                        var idGardenArray = NSMutableArray()
                    for record in results{
                        
                        var gardenReference: CKReference = record.objectForKey(self.ID_ADMIN) as! CKReference
                        idGardenArray.addObject(gardenReference)
                        
                    }
                    
                    self.getListGarden(idGardenArray, gardensArray: NSMutableArray(), garden: nil)
                    
                    
                }else{
                    print("nenhum dado encontrado")
                }
                
                
            }else{
                print("algum erro no cloudkit")
            }
            
            
        }
    }
    
    
    func getListGarden(idGardenArray:NSMutableArray, gardensArray:NSMutableArray, garden:Garden?){
        
        
        if (garden != nil){
            
            gardensArray.addObject(garden!)
            
        }
        
        if  (idGardenArray.count == 0){
            
            //chamar delegate
            return
            
            
        }
        
        
        
        var gardenReference: CKReference = idGardenArray.lastObject as! CKReference
        var gardenID = gardenReference.recordID
        idGardenArray.removeLastObject()
        
        self.getGarden(gardenID, idGardensArray: idGardenArray, gardensArray: gardensArray)
        
    }
    
    func getGarden(gardenID:CKRecordID, idGardensArray:NSMutableArray, gardensArray:NSMutableArray){
        
        var predicate = NSPredicate(format: "\(ID_GARDEN) == %@", gardenID)
        var query = CKQuery(recordType: GARDENDB, predicate: predicate)
        
        publicBD.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            
            if  (error != nil){
                
                
                if  (results.count > 0){
                    
                    var gardenResult = results[0] as! CKRecord
                    var getGarden = GardenDB()
                    
                    getGarden.recordID = gardenResult.recordID
                    getGarden.name = gardenResult.objectForKey(self.NAME) as? String
                    getGarden.address = gardenResult.objectForKey(self.ADDRESS) as? CKReference
                    getGarden.photo = gardenResult.objectForKey(self.PHOTO) as? NSData
                    
                    
                    // implementar delegate
                    
                    
                    
                }else{
                    // NENHUM DADO ENCONTRADO - implementar delegate
                }
                
                
            }else{
                
                // error cloud kit - implementar delegate
            }
            
            
            
        }
        
        
        
        
    }
    
}
