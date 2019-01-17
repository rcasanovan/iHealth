//
//  GoalTableViewCell.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    
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
    
    public func bindWithViewModel(_ viewModel: GoalViewModel) {
        goalView.bindWithViewModel(viewModel)
    }
    
}

// MARK: - Setup views
extension GoalTableViewCell {
    
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
extension GoalTableViewCell {
    
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
