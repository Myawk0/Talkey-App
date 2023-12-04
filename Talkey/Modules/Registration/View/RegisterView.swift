//
//  RegisterView.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//


import UIKit
import SnapKit

protocol RegisterViewDelegate: AnyObject {
    func registerButtonIsTapped(username: String, email: String, password: String)
}

class RegisterView: UIView {
    
    weak var delegate: RegisterViewDelegate?
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 25
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create Account"
        label.font = .systemFont(ofSize: 32, weight: .heavy)
        label.textColor = .brandBlue
        label.textAlignment = .left
        return label
    }()
    
    private lazy var usernameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = K.TextFieldPlaceholders.username
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.addShadow()
        return textField
    }()
    
    private lazy var emailTextField: TextField = {
        let textField = TextField()
        textField.placeholder = K.TextFieldPlaceholders.email
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.addShadow()
        return textField
    }()
    
    private lazy var passwordTextField: TextField = {
        let textField = TextField()
        textField.placeholder = K.TextFieldPlaceholders.password
        textField.backgroundColor = .white
        textField.textColor = .darkGray
        textField.addShadow()
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.brandLightBlue
        button.backgroundColor = UIColor.brandBlue
        button.layer.cornerRadius = 15
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        button.setTitle(K.ButtonTitles.registerButton, for: .normal)
        button.addTarget(self, action: #selector(registerButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.brandLightPurple
        setupDelegates()
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Delegates
    
    private func setupDelegates() {
        usernameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    // MARK: - Selectors
    
    @objc func registerButtonIsTapped(_ sender: UIButton) {
        if let username = usernameTextField.text,
           let email = emailTextField.text,
           let password = passwordTextField.text {
            delegate?.registerButtonIsTapped(username: username, email: email, password: password)
        }
    }
    
    // MARK: - Method when textField are edited
    
    @objc func textFieldsDidChange() {
        //       guard let email = emailTextField.text, let password = passwordTextField.text else { return }
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(usernameTextField)
        stackView.addArrangedSubview(emailTextField)
        stackView.addArrangedSubview(passwordTextField)
        addSubview(registerButton)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-70)
            make.leading.trailing.equalToSuperview().inset(15)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}

// MARK: - UITextFieldDelegate

extension RegisterView: UITextFieldDelegate {
    
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
