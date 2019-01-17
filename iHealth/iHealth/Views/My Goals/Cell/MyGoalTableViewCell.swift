//
//  MyGoalTableViewCell.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class MyGoalTableViewCell: UITableViewCell {
    
    private let goalView: GoalView = GoalView()
    
    static public var identifier: String {
        return String(describing: self)
    }
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        goalView.clear()
    }
    
    public func bindWithViewModel(_ viewModel: MyGoalViewModel) {
    }
    
}

// MARK: - Setup views
extension MyGoalTableViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubviews()
    }
    
}

// MARK: - Layout & constraints
extension MyGoalTableViewCell {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct GoalView {
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
            static let top: CGFloat = 16.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(goalView)
        
        addConstraintsWithFormat("H:|-\(Layout.GoalView.leading)-[v0]-\(Layout.GoalView.trailing)-|", views: goalView)
        addConstraintsWithFormat("V:|-\(Layout.GoalView.top)-[v0(\(goalView.height))]|", views: goalView)
    }
    
}

