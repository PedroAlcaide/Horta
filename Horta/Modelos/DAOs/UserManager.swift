//
//  UserManager.swift
//  Mini Challenge II
//
//  Created by Joao Sisanoski on 5/21/15.
//  Copyright (c) 2015 RJG. All rights reserved.
//
/*
import Foundation
protocol UserManagerDelegate{
    func signInResult(result : Bool)
    func signUpResult(result : Bool)
    func errorThrowed(error : NSError)
    func updateSuccesfull()
}
class UserManager : UserDAOCKDelegate, UserDAODDelegate{

    var delegate: UserManagerDelegate?
    var userDefaults : UserDAODefaults
    var userCloudKit : UserDAOCloudKit
    init(){
        userDefaults = DaoFactory().getUserDAODefaults()
        userCloudKit = DaoFactory().getUserDAOCloudKit()
        userCloudKit.delegate = self
        userDefaults.delegate = self
    }
    func getUserWithPassword(user : User , password : String){
    
    }
    func saveUserFinished(validate : Bool , user : User!){
        if validate {
            self.startSeletor(Selector("self.delegate?.signUpResult(nil)"))
            
        }
        self.startSeletor(Selector("self.delegate?.signUpResult(validate)"))

        
    }
    func getUserFinished(user : User! ){
        if user != nil {
            self.startSeletor(Selector("self.delegate?.signUpResult(true)"))
        }
        else {
            self.startSeletor(Selector("self.delegate?.signUpResult(false)"))

        }
    }
    func errorThrowed(error : NSError){
        self.startSeletor(Selector("self.delegate?.errorThrowed(error)"))

    }
    func updateSuccesfull(){
        self.startSeletor(Selector("self.delegate?.updateSuccesfull()"))
        

    }
    func saveUser(user : User){
        self.startSeletor(Selector("self.userCloudKit.updateUser(user)"))
        

        
    }
    func createUser (user : User){
        self.startSeletor(Selector("self.userCloudKit.createUser(user"))

    }
    func signInValidate(email : String , password : String){
        self.startSeletor(Selector("self.userCloudKit.getUserWithEmail(email, password: password"))
        

    }
    func getLoggedUser() -> User{
        return self.userDefaults.getUserLogged()
    }
    func startSeletor (selector : Selector){
        dispatch_async(dispatch_get_main_queue(), {
           selector
        })
    }
}
//
//
//@interface UserManager : NSObject<UserDAODelegate>
//{
//    UserDAOCloudKit *model;
//    DataValidator *validator;
//    UserDAONSDefaults *modelDefaults;
//}
//
//
//@property (weak, nonatomic) id<UserManagerDelegate> delegate;
//
//-(void)passwordValidate:(NSString*)password confirmPassword:(NSString*)confirmPassword;
//-(void)nameValidate:(NSString*)name;
//- (void)passwordValidate:(NSString *)password;
//-(void)getUserWithID:(CKRecordID*)userId;
//@end

*/
