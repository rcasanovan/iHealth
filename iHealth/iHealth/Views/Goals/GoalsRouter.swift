//
//  GoalsRouter.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class GoalsRouter {
    
    public static func setupModule(navigationController: UINavigationController? = nil) -> GoalsViewController {
        let goalsVC = GoalsViewController()
        goalsVC.presenter = GoalsPresenter(view: goalsVC, navigationController: navigationController)
        return goalsVC
    }
    
}
