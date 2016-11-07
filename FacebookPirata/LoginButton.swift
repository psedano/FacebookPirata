//
//  LoginButton.swift
//  FacebookPirata
//
//  Created by Pablo Sedano on 07/11/16.
//  Copyright © 2016 Pablo Sedano. All rights reserved.
//

import UIKit

class LoginButton: UIButton {

    override func awakeFromNib() {
        layer.backgroundColor = UIColor(red: 213/255.0, green: 78/255.0, blue: 55/255.0, alpha: 1).cgColor
        layer.cornerRadius = 5
        layer.shadowColor = SHADOW_COLOR.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 5
        tintColor = UIColor.white
    }

}
