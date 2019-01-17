//
//  MyGoalTableViewCell.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class MyGoalTableViewCell: UITableViewCell {
    
    private let myGoalView: MyGoalView = MyGoalView()
    
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
        myGoalView.clear()
    }
    
    public func bindWithViewModel(_ viewModel: MyGoalViewModel) {
        myGoalView.bindWithViewModel(viewModel)
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
        
        struct MyGoalView {
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
            static let top: CGFloat = 16.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(myGoalView)
        
        addConstraintsWithFormat("H:|-\(Layout.MyGoalView.leading)-[v0]-\(Layout.MyGoalView.trailing)-|", views: myGoalView)
        addConstraintsWithFormat("V:|-\(Layout.MyGoalView.top)-[v0(\(myGoalView.height))]|", views: myGoalView)
    }
    
}

