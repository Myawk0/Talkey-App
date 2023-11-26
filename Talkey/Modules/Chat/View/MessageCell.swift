//
//  MessageCell.swift
//  Flash Chat
//
//  Created by Мявкo on 26.09.23.
//

import UIKit
import Firebase

class MessageCell: UITableViewCell {
    
    static let reuseIdentifier = "MessageCell"
    
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
        imageView.image = UIImage(named: "fiona")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var rightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shrek")
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
    
    func updateMessages(with message: String, time: Timestamp) {
        messageLabel.text = message
        dateLabel.text = time.dateValue().toHourFormat()
    }
    
    var toGetMessages: Bool = false {
        didSet {
            leftImageView.image = toGetMessages ?  UIImage(named: "shrek") : UIImage(named: "fiona")
            rightImageView.image = toGetMessages ?  UIImage(named: "shrek") : UIImage(named: "fiona")
        }
    }
    
    func updateAppearanceOfCell(if isCurrentUser: Bool?) {
        if isCurrentUser! {
            toGetMessages = false
            leftImageView.isHidden = true
            rightImageView.isHidden = false
            messageBubbleView.backgroundColor = UIColor.brandLightBlue
            messageLabel.textColor = UIColor.darkGray
            dateLabel.textAlignment = .right
        } else {
            toGetMessages = true
            leftImageView.isHidden = false
            rightImageView.isHidden = true
            messageBubbleView.backgroundColor = UIColor.brandBlue
            messageLabel.textColor = UIColor.brandLightBlue
            dateLabel.textAlignment = .left
        }
    }
    
    private func addSubviews() {
        contentView.addSubview(leftImageView)
        contentView.addSubview(messageBubbleView)
        messageBubbleView.addSubview(messageLabel)
        contentView.addSubview(rightImageView)
        contentView.addSubview(dateLabel)
    }
    
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
