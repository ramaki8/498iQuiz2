//
//  SettingsViewController.swift
//  498iQuiz2
//
//  Created by Rachel Kipps on 11/19/15.
//  Copyright © 2015 Rachel Kipps. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var urlField: UITextField!
    
    var newQuiz = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlField.text = "http://tednewardsandbox.site44.com/questions.json"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func pressDone(sender: UIBarButtonItem) {
        let nav = self.navigationController as! QuizNavViewController
        for (var i = 0; i < self.navigationController?.viewControllers.count; i++) {
            let vc = nav.viewControllers[i]
            if vc.isKindOfClass(QuizTableViewController) {
                let quizVC = vc as! QuizTableViewController
                //do any var assignments
                nav.popToViewController(quizVC, animated: true)
            }
        }
    }
    
    @IBAction func downloadQuizzes(sender: AnyObject) {
        
        let newURL = self.urlField.text
        let sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: sessionConfiguration, delegate: nil, delegateQueue: nil)
        let URL = NSURL(string: newURL!)
        let req = NSMutableURLRequest(URL: URL!)
        req.HTTPMethod = "GET"
        let task = session.dataTaskWithRequest(req) { (data, response, error) -> Void in
            let statusCode = (response as! NSHTTPURLResponse).statusCode
            print("URL Session Task Succeeded: HTTP \(statusCode)")
            
            do {
                self.newQuiz = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! [AnyObject]

                let navController : QuizNavViewController = self.view.window?.rootViewController as! QuizNavViewController
                navController.newQuiz = self.newQuiz as NSArray as [AnyObject]
                
            } catch let error as NSError {
                print("Failed to load : \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
