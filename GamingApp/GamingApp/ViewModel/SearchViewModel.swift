//
//  SearchViewModel.swift
//  GamingApp
//
//  Created by STARK on 17.10.2023.
//
import UIKit

protocol denemeProtocol {
    func filterGameList(with searchTect: String)
}

class SearchViewModel {
        
    
    var reloadTableView: (() -> Void)?
    var gamesList: [GamesList] = []
    var performSegue: (() -> Void)?
    var totalCount: Int = 0
    var pageNumber: Int = 1
    var selectedGameDetails: GamesDetails?
    var filteredList: [GamesList] = []
    
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
                    self?.reloadTableView?()
                    print("Games list updated successfully: \(gameList)")
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
    
    func filterGamesList(with searchText: String) {
            if searchText.isEmpty {
                filteredList = gamesList
            } else {
                filteredList = gamesList.filter { game in
                    if let name = game.name {
                        return name.lowercased().contains(searchText.lowercased())
                    }
                    return false
                }
            }
            reloadTableView?()
        }
}
