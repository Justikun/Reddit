//
//  UIViewControllerExtension.swift
//  Reddit
//
//  Created by Justin Lowry on 1/5/22.
//

import Foundation
import UIKit

extension UIViewController {
    func presentErrorToUser(localizedError: LocalizedError) {
        let alertController = UIAlertController(title: "ERROR", message: localizedError.errorDescription, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel)
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true)
    }
}
