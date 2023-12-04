//
//  TextField.swift
//  Talkey
//
//  Created by Мявкo on 2.12.23.
//

import UIKit

class TextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    var placeholderColor: UIColor = .lightGray {
        didSet {
            let attributes: [NSAttributedString.Key: Any] = [ .foregroundColor: placeholderColor ]
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
        }
    }
    
    private func commonInit() {
        autocapitalizationType = .none
        textAlignment = .left
        font = .systemFont(ofSize: 20, weight: .regular)
        
        setPaddingPoints(15)
        layer.cornerRadius = 15
    }
    
    private func setPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.rightView = paddingView
        
        self.leftViewMode = .always
        self.rightViewMode = .always
    }
}

