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
        setupViews()
        presenter?.viewDidLoad()
    }
    
}

// MARK: - Setup views
extension GoalsViewController {
    
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
     * Setup datasource for the goals table view
     */
    private func setupDatasource() {
    }
    
}

// MARK: - Layout & constraints
extension GoalsViewController {

    /**
     * Add subviews
     */
    private func addSubviews() {
    }
    
}

extension GoalsViewController: GoalsViewInjection {
    
    func showProgress(_ show: Bool, status: String) {
        showLoader(show, status: status)
    }
    
    func showProgress(_ show: Bool) {
        showLoader(show)
    }
    
    func showMessageWith(title: String, message: String, actionTitle: String) {
        showAlertWith(title: title, message: message, actionTitle: actionTitle)
    }
}
