//
//  MyGoalsViewController.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class MyGoalsViewController: BaseViewController {
    
    public var presenter: MyGoalsPresenterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
}

extension MyGoalsViewController: MyGoalsViewInjection {
    
}
