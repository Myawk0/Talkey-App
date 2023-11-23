//
//  Extension.swift
//  Flash Chat
//
//  Created by Мявкo on 26.09.23.
//

import UIKit
import Firebase

extension UINavigationController {
    
    func setupAppearance(with color: UIColor?) {
        navigationBar.tintColor = color
        let backButtonAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color ?? .systemBlue
        ]
        UIBarButtonItem.appearance().setTitleTextAttributes(backButtonAttributes, for: .normal)
    }
    
    func setupTitle() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationBar.standardAppearance = appearance;
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        navigationBar.isTranslucent = true
        navigationBar.barTintColor = .brandBlue
        let titleLabel = UILabel()
        titleLabel.text = K.appName
        titleLabel.textColor = .brandBlue
        titleLabel.font = .systemFont(ofSize: 25, weight: .black)
        topViewController?.navigationItem.titleView = titleLabel
    }
    
    func setupLogOutButton() {
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonIsTapped))
        logOutButton.tintColor = .brandBlue
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 17, weight: .medium)
        ]
        logOutButton.setTitleTextAttributes(attributes, for: .normal)

        topViewController?.navigationItem.rightBarButtonItem = logOutButton
    }
    
    @objc func logOutButtonIsTapped() {
        do {
            try Auth.auth().signOut()
            popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
