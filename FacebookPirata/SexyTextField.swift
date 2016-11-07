//
//  SexyTextField.swift
//  FacebookPirata
//
//  Created by Pablo Sedano on 07/11/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class SexyTextField: UITextField {
    
    override func awakeFromNib() {
        layer.borderColor = SHADOW_COLOR.cgColor
        layer.borderWidth = 1
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 5)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 8, dy: 5)
    }
    
}
