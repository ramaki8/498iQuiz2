//
//  FinishedViewController.swift
//  498iQuiz2
//
//  Created by Rachel Kipps on 11/15/15.
//  Copyright © 2015 Rachel Kipps. All rights reserved.
//

import UIKit

class FinishedViewController: UIViewController {
    
    @IBOutlet weak var finishedLabel: UILabel!
    
    var questions = [Question]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        let nav = self.navigationController as! QuizNavViewController
        let totalCorrect = nav.totalCorrect
        switch totalCorrect {
        case questions.count:
            finishedLabel.text = "Perfect Score! You got \(totalCorrect) out of \(questions.count)!"
        case questions.count - 1, questions.count - 2:
            finishedLabel.text = "Almost There! You got \(totalCorrect) out of \(questions.count)!"
        default:
            finishedLabel.text = "Better luck next time. :( You got \(totalCorrect) out of \(questions.count)."
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pressNext(sender: UIButton) {
        let nav = self.navigationController as! QuizNavViewController
        nav.totalCorrect = 0
        nav.popToRootViewControllerAnimated(true)
    }
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
*/
}
