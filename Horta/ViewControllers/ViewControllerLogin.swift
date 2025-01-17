//
//  ViewControllerLogin.swift
//  Horta
//
//  Created by Felipe R. de Luca on 6/1/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController, ValidatorDelegate, UserManagerDelegate, UITextFieldDelegate {
    
    let userLogin = LoginController.sharedInstance;
    var validator : Validator?
    var userManager : UserManager?
    var alertLoading : AlertViewLoading?
    
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtSenha: UITextField!
    
    

    @IBOutlet weak var userLoginFacebook: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IHKeyboardAvoiding.setAvoidingView(self.view)
        
        validator = Validator()
        validator?.delegate = self
        userManager = UserManager()
        userManager?.delegate = self
        txtEmail.delegate = self
        txtSenha.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if (userManager?.getUserLogged() != nil){
            
            self.performSegueWithIdentifier("ListaHortaSegue", sender: self)
            
        }
    }
    
    func ValidateLoginAndContinue() {
        /* Valida o login do usuário, seja pelo facebook, próprio aplicativo ou outro método
           e prossegue para a tela de hortas do app */
            //if self.userLogin.getUserStatus() > 0 {
            ////print( "USUARIO AUTENTICADO" )
            //self.performSegueWithIdentifier("ListaHortaSegue", sender: self)
            
        //}
//        else {
//            //print( "USUARIO NÃO AUTENTICADO" )
//            
//        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login_ConnectToFacebook( sender: UIButton ) {
//        let user = self.userLogin.loginFacebook()
        ValidateLoginAndContinue()
    }
    
    @IBAction func prepareForUnwind(segue:UIStoryboardSegue){
        // METODO É CHAMADO APOS RETORNAR DA PROXIMA VIEW
        // AINDA SERA IMPLEMENTADO
        
    }
    
    
    
    
    @IBAction func doLogon(sender: AnyObject) {
        
        
        validator?.iCloudAccountValidation()
        //self.navigationController?.popViewControllerAnimated(true)
        
    }

    
    @IBAction func cadastrarEmail(sender: AnyObject) {
        
    /*    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"viewController"];
*/
//       var storyboard = UIStoryboard(name: "Main", bundle: nil)
//        var nextController = storyboard.instantiateViewControllerWithIdentifier("cadastroView") as! UIViewController
//        
//        
//        self.presentViewController(nextController, animated: true, completion: nil)
        
        self.performSegueWithIdentifier("CadastroSegue", sender: self)
        
   }
    
    
    
    // Validator Delegate

    
    func errorThrowedValidator(errorIndex: Int) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            
            let alert = ErrorManager().errorToIndex(errorIndex)
            alert.delegate = self
            alert.show()
        })
    }
    
    func iCloudAccountAvaliable() {
        
        
       // dispatch_async(dispatch_get_main_queue(), { () -> Void in
            let array = [self.txtEmail,self.txtSenha] as Array<UITextField>
        
            
            if (self.validator?.validateDataSignIn(array) == true){
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.alertLoading = AlertViewLoading()
                    self.alertLoading?.show()
                })
                self.userManager?.toAuthentication(self.txtEmail.text!, password: self.txtSenha.text!)
            }
        //})
        
    }
    
    // UserManagerDelegate
    
    func errorCloudKitThrowed(error: NSError) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.alertLoading?.close()
            let alert = ErrorManager().errorsCloudKit(error.code)
            alert.delegate = self
            alert.show()
        })
        
    }
    
    func othersErrosThrowed(errorIndex: Int) {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.alertLoading?.close()
            let alert = ErrorManager().errorToIndex(errorIndex)
            alert.delegate = self
            alert.show()
        })
    }
    
    func userOperationSucessfull(user: User) {
        
    
       dispatch_async(dispatch_get_main_queue(), { () -> Void in
        self.alertLoading?.close()
            self.performSegueWithIdentifier("ListaHortaSegue", sender: self)
        
       })
        
        
    }
    
    
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
*/
}
