//
//  AdCollectionViewCell.swift
//  GamingApp
//
//  Created by STARK on 16.10.2023.
//

import UIKit

class AdCollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: AdCollectionViewCell.self)
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
    }
}
