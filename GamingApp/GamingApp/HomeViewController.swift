//
//  ViewController.swift
//  GamingApp
//
//  Created by STARK on 15.10.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    
    @IBOutlet private weak var adCollectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        flowLayout()
        startTimer()
    }
    
    private func registerCells(){
        adCollectionView.register(UINib(nibName: AdCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AdCollectionViewCell.identifier)
    }
    
    private func flowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: adCollectionView.frame.width, height: adCollectionView.frame.height)
        flowLayout.minimumLineSpacing = 0
        adCollectionView.collectionViewLayout = flowLayout
        
        pageControl.numberOfPages = viewModel.numberOfSection()
        pageControl.currentPage = viewModel.currentPage
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(scrollToNextPage), userInfo: nil, repeats: true)
    }
    
    // Stop the timer
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
    }
    
    // Handle the end of scrolling to update the current page in the view model
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        viewModel.currentPage = currentPage
    }
}

