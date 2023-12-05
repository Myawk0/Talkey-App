//
//  LoginController.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//


import UIKit
import SnapKit

protocol LoginViewDelegate: AnyObject {
    func loginButtonIsTapped(userData: LoginModel)
}

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In"
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .brandLightBlue
        label.textAlignment = .left
        return label
    }()
    
    private lazy var emailTextField: TextField = {
        let textField = TextField()
        textField.placeholder = K.TextFieldPlaceholders.email
        textField.backgroundColor = .white.withAlphaComponent(0.3)
        textField.textColor = .white
        textField.placeholderColor = .white.withAlphaComponent(0.7)
        textField.addShadow()
        //textField.text = "shrek@mail.com"
        return textField
    }()
    
    private lazy var passwordTextField: TextField = {
        let textField = TextField()
        textField.placeholder = K.TextFieldPlaceholders.password
        textField.backgroundColor = .white.withAlphaComponent(0.3)
        textField.textColor = .white
        textField.placeholderColor = .white.withAlphaComponent(0.8)
        textField.addShadow()
        textField.isSecureTextEntry = true
        //textField.text = "123456"
        return textField
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .brandBlue
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitle(K.ButtonTitles.logInButton, for: .normal)
        button.addTarget(self, action: #selector(loginButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.brandBlue
        setupDelegates()
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegates
    
    private func setupDelegates() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Selectors
    
    @objc func loginButtonIsTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        let data = LoginModel(email: email, password: password)
        delegate?.loginButtonIsTapped(userData: data)
    }
    
    // MARK: - Method when textField are edited
    
    @objc func textFieldsDidChange() {
        //       guard let email = emailTextField.text, let password = passwordTextField.text else { return }
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(logInButton)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        logInButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}

// MARK: - UITextFieldDelegate

extension LoginView: UITextFieldDelegate {
    
    // Close keyboard when tap a button "Return"
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Close keyboard when tap on any place except textfield
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}
