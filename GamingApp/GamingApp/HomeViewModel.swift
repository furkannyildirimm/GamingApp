//
//  HomeViewModel.swift
//  GamingApp
//
//  Created by STARK on 15.10.2023.
//

import Foundation

struct HomeViewModel {
    
    var imageNames = ["gtaV", "fifa24", "callofduty"]
    var currentPage = 0
    
    func numberOfSection() -> Int {
        return imageNames.count
    }
}
