//
//  GoalsViewController.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class GoalsViewController: BaseViewController {
    
    public var presenter: GoalsPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}

extension GoalsViewController: GoalsViewInjection {
    
}
