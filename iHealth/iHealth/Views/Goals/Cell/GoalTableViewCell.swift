//
//  GoalTableViewCell.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    
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
    }
    
    public func bindWithViewModel(_ viewModel: GoalViewModel) {
    }
    
}

// MARK: - Setup views
extension GoalTableViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .yellow
        selectionStyle = .none
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
    }
    
}

// MARK: - Layout & constraints
extension GoalTableViewCell {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let bottom: CGFloat = 10.0
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
    }
    
}
