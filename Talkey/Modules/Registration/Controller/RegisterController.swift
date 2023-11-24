//
//  ViewController.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//

import UIKit
import Firebase

class RegisterController: UIViewController {
    
    // MARK: - Views
    
    private let registerView: RegisterView
    
    // MARK: - Init
    
    init() {
        self.registerView = RegisterView()
        super.init(nibName: nil, bundle: nil)
        registerView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appoint registerView as view
    
    override func loadView() {
        super.loadView()
        self.view = registerView
        navigationController?.setupAppearance(with: UIColor.brandPurple)
    }
    
    private func showAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.showAlert(error: e.localizedDescription)
            } else {
                let chatController = ChatController()
                self.navigationController?.pushViewController(chatController, animated: true)
            }
        }
    }
}

extension RegisterController: RegisterViewDelegate {
    func registerButtonIsTapped(email: String, password: String) {
        createUser(email: email, password: password)
    }
}

