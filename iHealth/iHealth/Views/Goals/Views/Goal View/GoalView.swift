//
//  GoalView.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class GoalView: UIView {
    
    private let goalBackgroundView: GradientView = GradientView()
    private let goalImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let subtitleLabel: UILabel = UILabel()
    private let valueTitleLabel: UILabel = UILabel()
    private let valueSubtitleLabel: UILabel = UILabel()
    
    public var height: CGFloat {
        return Layout.height
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    public func bindWithViewModel(_ viewModel: GoalViewModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.description
        subtitleLabel.numberOfLines = 0
        valueTitleLabel.text = viewModel.goal
        valueSubtitleLabel.text = viewModel.goalType
    }
    
    public func clear() {
        goalImageView.image = nil
        titleLabel.text = ""
        subtitleLabel.text = ""
        valueTitleLabel.text = ""
        valueSubtitleLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        goalBackgroundView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 15.0)
    }
    
}

// MARK: - Setup views
extension GoalView {
    
    /**
     * SetupViews
     */
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubviews()
        addSubviews()
    }
    
    /**
     * ConfigureSubviews
     */
    private func configureSubviews() {
        goalBackgroundView.colors = [UIColor.colorWithHex(hex: "#ff6855").cgColor, UIColor.colorWithHex(hex: "#fe5c46").cgColor, UIColor.colorWithHex(hex: "#ff5350").cgColor, UIColor.colorWithHex(hex: "#fe4e36").cgColor]
        
        goalImageView.backgroundColor = .yellow
        
        titleLabel.font = UIFont.boldWithSize(size: 15.0)
        titleLabel.textColor = .white
        
        subtitleLabel.font = UIFont.regularWithSize(size: 13.0)
        subtitleLabel.textColor = .white
        
        valueTitleLabel.font = UIFont.mediumWithSize(size: 32.0)
        valueTitleLabel.textColor = .white
        valueTitleLabel.textAlignment = .right
        
        valueSubtitleLabel.font = UIFont.mediumWithSize(size: 14.0)
        valueSubtitleLabel.textColor = .white
        valueSubtitleLabel.textAlignment = .right
    }
    
}

// MARK: - Layout & constraints
extension GoalView {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let height: CGFloat = 100.0
        
        struct GoalImageView {
            static let leading: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 60.0
            static let width: CGFloat = 60.0
        }
        
        struct TitleLabel {
            static let leading: CGFloat = 10.0
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 18.0
        }
        
        struct SubtitleLabel {
            static let leading: CGFloat = 10.0
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let bottom: CGFloat = 10.0
        }
        
        struct ValueTitleLabel {
            static let trailing: CGFloat = 5.0
            static let bottom: CGFloat = 10.0
            static let width: CGFloat = 80.0
        }
        
        struct ValueSubtitleLabel {
            static let trailing: CGFloat = 10.0
            static let bottom: CGFloat = 13.0
            static let width: CGFloat = 40.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(goalBackgroundView)
        addSubview(goalImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(valueTitleLabel)
        addSubview(valueSubtitleLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: goalBackgroundView)
        addConstraintsWithFormat("V:|[v0(\(Layout.height))]|", views: goalBackgroundView)
        
        addConstraintsWithFormat("H:|-\(Layout.GoalImageView.leading)-[v0(\(Layout.GoalImageView.width))]", views: goalImageView)
        addConstraintsWithFormat("V:|-\(Layout.GoalImageView.top)-[v0(\(Layout.GoalImageView.height))]", views: goalImageView)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.TitleLabel.leading)-[v1]-\(Layout.TitleLabel.trailing)-[v2]", views: goalImageView, titleLabel, valueTitleLabel)
        addConstraintsWithFormat("V:|-\(Layout.TitleLabel.top)-[v0(\(Layout.TitleLabel.height))]", views: titleLabel)

        addConstraintsWithFormat("H:[v0]-\(Layout.SubtitleLabel.leading)-[v1]-\(Layout.SubtitleLabel.trailing)-[v2]", views: goalImageView, subtitleLabel, valueTitleLabel)
        addConstraintsWithFormat("V:[v0]-\(Layout.SubtitleLabel.top)-[v1(>=0.0)]-\(Layout.SubtitleLabel.bottom)-|", views: titleLabel, subtitleLabel)

        addConstraintsWithFormat("H:[v0(\(Layout.ValueTitleLabel.width))]-\(Layout.ValueTitleLabel.trailing)-[v1]", views: valueTitleLabel, valueSubtitleLabel)
        addConstraintsWithFormat("V:[v0(>=0.0)]-\(Layout.ValueTitleLabel.bottom)-|", views: valueTitleLabel)

        addConstraintsWithFormat("H:[v0(\(Layout.ValueSubtitleLabel.width))]-\(Layout.ValueSubtitleLabel.trailing)-|", views: valueSubtitleLabel)
        addConstraintsWithFormat("V:[v0(>=0.0)]-\(Layout.ValueSubtitleLabel.bottom)-|", views: valueSubtitleLabel)
    }
    
}
