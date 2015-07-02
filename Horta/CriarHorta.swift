//
//  CriarHorta.swift
//  Horta
//
//  Created by Pedro Alcaide on 02/06/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class CriarHorta: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var cep: UITextField!
    @IBOutlet weak var endereco: UITextField!
    @IBOutlet weak var cidade: UITextField!
    
    @IBOutlet weak var estado: UITextField!
    
    @IBOutlet weak var bairro: UITextField!
    
    @IBOutlet weak var criar1: UIButton!
    @IBOutlet weak var criar2: UIButton!
    @IBOutlet weak var criar3: UIButton!
    @IBOutlet weak var criar4: UIButton!
    @IBOutlet weak var criar5: UIButton!
    @IBOutlet weak var criar6: UIButton!
    
    var gardenManager : GardenManager?
    var garden : Garden?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nome.delegate = self
        cep.delegate = self
        endereco.delegate = self
        cidade.delegate = self
        estado.delegate = self
        bairro.delegate = self
        
        // Preparando jardim
        gardenManager = GardenManager()
        garden = gardenManager?.getNewGarden()
        
        
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func submitData(sender: AnyObject) {
        
        garden?.name = nome.text
        garden?.address?.address = endereco.text
        garden?.address?.postCode = cep.text
        garden?.address?.district = bairro.text
        garden?.address?.city = cidade.text
        garden?.address?.state = estado.text
        
        
        gardenManager?.saveGardenAndAddress(garden!)
        
        
        
    }
    
    
}
