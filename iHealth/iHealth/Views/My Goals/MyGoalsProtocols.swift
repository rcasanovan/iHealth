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
}

protocol MyGoalsPresenterDelegate : class {
    func viewDidLoad()
}

// Presenter / Interactor
protocol MyGoalsInteractorDelegate : class {
}

// Presenter / Router

protocol MyGoalsRouterDelegate : class {
}
