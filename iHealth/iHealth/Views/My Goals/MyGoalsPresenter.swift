//
//  MyGoalsPresenter.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class MyGoalsPresenter {
    
    private weak var view: MyGoalsViewInjection?
    private let interactor: MyGoalsInteractorDelegate
    
    // MARK - Lifecycle
    init(view: MyGoalsViewInjection, navigationController: UINavigationController? = nil) {
        self.view = view
        self.interactor = MyGoalsInteractor()
    }
    
}

extension MyGoalsPresenter {
    
    private func getMyGoals() {
        interactor.getMyGoals { [weak self] (myGoals) in
            guard let `self` = self else { return }
            self.view?.loadMyGoals(myGoals)
        }
    }
    
}

extension MyGoalsPresenter {
    
    private func requestHealtAuthorizationIfNeeded() {
        interactor.requestHealthAuthorizationIfNeeded { [weak self] (success, error) in
            guard let `self` = self else { return }
            
            if let error = error {
                self.view?.showMessageWith(title: "Oops... 🧐", message: error.localizedDescription, actionTitle: "Accept")
                return
            }
            
            if !success {
                self.view?.showMessageWith(title: "Oops... 🧐", message: "Something wrong happened. Please try again", actionTitle: "Accept")
                return
            }
            
            self.getMyGoals()
        }
    }
    
}

extension MyGoalsPresenter: MyGoalsPresenterDelegate {
    
    func viewDidLoad() {
        requestHealtAuthorizationIfNeeded()
    }
    
    func viewDidAppear() {
        getMyGoals()
    }
    
    func sharePressed() {
        guard let view = view as? UIViewController else {
            return
        }
        var items: [Any] = ["🏃🏻‍♂️ Hey!. Check my progress with this amazing app!. You can check the project here: https://github.com/rcasanovan/iHealth"]
        
        if let image = Device.takeScreenshot() {
            items.append(image)
        }
        
        ShareManager.shared.share(items, from: view)
    }
    
}
