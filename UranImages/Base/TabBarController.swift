//
//  TabBarController.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import Foundation
import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let mainVC = BaseNavigationVC(rootViewController: MainVC())
        mainVC.tabBarItem = UITabBarItem(title: "Images", image: UIImage(named: "main"), tag: 0)
        
        let searchVC = BaseNavigationVC(rootViewController: SearchVC())
        searchVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(named: "search"), tag: 1)
        
        viewControllers = [mainVC, searchVC]
    }
}
