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
    
    func fetchGamesImages() {
        NetworkManager.shared.fetchGameList { [weak self] (result: Result<Games, Error>) in
            switch result {
            case .success(let games):
                if let gameList = games.results {
                    self?.gamesList = gameList
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
                // Handle error if needed
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

