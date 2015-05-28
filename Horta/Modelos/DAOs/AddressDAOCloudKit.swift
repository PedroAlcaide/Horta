//
//  AddressDAOCloudKit.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 28/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

protocol AddressDAOCKDelegate{
    
    func errorThrowed(error:NSError)
    func saveSuccessfull(newAddress:Address)
    func updateSuccessfull(address:Address)
    
}

class AddressDAOCLoudKit {
    
    var container : CKContainer
    var publicBD : CKDatabase
    var delegate : AddressDAOCKDelegate?
    let LOGRADOURO = "Logradouro"
    let NUMBER = "Numero"
    let COMPLEMENT = "Complemento"
    let POSTCODE = "CEP"
    let CITY = "Cidade"
    let STATE = "Estado"
    let ADDRESS = "Endereco"
    
    init(){
        
        container = CKContainer.defaultContainer()
        publicBD = container.publicCloudDatabase
    }
    
    func saveAddress(newAddress:Address){
        
        var record = CKRecord(recordType: ADDRESS)
        record.setObject(newAddress.address, forKey: LOGRADOURO)
        record.setObject(newAddress.number, forKey: NUMBER)
        record.setObject(newAddress.complement, forKey: COMPLEMENT)
        record.setObject(newAddress.postCode, forKey: POSTCODE)
        record.setObject(newAddress.city, forKey: CITY)
        record.setObject(newAddress.state, forKey: STATE)
        
        var modify = CKModifyRecordsOperation()
        modify.recordsToSave = [CKRecord] (arrayLiteral: record)
        modify.savePolicy = CKRecordSavePolicy.IfServerRecordUnchanged
        
        publicBD.saveRecord(record, completionHandler: { (record, error) -> Void in
            
            if  (error != nil){
                
                self.delegate?.errorThrowed(error)
            }else{
                newAddress.recordID = record.recordID
                self.delegate?.saveSuccessfull(newAddress)
                
            }
        })
        publicBD.addOperation(modify)
    }
    
    
    func updateAddress(address : Address){
        
        publicBD.fetchRecordWithID(address.recordID, completionHandler: { (record, error) -> Void in
            
            if  error != nil{
                
                self.delegate?.errorThrowed(error)
                
            }else{
                self.delegate?.updateSuccessfull(address)
            }
        })
        
    }

    
    
}
