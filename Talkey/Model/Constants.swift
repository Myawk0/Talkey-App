//
//  Constants.swift
//  Flash Chat
//
//  Created by Мявкo on 26.09.23.
//


struct K {
    static let appName = "Talkey"
    static let cellIdentifier = "MessageCell"
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
    
    struct ButtonTitles {
        static let registerButton = "Register"
        static let logInButton = "Log In"
        static let logOutButton = "Log Out"
    }
    
    struct TextFieldPlaceholders {
        static let username = "Username"
        static let email = "Email"
        static let password = "Password"
        static var message = "Write a message..."
    }
}
