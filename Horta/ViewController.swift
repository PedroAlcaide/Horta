//
//  ViewController.swift
//  Horta
//
//  Created by Pedro Alcaide on 25/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UserManagerDelegate, ValidatorDelegate, UITextFieldDelegate {
    
//    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Celula" forIndexPath:indexPath];
//    
//    if (!cell) {
//    cell = [[TableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: @"Celula"];
//    }
//    
//    if (!isFiltered) {
//    cell.TituloLabel.text = [_Titulo objectAtIndex:indexPath.row];
//    cell.ImagemIcon.image = [UIImage imageNamed:_Imagem[indexPath.row]];
//    
//    }
//    else{
//    cell.TituloLabel.text = [filteredStrings objectAtIndex:indexPath.row];
//    cell.ImagemIcon.image = [UIImage imageNamed:_Imagem[[_Titulo indexOfObject:[filteredStrings objectAtIndex:indexPath.row]]]];
//    }
    
   // return cell;
    
  //  }

    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var sobrenome: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var confirmarsenha: UITextField!
    
    var manager : UserManager?
    var validador : Validator?
    var alertLoading : AlertViewLoading?
    var user : User?
    
    @IBAction func confirma(sender: UIButton) {
        //self.navigationController?.popViewControllerAnimated(true)
        validador?.iCloudAccountValidation()
        
    }
    
    
    
    
    @IBAction func back(sender: AnyObject) {
    
    self.performSegueWithIdentifier("BackLoginSegue", sender: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        IHKeyboardAvoiding.setAvoidingView(self.view)

       manager = UserManager()
        manager!.delegate = self
        
        validador = Validator()
        validador?.delegate = self
        
        nome.delegate = self
        sobrenome.delegate = self
        email.delegate = self
        confirmarsenha.delegate = self
        senha.delegate = self
        
        let localNotification: UILocalNotification = UILocalNotification()
        localNotification.alertAction = "Testing notifications on iOS8"
        localNotification.alertBody = "Woww it works!!"
        localNotification.fireDate = NSDate(timeIntervalSinceNow: 30)
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)

       
//        
//        var localNotification: UILocalNotification = UILocalNotification()
//        localNotification.alertAction = "Testing notifications on iOS8"
//        localNotification.alertBody = "Woww it works!!"
//        localNotification.fireDate = NSDate(timeIntervalSinceNow: 30)
//        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    // USER MANAGER DELEGATE
    
    func errorCloudKitThrowed(error: NSError) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //self.criaAlerta("Erro ao Gravar os dados, tente novamente!")
            self.alertLoading?.close()
            let alert = ErrorManager().errorsCloudKit(error.code)
            alert.delegate = self
            alert.show()
        })
        
    }
    
    func othersErrosThrowed(errorIndex: Int) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            //self.criaAlerta("Erro ao Gravar os dados, tente novamente!")
            self.alertLoading?.close()
            let alert = ErrorManager().errorToIndex(errorIndex)
            alert.delegate = self
            alert.show()
        })
        
    }
    
    func userOperationSucessfull(user: User) {
     
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.user = user
            self.alertLoading?.close()
            self.performSegueWithIdentifier("BackLoginSegue", sender: self)
        })
        
        //self.dismissViewControllerAnimated(true, completion: nil)
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
        
        
        let array = [nome,sobrenome, email, senha, confirmarsenha] as Array<UITextField>
        let correct = validador?.validateDataSignUp(array)
        
        if  (correct == true){
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.alertLoading = AlertViewLoading()
            self.alertLoading?.show()
        })
        let user = manager!.creatuser()
        user.name = nome.text
        user.surname = sobrenome.text
        user.email = email.text
        user.password = senha.text
            
        manager?.saveUser(user)
        

        }
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

