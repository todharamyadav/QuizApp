//
//  QuizViewControllerHandler.swift
//  Physics Quiz
//
//  Created by Dharamvir on 9/24/16.
//  Copyright © 2016 Dharamvir. All rights reserved.
//

import UIKit
import Firebase

extension QuizViewController{
    
    func loadQuestions(questionNo: String, question: String, option1: String, option2: String, option3: String, option4: String, correctAnswer: String){
        let ref = FIRDatabase.database().reference().child("Questions")
        let questionN = ref.child(questionNo)
        
        let values = ["question": question, "option1": option1, "option2": option2, "option3": option3, "option4": option4, "correctAnswer": correctAnswer]
        questionN.updateChildValues(values)
    }
    
    func observeQuestion(){
        let ref = FIRDatabase.database().reference().child("Questions")
        ref.observeEventType(.ChildAdded, withBlock: { (snapshot) in
            
            let questionID = snapshot.key
            let questionRef = ref.child(questionID)
            questionRef.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    let quizQuestion = QuizQuestion()
                    quizQuestion.setValuesForKeysWithDictionary(dictionary)
                    self.questions.append(quizQuestion)
                    print(self.questions.count)
                    
                    if (self.questions.count == 25){
                        dispatch_async(dispatch_get_main_queue(),{
                            //print(self.questions.count)
                            self.questionLabel.text = self.questions[self.index].question
                            self.option1Button.setTitle(self.questions[self.index].option1, forState: .Normal)
                            self.option2Button.setTitle(self.questions[self.index].option2, forState: .Normal)
                            self.option3Button.setTitle(self.questions[self.index].option3, forState: .Normal)
                            self.option4Button.setTitle(self.questions[self.index].option4, forState: .Normal)
                        })
                    }
                    

                }
                }, withCancelBlock: nil)
            }, withCancelBlock: nil)
    }
    
    func option1Clicked(){
        nextButton.enabled = true
        nextButton.backgroundColor = UIColor(red: 139/255, green: 69/255, blue: 19/255, alpha: 1)
        buttonEnabled(false)

        if option1Button.titleForState(.Normal) == questions[index].correctAnswer{
            option1Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

        }else{
            option1Button.backgroundColor = UIColor.redColor()
            if option2Button.titleForState(.Normal) == questions[index].correctAnswer{
                option2Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
            if option3Button.titleForState(.Normal) == questions[index].correctAnswer{
                option3Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
            if option4Button.titleForState(.Normal) == questions[index].correctAnswer{
                option4Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
        }
    }
    
    func option2Clicked(){
        nextButton.enabled = true
        nextButton.backgroundColor = UIColor(red: 139/255, green: 69/255, blue: 19/255, alpha: 1)

        buttonEnabled(false)
        
        if option2Button.titleForState(.Normal) == questions[index].correctAnswer{
            option2Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

        }else{
            option2Button.backgroundColor = UIColor.redColor()
            if option1Button.titleForState(.Normal) == questions[index].correctAnswer{
                option1Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
            if option3Button.titleForState(.Normal) == questions[index].correctAnswer{
                option3Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
            if option4Button.titleForState(.Normal) == questions[index].correctAnswer{
                option4Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
        }
    }
    
    func option3Clicked(){
        nextButton.enabled = true
        nextButton.backgroundColor = UIColor(red: 139/255, green: 69/255, blue: 19/255, alpha: 1)

        buttonEnabled(false)
        
        if option3Button.titleForState(.Normal) == questions[index].correctAnswer{
            option3Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

        }else{
            option3Button.backgroundColor = UIColor.redColor()
            if option2Button.titleForState(.Normal) == questions[index].correctAnswer{
                option2Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
            if option1Button.titleForState(.Normal) == questions[index].correctAnswer{
                option1Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
            if option4Button.titleForState(.Normal) == questions[index].correctAnswer{
                option4Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
        }
    }
    
    func option4Clicked(){
        nextButton.enabled = true
        nextButton.backgroundColor = UIColor(red: 139/255, green: 69/255, blue: 19/255, alpha: 1)

        buttonEnabled(false)
        
        if option4Button.titleForState(.Normal) == questions[index].correctAnswer{
            option4Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

        }else{
            option4Button.backgroundColor = UIColor.redColor()
            if option2Button.titleForState(.Normal) == questions[index].correctAnswer{
                option2Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
            if option3Button.titleForState(.Normal) == questions[index].correctAnswer{
                option3Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
            if option1Button.titleForState(.Normal) == questions[index].correctAnswer{
                option1Button.backgroundColor = UIColor(red: 50/255, green: 205/255, blue: 50/255, alpha: 1)

            }
        }
    }
    
    func nextButtonClicked(){
        if index == 24{
            dismissViewControllerAnimated(true, completion: nil)
        }else{
            index = index+1
            
            nextButton.enabled = false
            nextButton.backgroundColor = UIColor(red: 255/255, green: 235/255, blue: 205/255, alpha: 1)
            if index == 24{
                nextButton.setTitle("Finish", forState: .Normal)
            }
            
            buttonEnabled(true)
            option1Button.backgroundColor = UIColor(red: 26/255, green: 175/255, blue: 226/255, alpha: 1)
            option2Button.backgroundColor = UIColor(red: 26/255, green: 175/255, blue: 226/255, alpha: 1)
            option3Button.backgroundColor = UIColor(red: 26/255, green: 175/255, blue: 226/255, alpha: 1)
            option4Button.backgroundColor = UIColor(red: 26/255, green: 175/255, blue: 226/255, alpha: 1)
            
            self.questionLabel.text = self.questions[self.index].question
            self.option1Button.setTitle(self.questions[self.index].option1, forState: .Normal)
            self.option2Button.setTitle(self.questions[self.index].option2, forState: .Normal)
            self.option3Button.setTitle(self.questions[self.index].option3, forState: .Normal)
            self.option4Button.setTitle(self.questions[self.index].option4, forState: .Normal)
        }
        
        
    }
    
    func buttonEnabled(enable: Bool){
        option1Button.enabled = enable
        option2Button.enabled = enable
        option3Button.enabled = enable
        option4Button.enabled = enable
    }
    
}
