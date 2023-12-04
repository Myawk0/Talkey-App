//
//  UIViewController.swift
//  Talkey
//
//  Created by Мявкo on 28.11.23.
//

import UIKit

extension UIViewController {
    
    func showAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
