//
//  ViewController.swift
//  GamingApp
//
//  Created by STARK on 15.10.2023.
//

import UIKit

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
    private func registerCells(){
        adCollectionView.register(UINib(nibName: AdCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AdCollectionViewCell.identifier)
        tableView.register(UINib(nibName: GameTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: GameTableViewCell.identifier)
    }
    
    private func flowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: adCollectionView.frame.width, height: adCollectionView.frame.height)
        flowLayout.minimumLineSpacing = 0
        adCollectionView.collectionViewLayout = flowLayout
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = viewModel.numberOfSection()
        pageControl.currentPage = viewModel.currentPage
        pageControl.addTarget(self, action: #selector(pageControlValueChanged(_:)), for: .valueChanged)

    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func scrollToNextPage() {
        let currentPage = adCollectionView.contentOffset.x / adCollectionView.frame.width
        let nextPage = currentPage + 1
        let indexPath = IndexPath(item: Int(nextPage) % viewModel.numberOfSection(), section: 0)
        adCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        if nextPage < CGFloat(viewModel.numberOfSection()) {
            let indexPath = IndexPath(item: Int(nextPage), section: 0)
            adCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        } else {
            // If we reached the end, scroll back to the beginning
            let indexPath = IndexPath(item: 0, section: 0)
            adCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc private func pageControlValueChanged(_ sender: UIPageControl) {
        let selectedPage = sender.currentPage
        let indexPath = IndexPath(item: selectedPage, section: 0)
        adCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

//MARK: - UICOLLECTIONVIEWDELEGATE&DATASOURCE
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = adCollectionView.dequeueReusableCell(withReuseIdentifier: AdCollectionViewCell.identifier, for: indexPath) as! AdCollectionViewCell
        let imageName = viewModel.imageNames[indexPath.item]
        cell.imageView.image = UIImage(named: imageName)
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        pageControl.currentPage = currentPage
        // Update the current page of the page control
        pageControl.currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))

    }
    
    // Handle the end of scrolling to update the current page in the view model
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        viewModel.currentPage = currentPage
    }
}

//MARK: - UITABLEVIEWDELEGATE&DATASOURCE
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}



