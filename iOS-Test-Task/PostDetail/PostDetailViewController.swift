//
//  PostDetailViewController.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import UIKit
import Kingfisher

class PostDetailViewController: UIViewController {
    @IBOutlet weak var heartImage: UIImageView!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likesLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    
    let postDetailModel = PostDetailModel()
    private let helper = Helper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPost()
    }
    
    private func getPost() {
        postDetailModel.fetchPostDetails { [weak self] result in
            guard let self else { return }
            setupUI()
        } onError: { [weak self] error in
            guard let self else { return }
            self.showAlert(title: "Something went wrong", message: "Please, try again later")
        }
    }
    
    private func setupUI() {
        guard let post = postDetailModel.postDetails else { return }
        loadImage(url: URL(string: post.postImage))
        DispatchQueue.main.async {
            self.titleLabel.text = post.title
            self.postTextLabel.text = post.text
            
            let date = self.helper.getDateByTimestamp(timestamp: post.timeshamp)
            let calendarDate = Calendar.current
            self.daysLabel.text = "\(calendarDate.component(.day, from: date)) \(date.month) \(calendarDate.component(.year, from: date))"
            
            self.likesLabel.text = String(post.likesCount)
            self.heartImage.isHidden = false
        }
    }
    
    private func loadImage(url: URL?) {
        guard let url = url else { return }
        let resource = KF.ImageResource(downloadURL: url, cacheKey: url.absoluteString)
        postImage.kf.indicatorType = .activity
        
        postImage.kf.setImage(
            with: resource,
            options: [
                .transition(.fade(0.7)),
                .cacheOriginalImage
            ]
        )
    }
}
