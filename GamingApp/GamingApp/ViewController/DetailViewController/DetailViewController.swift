//
//  DetailViewController.swift
//  GamingApp
//
//  Created by STARK on 16.10.2023.
//

import UIKit

class DetailViewController: BaseViewController {
    
    var gameDetails: GamesDetails?
    
    @IBOutlet private weak var detailGameDescription: UILabel!
    @IBOutlet private weak var detailGameName: UILabel!
    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var releasedLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        control()
    }
    
    func control(){
        if let gameDetails = gameDetails {
            detailGameName.text = gameDetails.name
            releasedLabel.text = gameDetails.released
            detailGameDescription.text = gameDetails.description
            if let imageUrl = URL(string: gameDetails.backgroundImage ?? "") {
                detailImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
    
}
