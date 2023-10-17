//
//  TabbarScrolling + Extension.swift
//  GamingApp
//
//  Created by STARK on 17.10.2023.
//

import Foundation
import UIKit

extension UIViewController {
    func setTabBarVisible(visible: Bool, duration: TimeInterval, animated: Bool, tableView: UITableView) {
        if (tabBarIsVisible() == visible) { return }
        
        let frame = self.tabBarController?.tabBar.frame
        let height = frame?.size.height ?? 0
        let offsetY = (visible ? -height : height)
        
        // Animation
        if #available(iOS 10.0, *) {
            UIViewPropertyAnimator(duration: duration, curve: .linear) {
                self.tabBarController?.tabBar.frame = CGRect(x: 0, y: self.view.frame.height + offsetY, width: self.view.frame.width, height: height)
                
                tableView.frame = CGRect(x: tableView.frame.origin.x, y:  tableView.frame.origin.y, width:  tableView.bounds.width, height:  tableView.bounds.height + offsetY)
                
                self.view.setNeedsDisplay()
                self.view.layoutIfNeeded()
            }.startAnimation()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func tabBarIsVisible() -> Bool {
        return (self.tabBarController?.tabBar.frame.origin.y ?? 0) < UIScreen.main.bounds.height
    }
}
