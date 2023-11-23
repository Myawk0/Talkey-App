//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Мявкo on 26.09.23.
//

import UIKit

class MessageCell: UITableViewCell {
    
    static let reuseIdentifier = "MessageCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.alignment = .top
        return stackView
    }()
    
    lazy var messageBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.brandLightBlue
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.brandBlue
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var leftView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .brandGrey
        return view
    }()
    
    private lazy var leftLabel: UILabel = {
        let label = UILabel()
        label.text = "You"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rightView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var rightLabel: UILabel = {
        let label = UILabel()
        label.text = "Me"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateMessages(with message: String?) {
        messageLabel.text = message
    }
    
    func updateAppearanceOfCell(if isCurrentUser: Bool?) {
        if isCurrentUser! {
            leftView.isHidden = true
            rightView.isHidden = false
            messageBubbleView.backgroundColor = UIColor.brandLightBlue
            messageLabel.textColor = UIColor.brandBlue
        } else {
            leftView.isHidden = false
            rightView.isHidden = true
            messageBubbleView.backgroundColor = UIColor.brandBlue
            messageLabel.textColor = UIColor.brandLightBlue
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(stackView)
        
        leftView.addSubview(leftLabel)
        stackView.addArrangedSubview(leftView)
        
        stackView.addArrangedSubview(messageBubbleView)
        messageBubbleView.addSubview(messageLabel)
        
        rightView.addSubview(rightLabel)
        stackView.addArrangedSubview(rightView)
    }
    
    private func applyConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        leftView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        leftLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        rightView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        rightLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
//        messageBubbleView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview().inset(10)
//        }
    }
}
