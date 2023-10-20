//
//  EmptyView + Extension.swift
//  GamingApp
//
//  Created by STARK on 20.10.2023.
//

import Foundation

import UIKit

extension UIImageView {
    convenience init(emptyStateImage: UIImage) {
        self.init(image: emptyStateImage)
        contentMode = .center
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func showEmptyState(in view: UIView) {
        view.addSubview(self)
        
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor),
            widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5), // Ekran genişliğinin yarısı kadar
            heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func hideEmptyState() {
        removeFromSuperview()
    }
}
