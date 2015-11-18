//
//  QuestionViewController.swift
//  498iQuiz2
//
//  Created by Rachel Kipps on 11/14/15.
//  Copyright © 2015 Rachel Kipps. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var questions = [Question]()
    var selectedAnswer = String()
    var correctAnswer = String()
    var currentQuestion = Int()
    

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer1: UIButton!
    @IBOutlet weak var answer2: UIButton!
    @IBOutlet weak var answer3: UIButton!
    @IBOutlet weak var answer4: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        questionLabel.text = questions[currentQuestion - 1].question
        self.navigationItem.hidesBackButton = true
        
        let q = self.questions[currentQuestion - 1]
        answer1.setTitle(q.answers[0], forState: UIControlState.Normal)
        answer2.setTitle(q.answers[1], forState: UIControlState.Normal)
        answer3.setTitle(q.answers[2], forState: UIControlState.Normal)
        answer4.setTitle(q.answers[3], forState: UIControlState.Normal)
        
        for button in self.view.subviews {
            if button.isKindOfClass(UIButton) {
                let b = button as! UIButton
                b.addTarget(self, action: "moveToAnswer:", forControlEvents: UIControlEvents.TouchUpInside)
            }
        }
    }
    
    func moveToAnswer(sender: UIButton) {
        self.performSegueWithIdentifier("toAnswer", sender: sender)
    }

    @IBAction func pressQuit(sender: AnyObject) {
        let nav = self.navigationController as! QuizNavViewController
        nav.popToRootViewControllerAnimated(true)
        nav.totalCorrect = 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let answerVC = segue.destinationViewController as! AnswerViewController
        let button = sender as! UIButton
        
        answerVC.currentQuestion = self.currentQuestion
        answerVC.selectedAnswer = (button.titleLabel?.text)!
        answerVC.correctAnswer = self.questions[currentQuestion - 1].correctAnswer
        answerVC.questions = self.questions
    }

}
