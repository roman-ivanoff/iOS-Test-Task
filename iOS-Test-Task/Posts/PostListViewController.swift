//
//  ViewController.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import UIKit

class PostListViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    private let postListModel = PostListModel()
    private var cellsState = [Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        fetchPosts()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "postCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func fetchPosts() {
        postListModel.fetchPosts { [weak self] _ in
            guard let self else { return }
            
            self.toggleActivityIndicator(activityIndicator: self.activityIndicator, isLoading: postListModel.isLoading)
            self.cellsState = [Bool](repeating: false, count: self.postListModel.posts.count)
            self.tableView.reloadData()
        } onError: { [weak self] error in
            guard let self else { return }
            self.toggleActivityIndicator(activityIndicator: self.activityIndicator, isLoading: self.postListModel.isLoading)
            self.showAlert(title: "Something went wrong", message: "Please, try again later")
        }
    }
    
    @IBAction func sortByRating(_ sender: UIBarButtonItem) {
        postListModel.posts.sort(by: { $0.likesCount > $1.likesCount })
        tableView.reloadData()
    }
    
    @IBAction func sortByDate(_ sender: UIBarButtonItem) {
        postListModel.posts.sort(by: { $0.timeshamp > $1.timeshamp })
        tableView.reloadData()
    }
    
}

extension PostListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        postListModel.postId = postListModel.posts[indexPath.row].id
        performSegue(withIdentifier: "postId", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let postDetailsVC = segue.destination as! PostDetailViewController
        guard let postId = postListModel.postId else { return }
        postDetailsVC.postDetailModel.postId = postId
    }
}

extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        postListModel.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if let postCell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostTableViewCell {
            postCell.configure(post: postListModel.posts[indexPath.row])
            postCell.isExpanded = self.cellsState[indexPath.row]
            postCell.expandActionCallback = {
                postCell.isExpanded = self.cellsState[indexPath.row]
                self.cellsState[indexPath.row] = !self.cellsState[indexPath.row]
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            cell = postCell
        }
        
        return cell
    }
}
