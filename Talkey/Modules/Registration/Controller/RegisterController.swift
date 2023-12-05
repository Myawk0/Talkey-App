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
    
    private var registerModel: RegisterModel?
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
    
    private func validateTextFields(completion: @escaping (AuthResult) -> Void) {
        
        guard let model = registerModel else {
            completion(.failure(AuthError.unknownError))
            return
        }

        guard Validators.isFilled(username: model.username, email: model.email, password: model.password) else {
            completion(.failure(AuthError.notFilled))
            return
        }

        guard Validators.isSimpleEmail(model.email) else {
            completion(.failure(AuthError.invalidEmail))
            return
        }
    }
    
    // MARK: - Register User
    
    private func register() {
        validateTextFields() { result in
            switch result {
            case .success:
                self.createUser()
            case .failure(let error):
                self.showAlert(error: error.localizedDescription)
            }
        }
    }
    
    private func createUser() {
        guard let model = registerModel else { return }
        
        Auth.auth().createUser(withEmail: model.email, password: model.password) { authResult, error in
            let userData: [String: Any] = [
                "username": model.username,
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
    
    func registerButtonIsTapped(userData: RegisterModel) {
        self.registerModel = userData
        register()
    }
}
