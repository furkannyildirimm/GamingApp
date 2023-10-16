//
//  GameTableViewCell.swift
//  GamingApp
//
//  Created by STARK on 16.10.2023.
//

import UIKit

class GameTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: GameTableViewCell.self)
    
    @IBOutlet private weak var ratingLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var listImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listImageView.contentMode = .scaleToFill
    }
    
    func setup(games: GamesList) {
        releaseDateLabel.text = games.released
        nameLabel.text = games.name
        ratingLabel.text = "Rating: \(games.rating?.description ?? "")" 
        
        if let imageUrl = try? games.backgroundImage?.asURL() {
            listImageView.sd_setImage(with: imageUrl, completed: { (image, error, cacheType, imageURL) in
                if let error = error {
                    print("Error loading image: \(error.localizedDescription)")
                } else {
                    print("Image loaded successfully")
                }
            })
        } else {
            print("Error converting to URL")
        }
    }
}
