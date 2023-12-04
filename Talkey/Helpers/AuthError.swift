//
//  AuthError.swift
//  Talkey
//
//  Created by Мявкo on 28.11.23.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Email_is_not_valid", comment: "")
        case .unknownError:
            return NSLocalizedString("Server_error", comment: "")
        case .serverError:
            return NSLocalizedString("Server_error", comment: "")
        }
    }
}
