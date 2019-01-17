//
//  MyGoalsProtocols.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

// View / Presenter
protocol MyGoalsViewInjection : class {
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol MyGoalsPresenterDelegate : class {
    func viewDidLoad()
    func viewDidAppear()
}

// Presenter / Interactor
protocol MyGoalsInteractorDelegate : class {
    func requestHealthAuthorizationIfNeeded(completion: @escaping HealthAuthCompletionBlock)
    func getMyGoals() -> [MyGoalViewModel]
}

// Presenter / Router

protocol MyGoalsRouterDelegate : class {
}
