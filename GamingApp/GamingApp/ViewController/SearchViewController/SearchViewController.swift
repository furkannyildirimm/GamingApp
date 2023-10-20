//
//  SearchViewController.swift
//  GamingApp
//
//  Created by STARK on 16.10.2023.
//

import UIKit
import SDWebImage

class SearchViewController: BaseViewController {
    
    var viewModel = SearchViewModel()
    private var emptyStateImageView: UIImageView!
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        showLoading()
        reloadData()
        fetchData()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        emptyView()
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    private func fetchData() {
        viewModel.fetchGamesList(false, pageNumber: viewModel.pageNumber)
    }
    
    private func reloadData() {
        
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
            self?.hideLoading()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.gameDetails = viewModel.selectedGameDetails
            }
        }
    }
    
    private func emptyView() {
        emptyStateImageView = UIImageView(emptyStateImage: UIImage(named: "notFound")!)
        emptyStateImageView.contentMode = .scaleAspectFit
        tableView.backgroundView = emptyStateImageView
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        checkEmptyState()
    }
    
    private func checkEmptyState() {
        let isEmpty = viewModel.gamesList.count == 0
        
        if isEmpty {
            emptyStateImageView.showEmptyState(in: tableView)
        } else {
            emptyStateImageView.hideEmptyState()
        }
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isSearching ? viewModel.filteredList.count : viewModel.gamesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.setup(games: viewModel.isSearching ? viewModel.filteredList[indexPath.row] : viewModel.gamesList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.gamesList.count - 1 {
            if viewModel.totalCount > viewModel.gamesList.count{
                viewModel.pageNumber += 1
                viewModel.fetchGamesList(true, pageNumber: viewModel.pageNumber)
                tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = viewModel.gamesList[indexPath.row]
        viewModel.fetchGameDetails(for: String(selectedGame.id ?? 0)) { [weak self] in
            self?.performSegue(withIdentifier: "toDetail", sender: nil)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchTerm = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        if !searchTerm.isEmpty {
            viewModel.isSearching = true
            viewModel.filteredList = viewModel.gamesList.filter { game in
                return game.name?.lowercased().contains(searchTerm) ?? false
            }
        } else {
            viewModel.clearSearchResult()
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.clearSearchResult()
        tableView.reloadData()
    }
}
