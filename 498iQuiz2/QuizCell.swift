//
//  QuizCell.swift
//  498iQuiz2
//
//  Created by Rachel Kipps on 11/12/15.
//  Copyright © 2015 Rachel Kipps. All rights reserved.
//

import UIKit

class QuizCell: UITableViewCell {

    
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var quizTitle: UILabel!
    @IBOutlet weak var quizDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
