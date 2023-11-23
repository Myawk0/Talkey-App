//
//  UITextField.swift
//  Talkey
//
//  Created by Мявкo on 23.11.23.
//

import UIKit

extension UITextField {
    
    func setPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.rightView = paddingView
        
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}
