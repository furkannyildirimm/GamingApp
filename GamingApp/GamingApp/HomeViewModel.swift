//
//  HomeViewModel.swift
//  GamingApp
//
//  Created by STARK on 15.10.2023.
//

import Foundation

struct HomeViewModel {
    
    var imageNames = ["Cyberpunk-2077", "fifa24", "gtaV"]
    var currentPage = 0
    
    func numberOfSection() -> Int {
        return imageNames.count
    }
}
