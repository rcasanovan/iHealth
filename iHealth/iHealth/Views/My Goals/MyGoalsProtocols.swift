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
    func loadMyGoals(_ viewModels: [MyGoalViewModel])
}

protocol MyGoalsPresenterDelegate : class {
    func viewDidLoad()
    func viewDidAppear()
    func sharePressed()
    func refresh()
}

// Presenter / Interactor

typealias MyGoalsGetGoalsCompletionBlock = (_ viewModel: [MyGoalViewModel]) -> Void

protocol MyGoalsInteractorDelegate : class {
    func requestHealthAuthorizationIfNeeded(completion: @escaping HealthAuthCompletionBlock)
    func getMyGoals(completion: @escaping MyGoalsGetGoalsCompletionBlock)
    func clear()
}

// Presenter / Router

protocol MyGoalsRouterDelegate : class {
}
