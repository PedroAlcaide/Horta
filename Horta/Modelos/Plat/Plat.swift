//
//  Plat.swift
//  Horta
//
//  Created by Henrique Pereira de Lima on 27/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation
import CloudKit

class Plat {
    
    var recordID : CKRecordID?
    var identification : Int?
    var photo : NSData?
    var idHorta : CKReference?
    var idProduto : CKReference?
    var idResponsavel : CKReference?
    
}