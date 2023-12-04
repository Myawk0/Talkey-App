//
//  UserData.swift
//  Talkey
//
//  Created by Мявкo on 28.11.23.
//

import UIKit

struct UserData {
    static var user: Users = .shrek
    static var imageUrlString = ""
}

enum Users {
    case shrek
    case fiona
    
    var email: String {
        switch self {
        case .shrek:
            return "shrek@mail.com"
        case .fiona:
            return "fiona@mail.com"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .shrek:
            return UIImage.shrekImage
        case .fiona:
            return UIImage.fionaImage
        }
    }
}
