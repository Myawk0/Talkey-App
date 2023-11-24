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
        tableView.estimatedRowHeight = 70
        tableView.sizeToFit()
        tableView.separatorStyle = .none
        tableView.register(MessageCell.self, forCellReuseIdentifier: MessageCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .top
        return stackView
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
        
        addSubview(stackView)
        stackView.addArrangedSubview(messageTextField)
        stackView.addArrangedSubview(sendButton)
    }
    
    // MARK: - Constraints
    
    private func applyConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalTo(stackView.snp.top).offset(-10)
        }
        
        stackView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(50)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(10)
        }
        
        messageTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        sendButton.snp.makeConstraints { make in
            make.height.width.equalTo(50)
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
        return UITableView.automaticDimension
    }
}

extension ChatView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return delegate?.countMessages ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.reuseIdentifier, for: indexPath) as! MessageCell
        
        if let message = delegate?.getMessages(at: indexPath.row) {
            cell.updateMessages(with: message.body, time: message.date)
        }
        
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
