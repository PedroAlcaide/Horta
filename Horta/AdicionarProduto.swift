//
//  AdicionarProduto.swift
//  Horta
//
//  Created by Pedro Alcaide on 02/06/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit
import CloudKit

//----------------------------------------------------------------------
class AdicionarProduto: UIViewController {
        
    @IBOutlet weak var btnBatata: UIButton!
    @IBOutlet weak var btnAlface: UIButton!
    @IBOutlet weak var btnBrocolis: UIButton!
    @IBOutlet weak var btnCebola: UIButton!
    @IBOutlet weak var btnAbobora: UIButton!
    @IBOutlet weak var btnCenoura: UIButton!
    
    @IBOutlet weak var dataplantado: UILabel!
    @IBOutlet weak var datacolheita: UILabel!
    
    @IBOutlet weak var numerocanteiro: UILabel!

    @IBOutlet weak var nomeresponsavel: UILabel!
    @IBOutlet weak var nomehorta: UILabel!
    
    var garden: Garden?
    var product = Product()
    
    var productArray: Array<Product> = []
    
    //----------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    //----------------------------------------------------------------------
    @IBAction func selectBatata() {
    
        self.product.name = "batata"
        self.product.photo = "batata"
        self.product.description = "Batata"
    }
    
    //----------------------------------------------------------------------
    @IBAction func selectCenoura() {
        
        self.product.name = "cenoura"
        self.product.photo = "cenoura"
        self.product.description = "Cenoura"
    }
    
    //----------------------------------------------------------------------
    @IBAction func selectBrocolis() {
        
        self.product.name = "brocolis"
        self.product.photo = "brocolis"
        self.product.description = "Brócolis"
    }
    
    //----------------------------------------------------------------------
    @IBAction func selectAlface() {
        
        self.product.name = "alface"
        self.product.photo = "alface"
        self.product.description = "Alface"
    }
    
    //----------------------------------------------------------------------
    @IBAction func selectCebola() {
        
        self.product.name = "cebola"
        self.product.photo = "cebola.png"
        self.product.description = "Cebola"
    }
    
    //----------------------------------------------------------------------
    @IBAction func selectAbobora() {
        
        self.product.name = "abobora"
        self.product.photo = "abobora"
        self.product.description = "Abóbora"
    }
    
    //----------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let vc = segue.destinationViewController as? PagedScrollViewController
        
        let id = NSNumber( integer: (sender?.hash)! )

        self.product.recordID = CKRecordID.init( recordName: id.stringValue )
        
        if segue.identifier == "SaveProduct" {
            self.productArray.append( self.product )
        }

        vc!.productsArray = self.productArray
    }
    
    //----------------------------------------------------------------------
    
}
//----------------------------------------------------------------------
