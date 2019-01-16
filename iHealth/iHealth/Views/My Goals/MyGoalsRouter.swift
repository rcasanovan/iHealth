//
//  MyGoalsRouter.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class MyGoalsRouter {
    
    public static func setupModule(navigationController: UINavigationController? = nil) -> MyGoalsViewController {
        let myGoalsVC = MyGoalsViewController()
        myGoalsVC.presenter = MyGoalsPresenter(view: myGoalsVC, navigationController: navigationController)
        return myGoalsVC
    }
    
}
