//
//  AnswerViewController.swift
//  498iQuiz2
//
//  Created by Rachel Kipps on 11/14/15.
//  Copyright © 2015 Rachel Kipps. All rights reserved.
//

import UIKit


class AnswerViewController: UIViewController {
    

    @IBOutlet weak var correctLabel: UILabel!
    @IBOutlet weak var yourAnswer: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    var correctAnswer = String()
    var selectedAnswer = String()
    var currentQuestion = Int()
    var questions = [Question]()
    var quizType = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        finishButton.enabled = false

        if selectedAnswer == correctAnswer {
            self.correctLabel.text = "Correct!"
            self.yourAnswer.text = "You chose \(self.selectedAnswer). Good job!"
            let nav = self.navigationController as! QuizNavViewController
            nav.totalCorrect++
        } else {
            self.correctLabel.text = "Incorrect."
            self.yourAnswer.text = "You chose \(self.selectedAnswer), but the correct answer was \(correctAnswer)."
        }
        if currentQuestion == questions.count {
            finishButton.enabled = true
            continueButton.enabled = false
        }
    }

    @IBAction func pressContinue(sender: UIButton) {
        let nav = self.navigationController as! QuizNavViewController
        for (var i = 0; i < self.navigationController?.viewControllers.count; i++) {
            let vc = nav.viewControllers[i]
            if(vc.isKindOfClass(QuestionViewController)) {
                let questionVC = vc as! QuestionViewController
                questionVC.questions = self.questions
                questionVC.currentQuestion = self.currentQuestion + 1
                
                nav.popToViewController(vc as! QuestionViewController, animated: true)
                
                break;
            }
        }
    }
    @IBAction func pressQuit(sender: UIBarButtonItem) {
        let nav = self.navigationController as! QuizNavViewController
        nav.popToRootViewControllerAnimated(true)
        nav.totalCorrect = 0
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if sender?.titleLabel!!.text == "Continue" {
//            let vc = segue.destinationViewController as! QuestionViewController
//            vc.questions = self.questions
//            vc.currentQuestion = self.currentQuestion + 1
          if sender?.titleLabel!!.text == "Finish" {
            let vc = segue.destinationViewController as! FinishedViewController
            vc.navigationItem.title = "\(self.quizType) Results"
            vc.questions = self.questions
        }
    }

}
