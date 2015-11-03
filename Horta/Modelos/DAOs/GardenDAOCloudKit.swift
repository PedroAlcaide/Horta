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
    
    func gardenSavedSuccessfull(gardenID:CKRecordID)
    func savedRelationashipSucessfull()
    func getGardensByUser(gardenArray:NSMutableArray)
    func errorThrow()
    
}

class GardenDAOCLoudKit {
    
    var container : CKContainer
    var publicBD : CKDatabase
    var delegate : GardenDAOCKDelegate?
    let NAME = "Nome"
    let PHOTO = "Foto"
    let GARDEN = "Horta"
    let ADDRESS = "Endereco"
    let DISTRICT = "Bairro"
    let POSTCODE = "CEP"
    let STATE = "Estado"
    let CITY = "Cidade"
    
    
    let TABLE_PARTICIPANTE = "HORTA_PARTICIPANTE"
    let TABLE_ADMIN = "HORTA_ADMIN"
    let ID_GARDEN = "IDHorta"
    let ID_PART = "IDParticipante"
    let ID_ADMIN = "IDAdmin"
    
    
    init(){
        
        container = CKContainer.defaultContainer()
        publicBD = container.publicCloudDatabase
    }
    
    // SALVAR JARDIM
    
    func saveNewGarden(newGarden:Garden){
        
        let record = CKRecord(recordType: GARDEN)
        record.setObject(newGarden.name, forKey: NAME)
        record.setObject(newGarden.address, forKey: ADDRESS)
        record.setObject(newGarden.city, forKey: CITY)
        record.setObject(newGarden.district, forKey: DISTRICT)
        record.setObject(newGarden.state, forKey: STATE)
        record.setObject(newGarden.postCode, forKey: POSTCODE)
        record.setObject(newGarden.photo, forKey: PHOTO)
        
        //var modify = CKModifyRecordsOperation()
        //modify.recordsToSave = [CKRecord] (arrayLiteral: record)
        //modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicBD.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if  (error != nil){
                    print("falha ao gravar jardim", terminator: "")
            }else{
                self.delegate?.gardenSavedSuccessfull(record!.recordID)
            }
            
        })
        
        //publicBD.addOperation(modify)
        
    }
    
    // ATUALAIZAR JARDIM
    
    func updateGarden(garden :GardenDB){
        
        publicBD.fetchRecordWithID(garden.recordID!, completionHandler: { (record, error) -> Void in
            
            if  error != nil{
                
                print("falar ao atualizar jardim", terminator: "")
                
            }else{
                print("atualizou garden", terminator: "")
            }
        })
        
    }
    
    // SALVAR RELACIONAMENTO ENTER JARDIM E PARTICIPANTE
    
    
    func saveRelationshipParticipant(gardenRef:CKReference,userRef:CKReference){
        
        let record = CKRecord(recordType: TABLE_PARTICIPANTE)
        record.setObject(gardenRef, forKey: ID_GARDEN)
        record.setObject(userRef, forKey: ID_PART)
        
        let modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord] (arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicBD.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if  (error != nil){
                //self.delegate?.errorThrowed(error)
            }else{
                print("Gravou participante", terminator: "")
            }
            
        })
        
        publicBD.addOperation(modify)
        
    }
    
    // SALVAR RELACIONAMENTO ENTRE JARDIM E ADMIN
    
    
    func saveRelationshipUserAndGarden(gardenRef:CKReference,adminRef:CKReference, isAdmin:Bool){
        
        var record :CKRecord?
        
        if  (isAdmin){
            
            record = CKRecord(recordType: TABLE_ADMIN)
            record!.setObject(gardenRef, forKey: ID_GARDEN)
            record!.setObject(adminRef, forKey: ID_ADMIN)
            
        }else{
            
            record = CKRecord(recordType: TABLE_PARTICIPANTE)
            record!.setObject(gardenRef, forKey: ID_GARDEN)
            record!.setObject(adminRef, forKey: ID_PART)
            
        }
        
        
        
//        var modify = CKModifyRecordsOperation()
//        modify.recordsToSave = [CKRecord] (arrayLiteral: record!)
//        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicBD.saveRecord(record!, completionHandler: { (record, error) -> Void in
            
            if  (error != nil){
                //self.delegate?.errorThrowed(error)
                print("erro ao gravar relacionamento")
            }else{
                self.delegate?.savedRelationashipSucessfull()
                
            }
            
        })
        
        //publicBD.addOperation(modify)
        
        
        
    }
    
    
    // GET GARDEN BY ADMIN AND PARTICIPANT
    
    func getGardenByUser(userID:CKReference, isAdmin:Bool){
        
        var predicate : NSPredicate?
        var query : CKQuery?
        
        if  (isAdmin){
            
            // QUERY FOR FETCH GARDEN BY ADMIN
            
            predicate = NSPredicate(format: "\(ID_ADMIN) == %@", userID)
            query = CKQuery(recordType: TABLE_ADMIN, predicate: predicate!)

            
        }else{
            
            // QUERY FOR FETCH GARDEN ON PARTICIPANT
            
            predicate = NSPredicate(format: "\(ID_PART) == %@", userID)
            query = CKQuery(recordType: TABLE_PARTICIPANTE, predicate: predicate!)
        }
        
        
        self.publicBD.performQuery(query!, inZoneWithID: nil) { (results, error) -> Void in
            
            
            // VERIFICA SE DEU ERRO
            
            if  (error == nil){
                
                // VERIFICA SE RECUPEROU ALGUM VALOR DO BD
                
                if  (results!.count > 0){
                    
                    let idGardenArray = NSMutableArray()
                    for record in results!{
                        
                        let gardenReference: CKReference = record.objectForKey(self.ID_GARDEN) as! CKReference
                        idGardenArray.addObject(gardenReference)
                        
                    }
                    
                    self.getListGarden(idGardenArray, gardensArray: NSMutableArray(), garden: nil)
                    
                    
                }else{
                    print("nenhum dado encontrado", terminator: "")
                }
                
                
            }else{
                print("algum erro no cloudkit", terminator: "")
            }
            
            
        }
    }
    
    
    func getListGarden(idGardenArray:NSMutableArray, gardensArray:NSMutableArray, garden:GardenDB?){
        
        
        if (garden != nil){
            
            gardensArray.addObject(garden!)
            //var seila = gardensArray
        }
        
        if  (idGardenArray.count == 0){
            
            // CHAMAR DELEGATE
            self.delegate?.getGardensByUser(gardensArray)

        }
        
        
        
        let gardenReference: CKReference = idGardenArray.lastObject as! CKReference
        let gardenID = gardenReference.recordID
        idGardenArray.removeLastObject()
        
        self.getGarden(gardenID, idGardensArray: idGardenArray, gardensArray: gardensArray)
        
    }
    
    func getGarden(gardenID:CKRecordID, idGardensArray:NSMutableArray, gardensArray:NSMutableArray){
        
        publicBD.fetchRecordWithID(gardenID) { (result, error) -> Void in
            
            if  (error == nil){
                
                
                if  (result != nil){
                    
                    let gardenResult : CKRecord = result!
                    let getGarden = GardenDB()
                    
                    getGarden.recordID = gardenResult.recordID
                    getGarden.name = gardenResult.objectForKey(self.NAME) as? String
                    getGarden.address = gardenResult.objectForKey(self.ADDRESS) as? CKReference
                    getGarden.photo = gardenResult.objectForKey(self.PHOTO) as? NSData
                    
                    
                    // implementar delegate
                    self.getListGarden(idGardensArray, gardensArray: gardensArray, garden: getGarden)
                    
                    
                }else{
                    print("nenhum encontrado")
                }
                    
                
                    
                    
                
                
            }else{
                
                // error cloud kit - implementar delegate
                print("erro cloudkit", terminator: "")
            }
            
            
            
        
        }
            
        
    }
    
}
