//
//  AddressManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 28/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

protocol AddressManagerDelegate{
    
    func addressSavedSuccessfull(newAddress: Address)
    func updateSuccessfull()
    //func errorThrowed(error:NSError)
    
}

class AddressManager :AddressDAOCKDelegate {
    
    var daoCloudKit : AddressDAOCLoudKit
    var delegate : AddressManagerDelegate?
    
    
    init(){
        
        daoCloudKit = DaoFactory().getAddressDAOCloudKit()
        daoCloudKit.delegate = self
        
    }

    
    func getNewAddress()->Address{
        return Address()
    }
    
    func saveAddress(newAddress:Address){
        
        daoCloudKit.saveAddress(newAddress)

    }
    
    func updateAddress(address:Address){
        
        daoCloudKit.updateAddress(address)
        
    }
    
    func getAddress(gardenArray:NSMutableArray){
        
        
        
    }
    
    
    // Methods AddressDAOCKDelegate
    
    func saveSuccessfull(newAddress: Address) {
        self.delegate?.addressSavedSuccessfull(newAddress)
    }
    
    func updateSuccessfull() {
        self.delegate?.updateSuccessfull()
    }
    
    
    
    
}