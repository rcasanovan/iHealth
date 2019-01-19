//
//  MyGoalView.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class MyGoalView: UIView {
    
    private let goalBackgroundView: GradientView = GradientView()
    private let pieChartView: PieChartView = PieChartView()
    private let titleLabel: UILabel = UILabel()
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
    
    public func bindWithViewModel(_ viewModel: MyGoalViewModel) {
        pieChartView.bindWithViewModel(viewModel)
        titleLabel.text = viewModel.title
        valueTitleLabel.text = viewModel.goal
        valueSubtitleLabel.text = viewModel.goalType
    }
    
    public func clear() {
        titleLabel.text = ""
        valueTitleLabel.text = ""
        valueSubtitleLabel.text = ""
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        goalBackgroundView.roundCorners(corners: [.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 15.0)
    }
    
}

// MARK: - Setup views
extension MyGoalView {
    
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
        goalBackgroundView.backgroundColor = .black()
                
        titleLabel.font = UIFont.boldWithSize(size: 15.0)
        titleLabel.textColor = .white()
        titleLabel.textAlignment = .right
        
        valueTitleLabel.font = UIFont.mediumWithSize(size: 32.0)
        valueTitleLabel.textColor = .white()
        valueTitleLabel.textAlignment = .right
        valueTitleLabel.adjustsFontSizeToFitWidth = true
        
        valueSubtitleLabel.font = UIFont.mediumWithSize(size: 14.0)
        valueSubtitleLabel.textColor = .white()
        valueSubtitleLabel.textAlignment = .right
        valueSubtitleLabel.adjustsFontSizeToFitWidth = true
    }
    
}

// MARK: - Layout & constraints
extension MyGoalView {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let height: CGFloat = 100.0
        
        struct GoalImageView {
            static let leading: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let height: CGFloat = 80.0
            static let width: CGFloat = 80.0
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
            static let leading: CGFloat = 10.0
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
        addSubview(pieChartView)
        addSubview(titleLabel)
        addSubview(valueTitleLabel)
        addSubview(valueSubtitleLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: goalBackgroundView)
        addConstraintsWithFormat("V:|[v0(\(Layout.height))]|", views: goalBackgroundView)
        
        addConstraintsWithFormat("H:|-\(Layout.GoalImageView.leading)-[v0(\(Layout.GoalImageView.width))]", views: pieChartView)
        addConstraintsWithFormat("V:|-\(Layout.GoalImageView.top)-[v0(\(Layout.GoalImageView.height))]", views: pieChartView)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.TitleLabel.leading)-[v1]-\(Layout.TitleLabel.trailing)-|", views: pieChartView, titleLabel)
        addConstraintsWithFormat("V:|-\(Layout.TitleLabel.top)-[v0(\(Layout.TitleLabel.height))]", views: titleLabel)
        
        addConstraintsWithFormat("H:[v0]-\(Layout.ValueTitleLabel.leading)-[v1]-\(Layout.ValueTitleLabel.trailing)-[v2]", views: pieChartView, valueTitleLabel, valueSubtitleLabel)
        addConstraintsWithFormat("V:[v0(>=0.0)]-\(Layout.ValueTitleLabel.bottom)-|", views: valueTitleLabel)
        
        addConstraintsWithFormat("H:[v0(\(Layout.ValueSubtitleLabel.width))]-\(Layout.ValueSubtitleLabel.trailing)-|", views: valueSubtitleLabel)
        addConstraintsWithFormat("V:[v0(>=0.0)]-\(Layout.ValueSubtitleLabel.bottom)-|", views: valueSubtitleLabel)
    }
    
}

