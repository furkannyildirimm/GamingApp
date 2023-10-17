//
//  CardView.swift
//  GamingApp
//
//  Created by STARK on 16.10.2023.
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    private func initialSetup() {
        layer.shadowColor = UIColor.systemIndigo.cgColor
        layer.shadowOffset = .zero
        layer.cornerRadius = 15
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 10
        layer.borderColor = UIColor.systemIndigo.cgColor
        layer.borderWidth = 1
        cornerRadius = 10
    }
}
