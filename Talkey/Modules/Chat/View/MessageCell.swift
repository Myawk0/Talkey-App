//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Мявкo on 26.09.23.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy var messageBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.brandLightBlue
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.brandBlue
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.fionaImage
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.shrekImage
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .gray
        label.text = "19:21"
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .white
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method to update messages data
    
    func updateMessages(with message: String, time: Timestamp) {
        messageLabel.text = message
        dateLabel.text = time.dateValue().toHourFormat()
    }
    
    // MARK: - Method to get user avatar
    
    private func getCurrentUserAvatar(from sender: String) -> UIImage? {
        switch sender {
        case Users.shrek.email:
            UserData.user = .shrek
            return Users.shrek.image
        case Users.fiona.email:
            UserData.user = .fiona
            return Users.fiona.image
        default:
            return UIImage(named: "MeAvatar")
        }
    }
    
    // MARK: - Method to setup avatar
    
    func setupAvatars(of sender: String) {
        rightImageView.image = getCurrentUserAvatar(from: sender)
        leftImageView.image = UserData.user == .shrek ? UIImage.fionaImage : UIImage.shrekImage
    }
    
    // MARK: - Method to update appearance of cell from user
    
    func updateAppearanceOfCell(if isCurrentUser: Bool) {
        if isCurrentUser {
            leftImageView.isHidden = true
            rightImageView.isHidden = false
            messageBubbleView.backgroundColor = UIColor.brandLightBlue
            messageLabel.textColor = UIColor.darkGray
            dateLabel.textAlignment = .right
        } else {
            leftImageView.isHidden = false
            rightImageView.isHidden = true
            messageBubbleView.backgroundColor = UIColor.brandBlue
            messageLabel.textColor = UIColor.brandLightBlue
            dateLabel.textAlignment = .left
        }
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        contentView.addSubview(leftImageView)
        contentView.addSubview(messageBubbleView)
        messageBubbleView.addSubview(messageLabel)
        contentView.addSubview(rightImageView)
        contentView.addSubview(dateLabel)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        
        leftImageView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.leading.top.equalToSuperview().inset(10)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.height.width.equalTo(40)
            make.trailing.top.equalToSuperview().inset(10)
        }
        
        messageBubbleView.snp.makeConstraints { make in
            make.leading.equalTo(leftImageView.snp.trailing).offset(10)
            make.trailing.equalTo(rightImageView.snp.leading).offset(-10)
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(20)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(10)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(messageBubbleView.snp.bottom).offset(5)
            make.trailing.equalTo(messageBubbleView.snp.trailing).inset(5)
            make.leading.equalTo(messageBubbleView.snp.leading).inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
    }
}
