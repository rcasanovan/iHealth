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
}

protocol GoalsPresenterDelegate : class {
    func viewDidLoad()
}

// Presenter / Interactor

protocol GoalsInteractorDelegate : class {
}

// Presenter / Router

protocol GoalsRouterDelegate : class {
}
