//
//  ChatController.swift
//  Flash Chat
//
//  Created by Мявкo on 25.09.23.
//

import UIKit
import Firebase
import FirebaseStorage

protocol ChatControllerDelegate: AnyObject {
    func reloadTableView()
    func clearTextField()
}

class ChatController: UIViewController {
    
    // MARK: - Properties
    
    weak var delegate: ChatControllerDelegate?
    
    private var chatView: ChatView?
    
    private let db = Firestore.firestore()
    private var messages: [Message] = []
    private var currentSender = ""
    
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        loadMessages()
    }
    
    // MARK: - Setup Navigation Bar settings
    
    private func setupNavBar() {
        navigationItem.hidesBackButton = true
        navigationController?.setupTitle()
        navigationController?.setupLogOutButton()
    }
    
    // MARK: - Loading Messages from Firestore
    
    private func createMessage(from data: [String: Any]) -> Message? {
        guard let messageSender = data[K.FStore.senderField] as? String,
              let messageBody = data[K.FStore.bodyField] as? String,
              let messageDate = data[K.FStore.dateField] as? Timestamp else { return nil }

        return Message(sender: messageSender, body: messageBody, date: messageDate)
    }
    
    private func handleSnapshotDocuments(_ snapshotDocuments: [QueryDocumentSnapshot]) {
        messages = []

        for doc in snapshotDocuments {
            let messageData = doc.data()
            guard let newMessage = self.createMessage(from: messageData) else { continue }

            messages.append(newMessage)
        }
    }
    
    private func loadMessages() {
        db.collection(K.FStore.collectionName).order(by: K.FStore.dateField).addSnapshotListener { querySnapshot, error in
            if let e = error {
                print("There was an issue setrieving data from Firestore, \(e)")
            } else {
                guard let snapshotDocuments = querySnapshot?.documents else { return }
                self.handleSnapshotDocuments(snapshotDocuments)
                
                DispatchQueue.main.async {
                    self.delegate?.reloadTableView()
                }
            }
        }
    }
    
    // MARK: - Saving Messages to Firestore
    
    private func sendMessageToFirestore(with messageBody: String) {
        guard let messageSender = Auth.auth().currentUser?.email else { return }
        
        let messageData: [String: Any] = [
            K.FStore.senderField: messageSender,
            K.FStore.bodyField: messageBody,
            K.FStore.dateField: Date()
        ]
        
        saveDataToFirestore(data: messageData)
    }
    
    private func saveDataToFirestore(data: [String: Any]) {
        db.collection(K.FStore.collectionName).addDocument(data: data) { error in
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

// MARK: - ChatViewDelegate

extension ChatController: ChatViewDelegate {
    
    var currentSenderEmail: String? {
        return Auth.auth().currentUser?.email
    }
    
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

