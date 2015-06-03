//
//  ViewControllerLogin.swift
//  Horta
//
//  Created by Felipe R. de Luca on 6/1/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class ViewControllerLogin: UIViewController, ValidatorDelegate, UserManagerDelegate {
    
    let userLogin = LoginController.sharedInstance;
    var validator : Validator?
    var userManager : UserManager?
    
    
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtSenha: UITextField!
    
    

    @IBOutlet weak var userLoginFacebook: UIButton!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        validator = Validator()
        validator?.delegate = self
        userManager = UserManager()
        userManager?.delegate = self
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login_ConnectToFacebook( sender: UIButton ) {
        userLogin.loginFacebook();
    }
    
    
    
    
    @IBAction func doLogon(sender: AnyObject) {
        
        
        validator?.iCloudAccountValidation()
        //self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func criaAlerta(error:String){
        
        var alert = UIAlertView(title: "Error ao Autenticar", message: error, delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    
    
    @IBAction func cadastrarEmail(sender: AnyObject) {
        
    /*    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"viewController"];
*/
       var storyboard = UIStoryboard(name: "Main", bundle: nil)
        var nextController = storyboard.instantiateViewControllerWithIdentifier("cadastroView") as! UIViewController
        
        
        self.presentViewController(nextController, animated: true, completion: nil)
        
        
    }
    
    
    
    // Validator Delegate
    
    func errorThrowedValidator(error: String) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.criaAlerta(error)
        })
        
        
    }
    
    func iCloudAccountAvaliable() {
        
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            var array = [self.txtEmail,self.txtSenha] as Array<UITextField>
            
            
            
            if (self.validator?.isAllFilledFields(array) == true){
                self.userManager?.toAuthentication(self.txtEmail.text, password: self.txtSenha.text)
            }
        })
        
        
        
    
        
    }
    
    // UserManagerDelegate
    
    func errorThrowed(error: NSError) {
        self.criaAlerta("Erro ao autenticar")
    }
    
    func userSaveSucessfull() {
        
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
