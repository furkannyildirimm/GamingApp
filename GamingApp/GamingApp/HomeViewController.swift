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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        flowLayout()
    }
    
    private func registerCells(){
        adCollectionView.register(UINib(nibName: AdCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: AdCollectionViewCell.identifier)
    }
    
    func flowLayout(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: adCollectionView.frame.width, height: adCollectionView.frame.height)
        flowLayout.minimumLineSpacing = 0
        adCollectionView.collectionViewLayout = flowLayout
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
}

