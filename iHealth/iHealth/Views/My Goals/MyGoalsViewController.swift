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
    
    private let customTitleView: CustomTitleView = CustomTitleView()
    private let myGoalsContainerView: UIView = UIView()
    private var myGoalsTableView: UITableView?
    private var datasource: MyGoalsDatasource?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        configureNavigationBar()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
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
        myGoalsContainerView.backgroundColor = .clear
        myGoalsTableView = UITableView(frame: myGoalsContainerView.bounds, style: .plain)
        myGoalsTableView?.tableFooterView = UIView()
        myGoalsTableView?.separatorStyle = .none
        myGoalsTableView?.rowHeight = UITableView.automaticDimension
        myGoalsTableView?.invalidateIntrinsicContentSize()
        myGoalsTableView?.backgroundColor = .white
        myGoalsTableView?.showsVerticalScrollIndicator = false
        
        registerCells()
        setupDatasource()
    }
    
    private func configureNavigationBar() {
        customTitleView.titleColor = .white
        customTitleView.setTitle("My goals")
        customTitleView.subtitleColor = .white
        customTitleView.setSubtitle("...")
        navigationItem.titleView = customTitleView
    }
    
    /**
     * Register all the cells we need
     */
    private func registerCells() {
        myGoalsTableView?.register(MyGoalTableViewCell.self, forCellReuseIdentifier: MyGoalTableViewCell.identifier)
    }
    
    /**
     * Setup datasource for my goals table view
     */
    private func setupDatasource() {
        if let myGoalsTableView = myGoalsTableView {
            datasource = MyGoalsDatasource()
            myGoalsTableView.dataSource = datasource
        }
    }
    
}

// MARK: - Layout & constraints
extension MyGoalsViewController {
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        view.addSubview(myGoalsContainerView)
        
        view.addConstraintsWithFormat("H:|[v0]|", views: myGoalsContainerView)
        view.addConstraintsWithFormat("V:|[v0]|", views: myGoalsContainerView)
        
        if let myGoalsTableView = myGoalsTableView {
            myGoalsContainerView.addSubview(myGoalsTableView)
            myGoalsContainerView.addConstraintsWithFormat("H:|[v0]|", views: myGoalsTableView)
            myGoalsContainerView.addConstraintsWithFormat("V:|[v0]|", views: myGoalsTableView)
        }
    }
    
}

extension MyGoalsViewController: MyGoalsViewInjection {
    
    func showMessageWith(title: String, message: String, actionTitle: String) {
        showAlertWith(title: title, message: message, actionTitle: actionTitle)
    }
    
    
    func loadMyGoals(_ viewModels: [MyGoalViewModel]) {
        datasource?.myGoals = viewModels
        myGoalsTableView?.reloadData()
    }
    
}
