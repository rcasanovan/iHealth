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
    
    private let goalsContainerView: UIView = UIView()
    private var goalsTableView: UITableView?
    private var datasource: GoalsDatasource?
    private var refreshControl: UIRefreshControl = UIRefreshControl()
    
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
        goalsContainerView.backgroundColor = .clear
        goalsTableView = UITableView(frame: goalsContainerView.bounds, style: .plain)
        goalsTableView?.tableFooterView = UIView()
        goalsTableView?.separatorStyle = .none
        goalsTableView?.rowHeight = UITableView.automaticDimension
        goalsTableView?.invalidateIntrinsicContentSize()
        goalsTableView?.backgroundColor = .white
        goalsTableView?.showsVerticalScrollIndicator = false
        
//        refreshControl.addTarget(self, action: #selector(userDidPullToRefresh), for: .valueChanged)
//        refreshControl.tintColor = .black
//        goalsTableView?.addSubview(refreshControl)
        
        registerCells()
        setupDatasource()
    }
    
    /**
     * Register all the cells we need
     */
    private func registerCells() {
        goalsTableView?.register(GoalTableViewCell.self, forCellReuseIdentifier: GoalTableViewCell.identifier)
    }
    
    /**
     * Setup datasource for the goals table view
     */
    private func setupDatasource() {
        if let goalsTableView = goalsTableView {
            datasource = GoalsDatasource()
            goalsTableView.dataSource = datasource
        }
    }
    
}

// MARK: - Layout & constraints
extension GoalsViewController {

    /**
     * Add subviews
     */
    private func addSubviews() {
        view.addSubview(goalsContainerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: goalsContainerView)
        view.addConstraintsWithFormat("V:|[v0]|", views: goalsContainerView)
        
        if let goalsTableView = goalsTableView {
            goalsContainerView.addSubview(goalsTableView)
            goalsContainerView.addConstraintsWithFormat("H:|[v0]|", views: goalsTableView)
            goalsContainerView.addConstraintsWithFormat("V:|[v0]|", views: goalsTableView)
        }
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
