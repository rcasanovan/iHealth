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

extension GoalsPresenter {
    
    private func getGoals() {
        view?.showProgress(true, status: "Loading goals")
        
        interactor.getGoalsList { [weak self] (goals, success, error) in
            guard let `self` = self else { return }
            
            self.view?.showProgress(false)
            
            if let goals = goals {
                self.view?.loadGoals(goals)
                return
            }
            
            if let error = error {
                self.view?.showMessageWith(title: "Oops... 🧐", message: error.localizedDescription, actionTitle: "Accept")
                return
            }
            
            if !success {
                self.view?.showMessageWith(title: "Oops... 🧐", message: "Something wrong happened. Please try again", actionTitle: "Accept")
                return
            }
        }
    }
    
}

extension GoalsPresenter: GoalsPresenterDelegate {
    
    func viewDidLoad() {
        getGoals()
    }
    
    func refresh() {
        interactor.clear()
        getGoals()
    }
    
}
