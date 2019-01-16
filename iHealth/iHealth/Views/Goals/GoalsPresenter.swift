//
//  GoalsPresenter.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class GoalsPresenter {
    
    private weak var view: GoalsViewInjection?
    private let interactor: GoalsInteractorDelegate
    
    // MARK - Lifecycle
    init(view: GoalsViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = GoalsInteractor()
    }
    
}

extension GoalsPresenter: GoalsPresenterDelegate {
    
    func viewDidLoad() {
    }
    
}
