//
//  ChatView.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//


import UIKit
import SnapKit
import Firebase

protocol ChatViewDelegate: AnyObject {
    var countMessages: Int { get }
    var isCurrentUser: Bool { get }
    func getMessages(at index: Int) -> Message
    func sendMessage(with message: String)
}

class ChatView: UIView {
    
    weak var delegate: ChatViewDelegate?
    
    // MARK: - Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.sizeToFit()
        //tableView.separatorStyle = .none
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var chatView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.layer.cornerRadius = 15
        textField.setPaddingPoints(15)
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray
        ]
        let attributedPlaceholder = NSAttributedString(string: "Write a message...", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.textColor = .darkGray
        textField.backgroundColor = .brandLightBlue
        textField.returnKeyType = .send
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.tintColor = .brandBlue
        button.addTarget(self, action: #selector(sendButtonIsTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Init
    init(frame: CGRect, controller: ChatController) {
        super.init(frame: frame)
        backgroundColor = .white
        
        messageTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        controller.delegate = self
        
        addSubviews()
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sendButtonIsTapped(_ sender: UIButton) {
        if let message = messageTextField.text, !message.isEmpty {
            delegate?.sendMessage(with: message)
        } else {
            return
        }
    }
    
    // MARK: - Subviews
    
    private func addSubviews() {
        addSubview(tableView)
        
        addSubview(chatView)
        chatView.addSubview(messageTextField)
        chatView.addSubview(sendButton)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(chatView.snp.top)
        }
        
        chatView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview()
        }
        
        messageTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.trailing.equalTo(sendButton.snp.leading).offset(-20)
            make.leading.top.equalToSuperview().inset(20)
        }
        
        sendButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
            make.trailing.top.equalToSuperview().inset(20)
        }
    }
}

extension ChatView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let message = textField.text {
            delegate?.sendMessage(with: message)
        }
        textField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            return false
        }
    }
}

extension ChatView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension ChatView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.countMessages ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseIdentifier, for: indexPath) as! MessageCell
        
        let message = delegate?.getMessages(at: indexPath.row)
        cell.updateMessages(with: message?.body)
        
        let isCurrentUser = delegate?.isCurrentUser
        cell.updateAppearanceOfCell(if: isCurrentUser)
        
        return cell
    }
}

extension ChatView: ChatControllerDelegate {
    func clearTextField() {
        messageTextField.text = ""
    }
    
    func reloadTableView() {
        tableView.reloadData()
        
        let messagesCount = delegate?.countMessages ?? 1
        let indexPath = IndexPath(row: messagesCount - 1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
