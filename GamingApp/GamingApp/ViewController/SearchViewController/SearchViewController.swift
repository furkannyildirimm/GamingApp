//
//  SearchViewController.swift
//  GamingApp
//
//  Created by STARK on 16.10.2023.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
    var viewModel = SearchViewModel()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        //reloadData()
        fetchGamesList()
        viewModel.fetchGamesList()
        
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: SearchTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: SearchTableViewCell.identifier)
    }
    
    private func fetchGamesList() {
       
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
//    private func reloadData(){
//        print("Number of games: \(viewModel.gamesList.count)")
//
//        DispatchQueue.main.async {
//
//            self.tableView.reloadData()
//        }
//    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gamesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        cell.setup(games: viewModel.gamesList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
}
