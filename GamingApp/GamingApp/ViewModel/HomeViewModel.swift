//
//  HomeViewModel.swift
//  GamingApp
//
//  Created by STARK on 15.10.2023.
//

import Foundation

class HomeViewModel {
    
    var gamesList: [GamesList] = []
    var reloadCollectionView: (() -> Void)?
    var performSegue: (() -> Void)?
    var selectedGameDetails: GamesDetails?
    var totalCount: Int = 0
    var pageNumber: Int = 1
    var timer: Timer?
    
    func fetchGamesList(_ isLoadMore: Bool,pageNumber: Int) {
        
        NetworkManager.shared.fetchGameList(pageNumber) { [weak self] (result: Result<Games, Error>) in
            switch result {
            case .success(let games):
                self?.totalCount = games.count ?? 0
                if let gameList = games.results {
                    if isLoadMore {
                        self?.gamesList.append(contentsOf: gameList)
                    } else {
                        self?.gamesList = gameList
                    }
                    
                    self?.reloadCollectionView?()
                }
            case .failure(let error):
                print("Error fetching games: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchGameDetails(for gameId: String, completion: @escaping () -> Void) {
        NetworkManager.shared.fetchGameDetails(gameId: gameId) { [weak self] (result: Result<GamesDetails, Error>) in
            switch result {
                
            case .success(let details):
                self?.selectedGameDetails = details
                completion()
            case .failure:
                completion()
            }
        }
    }
    
    func didSelectGame(at indexPath: IndexPath) {
        
    }
    
    func sortGamesByName() {
        gamesList.sort { $0.name?.localizedCaseInsensitiveCompare($1.name ?? "") == .orderedAscending }
    }
}


