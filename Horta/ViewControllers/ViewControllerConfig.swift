//
//  ViewControllerConfig.swift
//  Horta
//
//  Created by Felipe R. de Luca on 6/1/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import UIKit

class ViewControllerConfig: UIViewController {

    let userConfig: UserConfig = UserConfig.sharedInstance
    let userLogin: LoginController = LoginController.sharedInstance
    
    @IBOutlet weak var userAlertColheitaPronta: UISwitch!;
    @IBOutlet weak var userAlertRegar         : UISwitch!;
    @IBOutlet weak var userAlertAdubo         : UISwitch!;
    @IBOutlet weak var userAlertAlertSomenteHortasUsuario: UISwitch!;
    
    @IBOutlet weak var userName   : UITextField!;
    @IBOutlet weak var userEmail  : UITextField!;
    @IBOutlet weak var logOut     : UIButton!;
    @IBOutlet weak var userPicture: UIImageView!;
    
    
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
    //----------------------------------------------------------------------------------
    @IBAction func userConfig_setUserPicture( sender: UIImageView ) {
        // userConfig.setUserName( sender.text );
    }
    //----------------------------------------------------------------------------------
    @IBAction func userConfig_setUserName( sender: UITextField ) {
        userConfig.setUserName( sender.text! );
    }
    //----------------------------------------------------------------------------------
    @IBAction func userConfig_setUserEmail( sender: UITextField ) {
        userConfig.setUserEmail( sender.text! );
    }
    //----------------------------------------------------------------------------------
    @IBAction func userConfig_logOut( sender: UIButton ) {
        userLogin.logout();
    }
    //----------------------------------------------------------------------------------
    @IBAction func userConfig_alertaSomenteHortasUsuario( sender: UISwitch ) {
        userConfig.setUserAlertSomenteHortasUsuario( sender.on );
    }
    //----------------------------------------------------------------------------------
    @IBAction func userConfig_alertaAdubo( sender: UISwitch ) {
        userConfig.setUserAlertColheitaAdubar( sender.on );
    }
    //----------------------------------------------------------------------------------
    @IBAction func userConfig_alertaColheitaPronta( sender: UISwitch ) {
        userConfig.setUserAlertColheitaPronta( sender.on );
    }
    //----------------------------------------------------------------------------------
    @IBAction func userConfig_alertaRegar( sender: UISwitch ) {
        userConfig.setUserAlertColheitaRegar( sender.on );
    }
    //----------------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        userLogin.loginFacebook();
        
        userConfig.loadUserDefaults();
        // Do any additional setup after loading the view, typically from a nib.
        userAlertRegar?.on = userConfig.getUserAlertColheitaRegar();
        userAlertAdubo?.on = userConfig.getUserAlertColheitaAdubar();
        userAlertColheitaPronta?.on = userConfig.getUserAlertColheitaPronta();
        userAlertAlertSomenteHortasUsuario?.on = userConfig.getUserAlertSomenteHortasUsuario();
        
        userName?.text  = userConfig.getUserName();
        userEmail?.text = userConfig.getUserEmail();
        userPicture?.addSubview( userConfig.getUserPicture()! );
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
