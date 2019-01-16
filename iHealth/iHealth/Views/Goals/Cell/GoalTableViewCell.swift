//
//  GoalTableViewCell.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class GoalTableViewCell: UITableViewCell {
    
    private let goalBackgroundView: GradientView = GradientView()
    private let goalImageView: UIImageView = UIImageView()
    
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
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        goalBackgroundView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 15.0)
    }
    
}

// MARK: - Setup views
extension GoalTableViewCell {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .white
        selectionStyle = .none
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {        
        goalBackgroundView.colors = [UIColor.colorWithHex(hex: "#ff6855").cgColor, UIColor.colorWithHex(hex: "#fe5c46").cgColor, UIColor.colorWithHex(hex: "#ff5350").cgColor, UIColor.colorWithHex(hex: "#fe4e36").cgColor]
        
        goalImageView.backgroundColor = .yellow
    }
    
}

// MARK: - Layout & constraints
extension GoalTableViewCell {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        struct GoalBackgroundView {
            static let leading: CGFloat = 16.0
            static let trailing: CGFloat = 16.0
            static let top: CGFloat = 16.0
            static let height: CGFloat = 80.0
        }
        
        struct GoalImageView {
            static let leading: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 60.0
            static let width: CGFloat = 60.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(goalBackgroundView)
        goalBackgroundView.addSubview(goalImageView)
        
        addConstraintsWithFormat("H:|-\(Layout.GoalBackgroundView.leading)-[v0]-\(Layout.GoalBackgroundView.trailing)-|", views: goalBackgroundView)
        addConstraintsWithFormat("V:|-\(Layout.GoalBackgroundView.top)-[v0(\(Layout.GoalBackgroundView.height))]|", views: goalBackgroundView)
        
        goalBackgroundView.addConstraintsWithFormat("H:|-\(Layout.GoalImageView.leading)-[v0(\(Layout.GoalImageView.width))]", views: goalImageView)
        goalBackgroundView.addConstraintsWithFormat("V:|-\(Layout.GoalImageView.top)-[v0(\(Layout.GoalImageView.height))]|", views: goalImageView)
    }
    
}
