//
//  LoginController.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//


import UIKit
import SnapKit

protocol LoginViewDelegate: AnyObject {
    func loginButtonIsTapped(email: String, password: String)
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
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        setupTextField(for: textField, placeholder: K.TextFieldPlaceholders.email)
        //textField.text = "1@2.com"
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        setupTextField(for: textField, placeholder: K.TextFieldPlaceholders.password)
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
    
    @objc func loginButtonIsTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            delegate?.loginButtonIsTapped(email: email, password: password)
        }
    }
    
    func setupTextField(for textField: UITextField, placeholder: String) {
        textField.backgroundColor = .white.withAlphaComponent(0.3)
        textField.textAlignment = .left
        textField.setPaddingPoints(15)
        textField.autocapitalizationType = .none
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.font = .systemFont(ofSize: 20, weight: .regular)
    
        textField.layer.cornerRadius = 15
        textField.addShadow()
        
        textField.textColor = .white
        textField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
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

extension LoginView: UITextFieldDelegate {
    
    // MARK: - Close keyboard when tap a button "Return"
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Close keyboard when tap on any place except textfield
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
}
