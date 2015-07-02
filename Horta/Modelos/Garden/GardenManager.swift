//
//  GardenManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 28/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

protocol GardenManagerDelegate{
    
    func errorThrowed(error:NSError)
    func gardenOperationSuccessfull()
    
}

class GardenManager : AddressManagerDelegate, GardenDAOCKDelegate{
  
    
        
    var daoCloudKit : GardenDAOCLoudKit
    var addressManager : AddressManager
    var currentGarden : Garden?
    var delegate : GardenManagerDelegate?
        
        
    init(){
            
        daoCloudKit = DaoFactory().getGardenDAOCloudKit()
        addressManager = AddressManager()
        addressManager.delegate = self
        daoCloudKit.delegate = self
    }
        
        
    func getNewGarden()->Garden{
            
        var newGarden = Garden()
        newGarden.address = addressManager.getNewAddress()
        return newGarden
            
    }
    
    
    func getNewGardenDB()->GardenDB{
        
        return GardenDB()
        
    }
    
    
    func saveGardenAndAddress(newGarden:Garden){
        
        currentGarden = newGarden
        addressManager.saveAddress(newGarden.address!)
        
    }
    
    func updateGardenAndAddress(garden:Garden){
        
        currentGarden = garden
        addressManager.saveAddress(garden.address!)
        
    }

    
    func gardenToGardenDB(garden: Garden)->GardenDB{
        
        var newGardenDB = self.getNewGardenDB()
        newGardenDB.name = garden.name
        newGardenDB.photo = garden.photo
        newGardenDB.address = Tools().recordIDToReference(garden.address?.recordID)
        
        return newGardenDB
    }
    
    
        
        // Methods AddressManagerDelegate
        
        func addressSavedSuccessfull(newAddress: Address) {
            self.currentGarden?.address = newAddress
            daoCloudKit.saveGardenBD(self.gardenToGardenDB(currentGarden!))
        }
        
        func updateSuccessfull() {
            daoCloudKit.updateGarden(self.gardenToGardenDB(currentGarden!))
        }
    
    
    
    
    
    // Methods GardenDAODelegate
    
    func gardenSavedSuccessfull(){
        print("gravou jardim")
        self.delegate?.gardenOperationSuccessfull()
        
    }
    
    
        
        
    // Methods Horta and User
    
    func toParticipateGarden(gardenID:CKRecordID, userID:CKRecordID){
        
        var gardenRef = Tools().recordIDToReference(gardenID)
        var userRef = Tools().recordIDToReference(userID)
        
        daoCloudKit.saveRelationshipParticipant(gardenRef, userRef: userRef)
        
    }
    
    func addAdmin(gardenID:CKRecordID, userID:CKRecordID){
        
        var gardenRef = Tools().recordIDToReference(gardenID)
        var userRef = Tools().recordIDToReference(userID)
        
        daoCloudKit.saveRelationshipAdmin(gardenRef, adminRef: userRef)
        
    }
    
    
    
    
    
}
