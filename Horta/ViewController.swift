//
//  ViewController.swift
//  Horta
//
//  Created by Pedro Alcaide on 25/05/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UserManagerDelegate {
    
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
    
    @IBAction func confirma(sender: UIButton) {
        
        var array = [nome,sobrenome, email, confirmaremail, senha, confirmarsenha] as Array<UITextField>
        var correct = Validator.isAllFilledFields(array)
        Validator.compareEqualFields(email, field2: confirmaremail)
        if  (correct == true){
        
        var user = manager!.creatuser()
        user.name = nome.text
        user.surname = sobrenome.text
        user.email = email.text
        user.password = senha.text
        
        }
        
        
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

       manager = UserManager()
        manager!.delegate = self
        
        
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
    
    
    func errorThrowed(error: NSError) {
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

