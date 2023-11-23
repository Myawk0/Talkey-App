//
//  UIView.swift
//  Talkey
//
//  Created by Мявкo on 23.11.23.
//

import UIKit

extension UIView {
    
    func addShadow() {
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
    }
}
