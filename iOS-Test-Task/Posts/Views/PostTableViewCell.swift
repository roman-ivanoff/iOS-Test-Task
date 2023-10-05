//
//  PostTableViewCell.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import UIKit

enum ExpandButtonState  {
    case show
    case hide
}

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    @IBOutlet weak var buttonHeight: NSLayoutConstraint!
    private let btnHeight = 42.0
    var expandActionCallback: (() -> ())?
    private let helper = Helper()
    private let maxNumberOfLines =  2
    
    var expandButtonState: ExpandButtonState = .hide {
        didSet {
            if expandButtonState == .hide {
                expandButton.isHidden = true
                buttonHeight.constant = 0
            } else {
                expandButton.isHidden = false
                buttonHeight.constant = btnHeight
            }
        }
    }

    var isExpanded = false {
        didSet {
            if isExpanded == false {
                postTextLabel.numberOfLines = 2
                expandButton.setTitle("Expand", for: .normal)
            } else {
                postTextLabel.numberOfLines = 0
                expandButton.setTitle("Collapse", for: .normal)
            }
        }
    }
    
    func configure(post: PostItem) {
        expandButtonState = .hide
        
        daysLabel.text = "\(helper.getPastDays(pastDate: helper.getDateByTimestamp(timestamp: post.timeshamp))) days ago"
        likesLabel.text = String(post.likesCount)
        postTextLabel.text = post.previewText
        titleLabel.text = post.title
        
        if postTextLabel.maxNumberOfLines > self.maxNumberOfLines {
            expandButtonState = .show
        }
    }
    
    @IBAction func expandAction(_ sender: UIButton) {
        expandActionCallback?()
    }
}
