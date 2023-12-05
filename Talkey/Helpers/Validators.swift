//
//  Validators.swift
//  Talkey
//
//  Created by Мявкo on 28.11.23.
//

import Foundation

struct Validators {
    
    static func isFilled(username: String, email: String, password: String) -> Bool {
        guard !username.isEmpty,
              !email.isEmpty,
              !password.isEmpty else { return false }
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
}
