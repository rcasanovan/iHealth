//
//  MainTabBar.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class MainTabBar: UITabBarController {
    
    private var tabBarConfigured: Bool = false
    
    private let goalsViewController: GoalsViewController = GoalsRouter.setupModule()
    private let myGoalsViewController: MyGoalsViewController = MyGoalsRouter.setupModule()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBar()
    }
    
}

// MARK: - Private section
extension MainTabBar {
    
    private func configureTabBar() {
        if tabBarConfigured { return }
        
        let goalsTabBarItem = UITabBarItem(title: "Goals", image: nil, tag: 0)
        let myGoalsTabBarItem = UITabBarItem(title: "My Goals", image: nil, tag: 1)
        
        let goalsNagivationViewController = UINavigationController(rootViewController: goalsViewController)
        goalsNagivationViewController.tabBarItem = goalsTabBarItem
        
        let myGoalsNagivationViewController = UINavigationController(rootViewController: myGoalsViewController)
        myGoalsNagivationViewController.tabBarItem = myGoalsTabBarItem
        
        viewControllers = [goalsNagivationViewController, myGoalsNagivationViewController]
        
        tabBarConfigured = true
        
        selectedIndex = 0
    }
    
}

