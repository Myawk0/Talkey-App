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
    private let db = Firestore.firestore()
    
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
        navigationController?.setupAppearance(with: .brandBlue)
    }
    
    // MARK: - Validate Text Fields
    
    private func validateTextFields(username: String?, email: String?, password: String?, completion: @escaping (AuthResult) -> Void) {
        
        guard let username = username, let email = email, let password = password else {
            completion(.failure(AuthError.unknownError))
            return
        }

        guard Validators.isFilled(username: username, email: email, password: password) else {
            completion(.failure(AuthError.notFilled))
            return
        }

        guard Validators.isSimpleEmail(email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
    }
    
    // MARK: - Register User
    
    private func register(username: String, email: String, password: String) {
        validateTextFields(username: username, email: email, password: password) { result in
            switch result {
            case .success:
                self.createUser(username: username, email: email, password: password)
            case .failure(let error):
                self.showAlert(error: error.localizedDescription)
            }
        }
    }
    
    private func createUser(username: String, email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            let userData: [String: Any] = [
                "username": username,
                "uid": authResult!.user.uid
            ]
            
            self.sendUserData(with: userData)
        }
    }
    
    private func sendUserData(with data: [String: Any]) {
        self.db.collection("users").addDocument(data: data) { (error) in
            if let e = error {
                self.showAlert(error: e.localizedDescription)
            }
            let chatController = ChatController()
            self.navigationController?.pushViewController(chatController, animated: true)
        }
    }
}

// MARK: - RegisterViewDelegate

extension RegisterController: RegisterViewDelegate {
    func registerButtonIsTapped(username: String, email: String, password: String) {
        createUser(username: username, email: email, password: password)
    }
}
