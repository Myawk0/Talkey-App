//
//  RegisterView.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//


import UIKit
import SnapKit

protocol RegisterViewDelegate: AnyObject {
    func registerButtonIsTapped(email: String, password: String)
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
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        setupTextField(for: textField, placeholder: K.TextFieldPlaceholders.email)
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        setupTextField(for: textField, placeholder: K.TextFieldPlaceholders.password)
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
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @objc func registerButtonIsTapped(_ sender: UIButton) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            delegate?.registerButtonIsTapped(email: email, password: password)
        }
    }
    
    func setupTextField(for textField: UITextField, placeholder: String) {
        textField.backgroundColor = .white
        textField.autocapitalizationType = .none
        textField.textAlignment = .left
        textField.setPaddingPoints(15)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.font = .systemFont(ofSize: 20, weight: .regular)
    
        textField.layer.cornerRadius = 15
        textField.addShadow()
        
        textField.textColor = .darkGray
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
        addSubview(registerButton)
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
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
        }
    }
}

extension RegisterView: UITextFieldDelegate {
    
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
