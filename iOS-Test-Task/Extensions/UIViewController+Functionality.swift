//
//  UIViewController+Functionality.swift
//  iOS-Test-Task
//
//  Created by Roman Ivanov on 05.10.2023.
//

import UIKit

extension UIViewController {
    func toggleActivityIndicator(activityIndicator: UIActivityIndicatorView, isLoading: Bool) {
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
