//
//  LoadingView.swift
//  GamingApp
//
//  Created by STARK on 18.10.2023.
//

import UIKit

final class LoadingView {
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    static let shared = LoadingView()
    private var blurView: UIVisualEffectView = UIVisualEffectView()

    private init() {
        configure()
    }

    private func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        blurView.contentView.addSubview(activityIndicator)
        
        let squareSize: CGFloat = 100.0
        let squareView = UIView(frame: CGRect(x: 0, y: 0, width: squareSize, height: squareSize))
        squareView.backgroundColor = UIColor(white: 0.9, alpha: 0.7)
        squareView.layer.cornerRadius = 10.0
        squareView.clipsToBounds = true

        activityIndicator.center = CGPoint(x: squareSize / 2, y: squareSize / 2)
        activityIndicator.color = .black
        squareView.addSubview(activityIndicator)
        
        blurView.contentView.addSubview(squareView)
        squareView.center = blurView.contentView.center
    }

    func startLoading() {
        UIApplication.shared.windows.first?.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.blurView.removeFromSuperview()
            self.activityIndicator.stopAnimating()
        }
    }
}

