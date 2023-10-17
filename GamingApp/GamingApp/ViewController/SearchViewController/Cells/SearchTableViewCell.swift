//
//  SearchTableViewCell.swift
//  GamingApp
//
//  Created by STARK on 17.10.2023.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: SearchTableViewCell.self)
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var released: UILabel!
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var listImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listImageView.contentMode = .scaleToFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func setup(games: GamesList) {
        print("Setting up cell with data: \(games)")

        released.text = games.released
        gameName.text = games.name
        rating.text = "Rating: \(games.rating?.description ?? "")"
        
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

