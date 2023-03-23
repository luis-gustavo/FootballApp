//
//  UIViewController+showAlert.swift
//  FootballApp
//
//  Created by Luis Gustavo on 22/03/23.
//

import UIKit

extension UIViewController {
    func showAlert(with title: String, message: String, animated: Bool = true) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let alertAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(alertAction)
        present(alertController, animated: animated, completion: nil)
    }
}
