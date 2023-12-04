//
//  LoginController.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    // MARK: - Views
    
    private let loginView: LoginView
    
    // MARK: - Init
    
    init() {
        self.loginView = LoginView()
        super.init(nibName: nil, bundle: nil)
        loginView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appoint loginView as view
    
    override func loadView() {
        super.loadView()
        self.view = loginView
        navigationController?.setupAppearance(with: .white)
    }
    
    // MARK: - Method to Sign In
    
    private func signInUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let e = error {
                self.showAlert(error: e.localizedDescription)
            } else {
                let chatController = ChatController()
                self.navigationController?.pushViewController(chatController, animated: true)
            }
        }
    }
}

// MARK: - LoginViewDelegate

extension LoginController: LoginViewDelegate {
    func loginButtonIsTapped(email: String, password: String) {
        signInUser(email: email, password: password)
    }
}

