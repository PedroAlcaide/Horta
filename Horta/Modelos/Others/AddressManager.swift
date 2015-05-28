//
//  AddressManager.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 28/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

protocol AddressManagerDelegate{
    
    func saveSuccessfull(newAddress: Address)
    func updateSuccessfull(address:Address)
    func errorThrowed(error:NSError)
    
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
    
    
    // Methods AddressDAOCKDelegate
    
    func saveSuccessfull(newAddress: Address) {
        self.delegate?.saveSuccessfull(newAddress)
    }
    
    func updateSuccessfull(address: Address) {
        self.delegate?.updateSuccessfull(address)
    }
    
    func errorThrowed(error: NSError) {
        self.delegate?.errorThrowed(error)
    }
    
    
    
    
}