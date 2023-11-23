//
//  ChatController.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//

import UIKit
import Firebase

protocol ChatControllerDelegate: AnyObject {
    func reloadTableView()
    func clearTextField()
}

class ChatController: UIViewController {
    
    weak var delegate: ChatControllerDelegate?
    
    let db = Firestore.firestore()
    
    private var currentSender = ""
    
    // MARK: - Views
    
    private var chatView: ChatView?
    
    var messages: [Message] = []
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
        chatView = ChatView(frame: CGRect(), controller: self)
        chatView?.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appoint chatView as view
    
    override func loadView() {
        super.loadView()
        self.view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
        navigationController?.setupTitle()
        navigationController?.setupLogOutButton()
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { querySnapshot, error in
                
                self.messages = []
                
                if let e = error {
                    print("There was an issue setrieving data from Firestore, \(e)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data[K.FStore.senderField] as? String,
                               let messageBody = data[K.FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.delegate?.reloadTableView()
                                }
                            }
                        }
                    }
                }
            }
    }
    
    func sendMessageToFirestore(with messageBody: String) {
        if let messageSender = Auth.auth().currentUser?.email {
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField: messageSender,
                K.FStore.bodyField: messageBody,
                K.FStore.dateField: Date().timeIntervalSince1970
            ]) { (error) in
                if let e = error {
                    print("There was an issue saving data to Firestore, \(e)")
                } else {
                    DispatchQueue.main.async {
                        self.delegate?.clearTextField()
                    }
                }
            }
        }
    }
}

extension ChatController: ChatViewDelegate {
    var isCurrentUser: Bool {
        return currentSender == Auth.auth().currentUser?.email
    }
    
    func sendMessage(with message: String) {
        sendMessageToFirestore(with: message)
    }
    
    func getMessages(at index: Int) -> Message {
        currentSender = messages[index].sender
        return messages[index]
    }
    
    var countMessages: Int {
        return messages.count
    }
}

