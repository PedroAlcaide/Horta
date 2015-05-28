//
//  GardenManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 28/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

class GardenManager : AddressManagerDelegate{
  
    
        
    var daoCloudKit : GardenDAOCLoudKit
    var addressManager : AddressManager
    var currentGarden : Garden?
        //var delegate : AddressManagerDelegate?
        
        
    init(){
            
        daoCloudKit = DaoFactory().getGardenDAOCloudKit()
        //daoCloudKit.delegate = self
        addressManager = AddressManager()
        addressManager.delegate = self
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
    
    func gardenToGardenDB(garden: Garden)->GardenDB{
        
        var newGardenDB = self.getNewGardenDB()
        newGardenDB.name = garden.name
        newGardenDB.photo = garden.photo
        newGardenDB.address = CKReference(recordID: garden.address?.recordID, action: CKReferenceAction.None)
        
        return newGardenDB
        
    
    }
//        func saveAddress(newAddress:Address){
//            
//            daoCloudKit.saveAddress(newAddress)
//            
//        }
//        
//        func updateAddress(address:Address){
//            
//            daoCloudKit.updateAddress(address)
//            
//        }
    
        
        // Methods AddressManagerDelegate
        
        func saveSuccessfull(newAddress: Address) {
            self.currentGarden?.address = newAddress
            daoCloudKit.saveGardenBD(self.gardenToGardenDB(currentGarden!))
        }
        
        func updateSuccessfull(address: Address) {
            //self.delegate?.updateSuccessfull(address)
        }
        
        func errorThrowed(error: NSError) {
            //self.delegate?.errorThrowed(error)
        }
        
        
        
        
    
    
    
    
}
