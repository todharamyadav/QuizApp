//
//  HomeViewController.swift
//  Physics Quiz
//
//  Created by Dharamvir on 9/14/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleToFill
        imageView.backgroundColor = UIColor.redColor()
        return imageView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width/2
        profileImageView.clipsToBounds = true
    }
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start", forState: .Normal)
        button.backgroundColor = UIColor.redColor()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sendToQuiz), forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var recordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Records", forState: .Normal)
        button.backgroundColor = UIColor.redColor()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(sendToQuiz), forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var logOutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log Out", forState: .Normal)
        button.backgroundColor = UIColor.redColor()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(handleLogOut), forControlEvents: .TouchUpInside)
        return button
    }()
    
    func sendToQuiz(){
        let controller = QuizViewController()
        let navController = UINavigationController(rootViewController: controller)
        self.presentViewController(navController, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "Background_Home")!)
        
        view.addSubview(startButton)
        view.addSubview(recordButton)
        view.addSubview(logOutButton)
        view.addSubview(profileImageView)
        
        view.addConstraintsWithFormat("H:[v0(250)]", views: startButton)
        view.addConstraintsWithFormat("H:[v0(250)]", views: recordButton)
        view.addConstraintsWithFormat("H:[v0(250)]", views: logOutButton)
        view.addConstraintsWithFormat("H:[v0(250)]", views: profileImageView)
        
        view.addConstraintsWithFormat("V:|-100-[v0(250)]-10-[v1(40)]-10-[v2(40)]-10-[v3(40)]", views: profileImageView, startButton, recordButton, logOutButton)
        NSLayoutConstraint(item: startButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: recordButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: logOutButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        NSLayoutConstraint(item: profileImageView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0).active = true
        
        if let user = FIRAuth.auth()?.currentUser{
            let photoUrl = user.photoURL
            let uid = user.uid
            
            let data = NSData(contentsOfURL: photoUrl!)
            self.profileImageView.image = UIImage(data: data!)
        }
    }
    
    func handleLogOut(){
        
        //sign out of Firebase
        try! FIRAuth.auth()!.signOut()
        
        //sign out of facebook
        FBSDKAccessToken.setCurrentAccessToken(nil)
        
        let loginController = LoginViewController()
        presentViewController(loginController, animated: true, completion: nil)

    }
    
    
}


extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...){
        var viewsDictionary = [String:  UIView]()
        for (index,view) in views.enumerate(){
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

