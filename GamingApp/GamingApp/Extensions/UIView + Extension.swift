//
//  UIView + Extension.swift
//  GamingApp
//
//  Created by STARK on 15.10.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get{ return self.cornerRadius}
        set{
            self.layer.cornerRadius = newValue
        }
    }
}
