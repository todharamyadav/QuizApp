//
//  QuizViewController.swift
//  Physics Quiz
//
//  Created by Dharamvir on 9/14/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit
import Firebase

class QuizViewController: UIViewController {
    
    var questions = [QuizQuestion]()
    var attributedText = NSMutableAttributedString()
    var index = 0
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFontOfSize(36)
        label.textAlignment = .Center
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.adjustsFontSizeToFitWidth = true
        label.textColor = UIColor.whiteColor()
        return label
    }()
    
    lazy var option1Button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 26/255, green: 175/255, blue: 226/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(option1Clicked), forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var option2Button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 26/255, green: 175/255, blue: 226/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(option2Clicked), forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var option3Button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 26/255, green: 175/255, blue: 226/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(option3Clicked), forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var option4Button: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 26/255, green: 175/255, blue: 226/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(option4Clicked), forControlEvents: .TouchUpInside)
        return button
    }()
    
    lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", forState: .Normal)
        button.addTarget(self, action: #selector(nextButtonClicked), forControlEvents: .TouchUpInside)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 255/255, green: 235/255, blue: 205/255, alpha: 1)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeQuestion()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(dismissController))
        
        view.addSubview(questionLabel)
        view.addSubview(option1Button)
        view.addSubview(option2Button)
        view.addSubview(option3Button)
        view.addSubview(option4Button)
        view.addSubview(nextButton)
        
        view.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: questionLabel)
        view.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: option1Button)
        view.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: option2Button)
        view.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: option3Button)
        view.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: option4Button)
        view.addConstraintsWithFormat("H:|-10-[v0]-10-|", views: nextButton)
        
        
        view.addConstraintsWithFormat("V:|-65-[v0(120)]-3-[v1(60)]-3-[v2(60)]-3-[v3(60)]-3-[v4(60)]-10-[v5(40)]", views: questionLabel, option1Button,option2Button, option3Button, option4Button, nextButton)
        
    }
    
    func dismissController(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
