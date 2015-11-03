//
//  CriarHorta.swift
//  Horta
//
//  Created by Pedro Alcaide on 02/06/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class CriarHorta: UIViewController, UITextFieldDelegate, ValidatorDelegate, GardenManagerDelegate {
    
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
    var validador : Validator?
    var alertLoading : AlertViewLoading?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nome.delegate = self
        cep.delegate = self
        cep.keyboardType = UIKeyboardType.NumberPad
        endereco.delegate = self
        cidade.delegate = self
        estado.delegate = self
        bairro.delegate = self
        
        // Preparando jardim
        gardenManager = GardenManager()
        gardenManager?.delegate = self
        garden = gardenManager?.getNewGarden()
        
        
        
    }
    
    func closeAlert(){
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            self.alertLoading?.close()
        }
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    @IBAction func submitData(sender: AnyObject) {
        
        
        
        validador = Validator()
        validador?.delegate = self
        validador?.iCloudAccountValidation()
        
        
    }
    
    @IBAction func back(sender: AnyObject) {
        
        self.performSegueWithIdentifier("BackHortaTable", sender: self)
    }
    
    // VALIDATOR DELEGATE
    
    func errorThrowedValidator(errorIndex: Int) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            let alert = ErrorManager().errorToIndex(errorIndex)
            alert.delegate = self
            alert.show()
        })
        
    }
    
    func iCloudAccountAvaliable() {
        
        
        let array = [nome, cep, endereco, bairro, cidade, estado] as Array<UITextField>
        let correct = validador?.isAllFilledFields(array)
        
        if  (correct == true){
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.alertLoading = AlertViewLoading()
                self.alertLoading?.show()
            })
            garden?.name = nome.text
            garden?.address = endereco.text
            garden?.postCode = cep.text
            garden?.district = bairro.text
            garden?.city = cidade.text
            garden?.state = estado.text
            
            gardenManager?.saveGardenAndAddress(garden!)
            
            
        }
        
        
    }
    
    // Garden Manager Delegate
    
    func gardenOperationSuccessfull() {
        
        
        self.closeAlert()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func errorThrowed(error: NSError) {
        self.errorThrowedValidator(error.code)
    }
    
}
