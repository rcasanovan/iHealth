//
//  GoalsProtocols.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

// View / Presenter
protocol GoalsViewInjection : class {
    func showProgress(_ show: Bool, status: String)
    func showProgress(_ show: Bool)
    func showMessageWith(title: String, message: String, actionTitle: String)
}

protocol GoalsPresenterDelegate : class {
    func viewDidLoad()
}

// Presenter / Interactor

typealias GoalsGetGoalsCompletionBlock = (_ viewModel: [GoalViewModel]?, _ success: Bool, _ error: ResultError?) -> Void

protocol GoalsInteractorDelegate : class {
    func getGoalsList(completion: @escaping GoalsGetGoalsCompletionBlock)
}

// Presenter / Router

protocol GoalsRouterDelegate : class {
}
