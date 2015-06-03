//
//  ViewController.swift
//  Horta
//
//  Created by Pedro Alcaide on 25/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UserManagerDelegate, ValidatorDelegate {
    
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
    @IBOutlet weak var confirmaremail: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var confirmarsenha: UITextField!
    
    var manager : UserManager?
    var validador : Validator?
    
    @IBAction func confirma(sender: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
        //validador?.iCloudAccountValidation()
        
    }
    
    
    @IBAction func voltar(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

       manager = UserManager()
        manager!.delegate = self
        
        validador = Validator()
        validador?.delegate = self
        
        
        var localNotification: UILocalNotification = UILocalNotification()
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

        
        
        UserManager().toAuthentication("email0@gmail.com", password: "password0")
    }
    
    // USER MANAGER DELEGATE
    
    func errorThrowed(error: NSError) {
        
        //dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.criaAlerta("Erro ao Gravar os dados, tente novamente!")
        //})
        
    }
    
    func userSaveSucessfull() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // VALIDATOR DELEGATE
    
    func errorThrowedValidator(error: String) {
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.criaAlerta(error)
        })
        
    }
    
    func iCloudAccountAvaliable() {
        
        
        var array = [nome,sobrenome, email, confirmaremail, senha, confirmarsenha] as Array<UITextField>
        var correct = validador?.validateDataSignUp(array)
        
        if  (correct == true){
        
        var user = manager!.creatuser()
        user.name = nome.text
        user.surname = sobrenome.text
        user.email = email.text
        user.password = senha.text
            
        manager?.saveUser(user)
        

        }
        
        
    }
    
    func criaAlerta(error:String){
        
        var alert = UIAlertView(title: "Error Sign UP", message: error, delegate: self, cancelButtonTitle: "OK")
        alert.show()
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

