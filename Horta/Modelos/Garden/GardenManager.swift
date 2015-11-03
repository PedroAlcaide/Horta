//
//  GardenManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 28/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

 @objc protocol GardenManagerDelegate{
    
    func errorThrowed(error:NSError)
    func gardenOperationSuccessfull()
    optional func getGardensSucessful(arrayGardens:NSMutableArray)
    
}

class GardenManager : GardenDAOCKDelegate{
  
    
        
    var daoCloudKit : GardenDAOCLoudKit
    var addressManager : AddressManager
    var currentGarden : Garden?
    var delegate : GardenManagerDelegate?
        
        
    init(){
            
        daoCloudKit = DaoFactory().getGardenDAOCloudKit()
        addressManager = AddressManager()
        daoCloudKit.delegate = self
        
    }
        
        
    func getNewGarden()->Garden{
            
        let newGarden = Garden()
        return newGarden
            
    }
    
    
//    func getNewGardenDB()->GardenDB{
//        
//        return GardenDB()
//        
//    }
    
    
    func saveGardenAndAddress(newGarden:Garden){
        
        currentGarden = newGarden
        daoCloudKit.saveNewGarden(newGarden)
        //addressManager.saveAddress(newGarden.address!)
        
    }
    
    func updateGardenAndAddress(garden:Garden){
        
        currentGarden = garden
        //addressManager.saveAddress(garden.address!)
        
    }
    

    /*
    func gardenToGardenDB(garden: Garden)->GardenDB{
        
        let newGardenDB = self.getNewGardenDB()
        newGardenDB.name = garden.name
        newGardenDB.photo = garden.photo
        newGardenDB.address = Tools().recordIDToReference(garden.address?.recordID)
        
        return newGardenDB
    }
    
    func gardenDBtoGarden(gardenDB: GardenDB)->Garden{
        
        let newGarden = self.getNewGarden()
        newGarden.name = gardenDB.name
        newGarden.recordID = gardenDB.recordID
        newGarden.photo = gardenDB.photo
        newGarden.address?.recordID = gardenDB.address?.recordID
        
        return newGarden
        
    }*/
    
    
    func getGardenByUser(userRecord:CKRecordID,isAdmin:Bool){
        
        let userID : CKReference = Tools().recordIDToReference(userRecord)
        daoCloudKit.getGardenByUser(userID, isAdmin: isAdmin)
        
    }
    
    
    
        /*
        // Methods AddressManagerDelegate
        
        func addressSavedSuccessfull(newAddress: Address) {
            self.currentGarden?.address = newAddress
            daoCloudKit.saveGardenBD(self.gardenToGardenDB(currentGarden!))
        }
        
        func updateSuccessfull() {
            daoCloudKit.updateGarden(self.gardenToGardenDB(currentGarden!))
        }
        */
    
    
    
    
    // Methods GardenDAODelegate
    
    func gardenSavedSuccessfull(gardenID:CKRecordID){
        
        let gardenReference = Tools().recordIDToReference(gardenID)
        let user = UserManager().getUserLogged()
        
        let userReference = Tools().recordIDToReference(user?.recordID)
        
        daoCloudKit.saveRelationshipUserAndGarden(gardenReference, adminRef: userReference, isAdmin: true)
        
        //print("gravou jardim")
        //self.delegate?.gardenOperationSuccessfull()
        
    }
    
    func savedRelationashipSucessfull(){
        
        self.delegate?.gardenOperationSuccessfull()
        
        
    }
    
    func errorThrow(){
        
        print("deu erro")
        
    }
    
    
    func getGardensSucessful(gardenDBArray: NSMutableArray) {
        
        
        self.delegate?.getGardensSucessful!(gardenDBArray)
    }
    
        
        
    // Methods Horta and User
    
    func toParticipateGarden(gardenID:CKRecordID, userID:CKRecordID){
        
        let gardenRef = Tools().recordIDToReference(gardenID)
        let userRef = Tools().recordIDToReference(userID)
        
        daoCloudKit.saveRelationshipParticipant(gardenRef, userRef: userRef)
        
    }
    
//    func addAdmin(gardenID:CKRecordID, userID:CKRecordID){
//        
//        var gardenRef = Tools().recordIDToReference(gardenID)
//        var userRef = Tools().recordIDToReference(userID)
//        
//        daoCloudKit.saveRelationshipAdmin(gardenRef, adminRef: userRef)
//        
//    }
    
    
    
    
    
}
