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

extension MyGoalsPresenter: MyGoalsPresenterDelegate {
    
    func viewDidLoad() {
    }
    
}