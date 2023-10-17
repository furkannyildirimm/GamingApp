//
//  ViewController.swift
//  GamingApp
//
//  Created by STARK on 15.10.2023.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {
    
    // MARK: - PROPERTIES
    private var viewModel = HomeViewModel()
    private var timer: Timer?
    
    // MARK: - IBOUTLETS
    @IBOutlet private weak var adCollectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        flowLayout()
        setupPageControl()
        reloadData()
        fetchGamesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    
    // MARK: - PRIVATE FUNCTIONS
    private func registerCells() {
        adCollectionView.register(UINib(nibName: AdCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AdCollectionViewCell.identifier)
        tableView.register(UINib(nibName: GameTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GameTableViewCell.identifier)
    }
    
    private func flowLayout() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: adCollectionView.frame.width, height: adCollectionView.frame.height)
        flowLayout.minimumLineSpacing = 0
        adCollectionView.collectionViewLayout = flowLayout
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = viewModel.gamesList.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func scrollToNextPage() {
        let currentPage = adCollectionView.contentOffset.x / adCollectionView.frame.width
        let nextPage = currentPage + 1
        let indexPath = IndexPath(item: Int(nextPage) % viewModel.gamesList.count, section: 0)
        adCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        let selectedPage = sender.currentPage
        let indexPath = IndexPath(item: selectedPage, section: 0)
        adCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func fetchGamesList() {
        viewModel.fetchGamesList()
    }
    
    private func reloadData(){
        viewModel.reloadCollectionView = { [weak self] in
            self?.adCollectionView.reloadData()
            self?.pageControl.numberOfPages = self?.viewModel.gamesList.count ?? 0
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.gameDetails = viewModel.selectedGameDetails
            }
        }
    }
}

// MARK: - UICOLLECTIONVIEWDELEGATE&DATASOURCE
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.gamesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: AdCollectionViewCell.identifier, for: indexPath) as! AdCollectionViewCell
        let game = viewModel.gamesList[indexPath.item]
        if let url = URL(string: game.backgroundImage ?? "") {
            cell.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder")) // Placeholder ekleyebilirsiniz
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == adCollectionView {
            let currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
            pageControl.currentPage = currentPage
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        pageControl.currentPage = currentPage
    }
}

// MARK: - UITABLEVIEWDELEGATE&DATASOURCE
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.gamesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GameTableViewCell.identifier, for: indexPath) as! GameTableViewCell
        cell.setup(games: viewModel.gamesList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedGame = viewModel.gamesList[indexPath.row]
        viewModel.fetchGameDetails(for: String(selectedGame.id ?? 0)) { [weak self] in
            self?.performSegue(withIdentifier: "toDetail", sender: nil)
        }
    }
}



