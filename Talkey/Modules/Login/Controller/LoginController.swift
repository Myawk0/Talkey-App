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
    
    private func showAlert(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
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

extension LoginController: LoginViewDelegate {
    func loginButtonIsTapped(email: String, password: String) {
        signInUser(email: email, password: password)
    }
}

