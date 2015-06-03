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
    
    @IBOutlet weak var nomehorta: UITextField!
    
    @IBOutlet weak var criar1: UIButton!
    @IBOutlet weak var criar2: UIButton!
    @IBOutlet weak var criar3: UIButton!
    @IBOutlet weak var criar4: UIButton!
    @IBOutlet weak var criar5: UIButton!
    @IBOutlet weak var criar6: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nome.delegate = self
        cep.delegate = self
        endereco.delegate = self
        cidade.delegate = self
        estado.delegate = self
        nomehorta.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
}
