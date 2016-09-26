//
//  LoginViewController.swift
//  Physics Quiz
//
//  Created by Dharamvir on 9/25/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
    lazy var loginButton: FBSDKLoginButton = {
        let button = FBSDKLoginButton()
        button.delegate = self
        button.readPermissions = ["public_profile", "email", "user_friends"]
        return button
    }()
    
    let loadingSpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = UIColor.redColor()
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.hidden = true
        
        view.backgroundColor = UIColor.whiteColor()
        
        
        FIRAuth.auth()?.addAuthStateDidChangeListener({ (auth, user) in
            if let user = user{
                let homeController = HomeViewController()
                self.presentViewController(homeController, animated: true, completion: nil)
            }else{
                self.view.addSubview(self.loginButton)
                self.view.addSubview(self.loadingSpinner)
                self.loginButton.center = self.view.center
                self.loadingSpinner.center = self.view.center
                self.loginButton.hidden = false
            }
        })

    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
        self.loginButton.hidden = true
        loadingSpinner.startAnimating()
        
        if error != nil{
            self.loginButton.hidden = false
            loadingSpinner.stopAnimating()
        }else if(result.isCancelled){
            self.loginButton.hidden = false
            loadingSpinner.stopAnimating()
        }else{
            let credentials = FIRFacebookAuthProvider.credentialWithAccessToken(FBSDKAccessToken.currentAccessToken().tokenString)
            FIRAuth.auth()?.signInWithCredential(credentials, completion: { (user, error) in
                print("User logged in to Firebase")
            })
        }
        
        
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("user log out")
    }
}
