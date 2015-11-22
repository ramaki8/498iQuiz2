//
//  QuizTableViewController.swift
//  498iQuiz2
//
//  Created by Rachel Kipps on 11/12/15.
//  Copyright © 2015 Rachel Kipps. All rights reserved.
//

import UIKit

struct Question {
    var question: String
    var answers: [String]
    var correctAnswer: String
}

class QuizTableViewController: UITableViewController {
    
    var quizNames = [String]()
    let quizImages = [UIImage(named: "math"), UIImage(named: "science"), UIImage(named: "marvel")]
    var quizDescriptions = [String]()
    
    var MathQuiz = [Question]()
    var ScienceQuiz = [Question]()
    var MarvelQuiz = [Question]()
    
//    let quizNames = ["Math", "Science", "Marvel"]

//    let quizDescriptions = ["Add, subtract, multiply and divide.", "Test your scientific knowledge.", "Up, up and away!"]
//    
//    let MathQuiz = [Question(question: "2+2", answers: ["4", "5", "6", "7"], correctAnswer: "4"), Question(question: "3+3", answers: ["5", "6", "7", "8"], correctAnswer: "6"), Question(question: "2*2", answers: ["1", "2", "3", "4"], correctAnswer: "4"), Question(question: "100 / 2", answers: ["10", "50", "25", "100"], correctAnswer: "50")]
//    
//    let ScienceQuiz = [Question(question: "What is the largest type of big cat in the world?", answers: ["Cougar", "Tiger", "Panther", "Lion"], correctAnswer: "Tiger"), Question(question: "What is the closest planet to the Sun?", answers: ["Mercury", "Earth", "Mars", "Jupiter"], correctAnswer: "Mercury"), Question(question: "What is the first element on the periodic table?", answers: ["Helium", "Hydrogen", "Oxygen", "Gold"], correctAnswer: "Hydrogen"), Question(question: "What is the outermost layer of the atmosphere called?", answers: ["Troposphere", "Stratosphere", "Thermosphere", "Mesosphere"], correctAnswer: "Thermosphere")]
//    
//    let MarvelQuiz = [Question(question: "Who is Thor's brother?", answers: ["Loki", "Captain America", "Hulk", "Iron Man"], correctAnswer: "Loki"), Question(question: "What is Black Widow's real name?", answers: ["Anastasia Smirnov", "Natalia Ivanov", "Natasha Romanova", "Valentina Matviyenko"], correctAnswer: "Natasha Romanova"), Question(question: "Who killed Gwen Stacy?", answers: ["Hobgoblin", "Green Goblin", "Vulture", "Doctor Octopus"], correctAnswer: "Green Goblin"), Question(question: "What are Wolverine's claws made of?", answers: ["Bone", "Titanium", "Adamantium", "Steel"], correctAnswer: "Adamantium")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = "Select a quiz!"

    }
    
    override func viewWillAppear(animated: Bool) {
        quizNames = []
        quizDescriptions = []
        MathQuiz = []
        ScienceQuiz = []
        MarvelQuiz = []
        
        let navVC = self.navigationController as! QuizNavViewController
        
        let jsonObj = navVC.newQuiz
        
        
        if jsonObj.count < 1 {
            quizNames = ["Math", "Science", "Marvel"]
            quizDescriptions = ["Add, subtract, multiply and divide.", "Test your scientific knowledge.", "Up, up and away!"]
            MathQuiz = [Question(question: "2+2", answers: ["4", "5", "6", "7"], correctAnswer: "4"), Question(question: "3+3", answers: ["5", "6", "7", "8"], correctAnswer: "6"), Question(question: "2*2", answers: ["1", "2", "3", "4"], correctAnswer: "4"), Question(question: "100 / 2", answers: ["10", "50", "25", "100"], correctAnswer: "50")]
            ScienceQuiz = [Question(question: "What is the largest type of big cat in the world?", answers: ["Cougar", "Tiger", "Panther", "Lion"], correctAnswer: "Tiger"), Question(question: "What is the closest planet to the Sun?", answers: ["Mercury", "Earth", "Mars", "Jupiter"], correctAnswer: "Mercury"), Question(question: "What is the first element on the periodic table?", answers: ["Helium", "Hydrogen", "Oxygen", "Gold"], correctAnswer: "Hydrogen"), Question(question: "What is the outermost layer of the atmosphere called?", answers: ["Troposphere", "Stratosphere", "Thermosphere", "Mesosphere"], correctAnswer: "Thermosphere")]
            MarvelQuiz = [Question(question: "Who is Thor's brother?", answers: ["Loki", "Captain America", "Hulk", "Iron Man"], correctAnswer: "Loki"), Question(question: "What is Black Widow's real name?", answers: ["Anastasia Smirnov", "Natalia Ivanov", "Natasha Romanova", "Valentina Matviyenko"], correctAnswer: "Natasha Romanova"), Question(question: "Who killed Gwen Stacy?", answers: ["Hobgoblin", "Green Goblin", "Vulture", "Doctor Octopus"], correctAnswer: "Green Goblin"), Question(question: "What are Wolverine's claws made of?", answers: ["Bone", "Titanium", "Adamantium", "Steel"], correctAnswer: "Adamantium")]
        } else {
            let jsonObject = navVC.newQuiz as NSArray
            
            for subject in jsonObject {
                let title = subject["title"]! as! String
                quizNames.append(title)
                let desc = subject["desc"] as! String
                quizDescriptions.append(desc)
                let questions = subject["questions"]
                
                for q in questions as! NSArray {
                    let answers = q["answers"] as! [String]
                    let correctAnsIndex = q["answer"] as! String
                    let correctAns = answers[Int(correctAnsIndex)! - 1]
                    let text = q["text"] as! String
                    
                    switch title {
                        case "Science!":
                            ScienceQuiz.append(Question(question: text, answers: answers, correctAnswer: correctAns))
                        case "Marvel Super Heroes":
                            MarvelQuiz.append(Question(question: text, answers: answers, correctAnswer: correctAns))
                        case "Mathematics":
                            MathQuiz.append(Question(question: text, answers: answers, correctAnswer: correctAns))
                    default: break
                        
                    }
                    
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.quizNames.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("quizCell", forIndexPath: indexPath) as! QuizCell
        
        cell.quizTitle.text = self.quizNames[indexPath.row]
        cell.quizImage.image = self.quizImages[indexPath.row]
        cell.quizDescription.text = self.quizDescriptions[indexPath.row]
        

        // Configure the cell...

        return cell
    }
    
    
//    @IBAction func pressSettings(sender: AnyObject) {
//        let alertController = UIAlertController(title: "Settings", message: "Settings go here", preferredStyle: UIAlertControllerStyle.Alert)
//        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
//        
//        self.presentViewController(alertController, animated: true, completion: nil)
//    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toQuestion" {
            let cell = sender as! QuizCell
            let questionVC = segue.destinationViewController as! QuestionViewController
            questionVC.currentQuestion = 1
            switch cell.quizTitle.text! {
            case "Math" :
                questionVC.questions = self.MathQuiz
                questionVC.navigationItem.title = "Math Quiz"
            case "Science" :
                questionVC.questions = self.ScienceQuiz
                questionVC.navigationItem.title = "Science Quiz"
            case "Marvel" :
                questionVC.questions = self.MarvelQuiz
                questionVC.navigationItem.title = "Marvel Quiz"
            default: break
            }
        }
        
    }

}
