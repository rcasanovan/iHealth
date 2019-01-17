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
        
        let goalsIcon = UIImage(named: "goalsIcon")?.withRenderingMode(.alwaysOriginal)
        let myGoalsIcon = UIImage(named: "myGoalsIcon")?.withRenderingMode(.alwaysOriginal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.mediumWithSize(size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.mediumWithSize(size: 10.0) ?? UIFont.systemFont(ofSize: 10.0)], for: .selected)
        
        let goalsTabBarItem = UITabBarItem(title: "Goals", image: goalsIcon, tag: 0)
        let myGoalsTabBarItem = UITabBarItem(title: "My Goals", image: myGoalsIcon, tag: 1)
        
        let goalsNagivationViewController = UINavigationController(rootViewController: goalsViewController)
        goalsNagivationViewController.tabBarItem = goalsTabBarItem
        goalsNagivationViewController.tabBarItem.selectedImage = goalsIcon
        
        let myGoalsNagivationViewController = UINavigationController(rootViewController: myGoalsViewController)
        myGoalsNagivationViewController.tabBarItem = myGoalsTabBarItem
        myGoalsNagivationViewController.tabBarItem.selectedImage = myGoalsIcon
        
        viewControllers = [goalsNagivationViewController, myGoalsNagivationViewController]
        
        tabBarConfigured = true
        
        selectedIndex = 0
    }
    
}

