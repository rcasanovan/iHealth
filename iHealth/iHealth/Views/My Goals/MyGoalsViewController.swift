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
        setupViews()
        presenter?.viewDidLoad()
    }
    
}

// MARK: - Setup views
extension MyGoalsViewController {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        view.backgroundColor = .white
        edgesForExtendedLayout = []
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        registerCells()
        setupDatasource()
    }
    
    /**
     * Register all the cells we need
     */
    private func registerCells() {
    }
    
    /**
     * Setup datasource for my goals table view
     */
    private func setupDatasource() {
    }
    
}

// MARK: - Layout & constraints
extension MyGoalsViewController {
    
    /**
     * Add subviews
     */
    private func addSubviews() {
    }
    
}

extension MyGoalsViewController: MyGoalsViewInjection {
    
}
