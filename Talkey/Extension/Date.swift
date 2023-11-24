//
//  Вфеу.swift
//  Talkey
//
//  Created by Мявкo on 23.11.23.
//

import Foundation

extension Date {
    
    func toHourFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
}
