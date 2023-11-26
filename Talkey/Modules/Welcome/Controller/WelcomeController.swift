//
//  WelcomeController.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//

import UIKit

class WelcomeController: UIViewController {

    // MARK: - Views
    
    private let welcomeView: WelcomeView
    
    // MARK: - Init
    
    init() {
        self.welcomeView = WelcomeView()
        super.init(nibName: nil, bundle: nil)
        welcomeView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appoint welcomeView as view
    
    override func loadView() {
        super.loadView()
        self.view = welcomeView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        welcomeView.startTitleAnimation()
    }
}

extension WelcomeController: WelcomeViewDelegate {
    func registerButtonIsTapped() {
        let registerController = RegisterController()
        navigationController?.pushViewController(registerController, animated: true)
    }
    
    func loginButtonIsTapped() {
        let loginController = LoginController()
        navigationController?.pushViewController(loginController, animated: true)
    }
}
