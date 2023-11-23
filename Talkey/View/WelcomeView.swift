//
//  WelcomeView.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//

import UIKit
import SnapKit

protocol WelcomeViewDelegate: AnyObject {
    func registerButtonIsTapped()
    func loginButtonIsTapped()
}

class WelcomeView: UIView {
    
    weak var delegate: WelcomeViewDelegate?
    
    // MARK: - Views
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "chat")//?.withTintColor(UIColor.brandPurple!, renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: CLTypingLabel = {
        let label = CLTypingLabel()
        label.text = K.appName
        label.textColor = UIColor.brandBlue
        label.font = .systemFont(ofSize: 50, weight: .black)
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.ButtonTitles.registerButton, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button.tintColor = UIColor.brandBlue
        button.backgroundColor = UIColor.brandLightBlue
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(registerButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(K.ButtonTitles.logInButton, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button.tintColor = .white
        button.backgroundColor = UIColor.brandBlue
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(loginButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func registerButtonIsTapped(_ sender: UIButton) {
        delegate?.registerButtonIsTapped()
    }
    
    @objc func loginButtonIsTapped(_ sender: UIButton) {
        delegate?.loginButtonIsTapped()
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        addSubview(registerButton)
        addSubview(loginButton)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(150)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
        
        registerButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(48)
            make.bottom.equalTo(loginButton.snp.top).offset(-10)
        }
    }
}
