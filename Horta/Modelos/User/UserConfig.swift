//
//  UserConfig.swift
//  Horta
//
//  Created by Felipe R. de Luca on 5/29/15.
//  Copyright (c) 2015 Pedro Alcaide. All rights reserved.
//

import Foundation

class UserConfig {
    static let sharedInstance   = UserConfig();
    
    private let loginController = LoginController.sharedInstance;
    
    private let userDefaults    = NSUserDefaults.standardUserDefaults();
    
    private var userHortas: [String]?; // Fornecida através do banco de dados
    private var userName  : String?; // Fornecido através do login
    private var userEmail : String?; // Fornecido através do login
    
    private var userShowPicture: Bool;
    private var userAlertColheitaPronta: Bool;
    private var userAlertColheitaRegar : Bool;

    private var userAlertColheitaAdubar: Bool;
    private var userAlertSomenteHortasUsuario: Bool;

    
    //--------------------------------------------------------------------------------
    init(){
        userHortas = [ "" ];
        userName   = "[no user]";
        userEmail  = "[no email]";
        userShowPicture         = true;
        userAlertColheitaPronta = false;
        userAlertColheitaRegar  = false;
        userAlertColheitaAdubar = false;
        userAlertSomenteHortasUsuario = false;
//        userDefaults.setObject( userHortas, forKey: "userHortas" );
    }

    func setUserAlertColheitaPronta( value: Bool ) -> () {
        userAlertColheitaPronta = value;
        userDefaults.setBool( userAlertColheitaPronta, forKey: "userAlertColheitaPronta" );
    }
    //--------------------------------------------------------------------------------
    func setUserAlertColheitaRegar( value: Bool ) -> () {
        userAlertColheitaRegar = value;
        userDefaults.setBool( userAlertColheitaRegar, forKey: "userAlertColheitaRegar" );
    }
    //--------------------------------------------------------------------------------
    func setUserAlertColheitaAdubar( value: Bool ) -> () {
        userAlertColheitaAdubar = value;
        userDefaults.setBool( userAlertColheitaAdubar, forKey: "userAlertColheitaAdubar" );
    }
    //--------------------------------------------------------------------------------
    func setUserAlertSomenteHortasUsuario( value: Bool ) -> () {
        userAlertSomenteHortasUsuario = value;
        userDefaults.setBool( userAlertSomenteHortasUsuario, forKey: "userAlertSomenteHortasUsuario" );
    }
    //--------------------------------------------------------------------------------
    func setShowUserPicture( value: Bool ) -> () {
        userShowPicture = value;
        userDefaults.setBool( userShowPicture, forKey: "userShowPicture" );
    }
    //--------------------------------------------------------------------------------
    func setUserName( name: String ) -> () {
        userName = name;
        userDefaults.setValue( userName, forKey: "userName" );
    }
    //--------------------------------------------------------------------------------
    func setUserEmail( email: String ) -> () {
        userEmail = email;
        userDefaults.setValue( userEmail, forKey: "userEmail" );
    }
    //--------------------------------------------------------------------------------
    func getUserAlertColheitaPronta() -> Bool {
        return userAlertColheitaPronta;
    }
    //--------------------------------------------------------------------------------
    func getUserAlertColheitaRegar() -> Bool {
        print("Colheita regar: \(userAlertColheitaRegar)");
        return userAlertColheitaRegar;
    }
    //--------------------------------------------------------------------------------
    func getUserAlertColheitaAdubar() -> Bool {
        return userAlertColheitaAdubar;
    }
    //--------------------------------------------------------------------------------
    func getUserAlertSomenteHortasUsuario() -> Bool {
        return userAlertSomenteHortasUsuario;
    }
    //--------------------------------------------------------------------------------
    func getUserName() -> String {
        return userName!;
    }
    //--------------------------------------------------------------------------------
    func getUserEmail() -> String {
        return userEmail!;
    }
    //--------------------------------------------------------------------------------
    func getUserPicture() -> UIView? {
        
//        if userShowPicture {
//            return loginController.getUserPicture()!;
//        }
//        else {
//            return nil;
//        }
        return nil
    }
    //--------------------------------------------------------------------------------
    func loadUserDefaults() -> () {
        
        userAlertColheitaPronta = loadUserAlertaColheitaPronta();
        userAlertColheitaRegar  = loadUserAlertColheitaRegar();
        userAlertColheitaAdubar = loadUserAlertColheitaAdubar();
        userAlertSomenteHortasUsuario = loadUserAlertSomenteHortasUsuario();
        
        userHortas = loadUserHortas();
        userName   = loadUserName();
        userEmail  = loadUserEmail();
        
    }
    //--------------------------------------------------------------------------------
    private func loadUserEmail()-> String {
//        let email: String? = userDefaults.stringForKey( "userEmail" );
        
//        if email != nil {
//            return email!;
//        }
//        else {
//            return loginController.getUserEmail()!;
//        }
        
        return ""
    }
    //--------------------------------------------------------------------------------
    private func loadUserName()-> String {
//        var name: String? = userDefaults.stringForKey( "userName" );
        
//        if ( name == nil || name == "" ){
//            name = loginController.getUserName()!;
//        }
//        
//        return name!;
        return ""
    }
    //--------------------------------------------------------------------------------
    private func loadUserHortas() -> [String] {
      //  userHortas = userDefaults. .arrayForKey( "userHortas" );
        return [ "" ];
    }
    //--------------------------------------------------------------------------------
    private func loadUserShowPicture() -> Bool {
        let opt: Bool? = userDefaults.boolForKey( "userShowPicture" );

        if opt != nil{
            return opt!;
        }
        else {
            return false;
        }
    }
    //--------------------------------------------------------------------------------
    private func loadUserAlertSomenteHortasUsuario() -> Bool {
        let opt: Bool? = userDefaults.boolForKey( "userAlertSomenteHortasUsuario" );

        if opt != nil{
            return opt!;
        }
        else {
            return false;
        }
    }
    //--------------------------------------------------------------------------------
    private func loadUserAlertaColheitaPronta() -> Bool {
        let opt: Bool? =  userDefaults.boolForKey( "userAlertColheitaPronta" );

        if opt != nil{
            return opt!;
        }
        else {
            return false;
        }
    }
    //--------------------------------------------------------------------------------
    private func loadUserAlertColheitaRegar() -> Bool {
        let opt: Bool? = userDefaults.boolForKey( "userAlertColheitaRegar" );

        if opt != nil{
            return opt!;
        }
        else {
            return false;
        }
    }
    //--------------------------------------------------------------------------------
    private func loadUserAlertColheitaAdubar() -> Bool {
        let opt: Bool? = userDefaults.boolForKey( "userAlertColheitaAdubar" );
        print( "carregando colheita regar: \(opt)" );
        if opt != nil{
            return opt!;
        }
        else {
            return false;
        }
    }
    //--------------------------------------------------------------------------------
}