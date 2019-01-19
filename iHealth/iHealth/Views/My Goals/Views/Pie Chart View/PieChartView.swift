//
//  PieChartView.swift
//  iHealth
//
//  Created by Ricardo Casanova on 17/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import UIKit

class PieChartView: UIView {
    
    private let pieChart: XYPieChart = XYPieChart()
    private let percentageLabel: UILabel = UILabel()
    
    private var percentage: CGFloat?
    private var percentageColor: UIColor?
    
    public var width: CGFloat {
        return Layout.width
    }
    
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
        percentage = viewModel.percentage
        percentageColor = viewModel.percentageColor
        percentageLabel.text = viewModel.percentageTitle
        pieChart.reloadData()
    }
    
    public func clear() {
    }
    
}

// MARK: - Setup views
extension PieChartView {
    
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
        pieChart.dataSource = self
        pieChart.animationSpeed = 1.5
        pieChart.showPercentage = false
        pieChart.showLabel = false
        pieChart.pieCenter = CGPoint(x: Layout.width / 2, y: Layout.width / 2)
        pieChart.setPieBackgroundColor(UIColor.clear)
        pieChart.isUserInteractionEnabled = false
        pieChart.pieRadius = Layout.width / 2
        pieChart.labelRadius = Layout.width / 2
        
        percentageLabel.layer.cornerRadius = Layout.PercentageLabel.width / 2
        percentageLabel.clipsToBounds = true
        percentageLabel.backgroundColor = .black()
        percentageLabel.textColor = .white()
        percentageLabel.font = UIFont.mediumWithSize(size: 14.0)
        percentageLabel.textAlignment = .center
        percentageLabel.adjustsFontSizeToFitWidth = true
    }
    
}

// MARK: - Layout & constraints
extension PieChartView {
    
    /**
     * Internal struct for layout
     */
    private struct Layout {
        
        static let width: CGFloat = 80.0
        static let height: CGFloat = 80.0
        static let slices: UInt = 2
        
        struct PercentageLabel {
            static let width: CGFloat = 60.0
            static let leading: CGFloat = 10.0
            static let trailing: CGFloat = 10.0
            static let top: CGFloat = 10.0
            static let bottom: CGFloat = 10.0
        }
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(pieChart)
        addSubview(percentageLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: pieChart)
        addConstraintsWithFormat("V:|[v0]|", views: pieChart)
        
        addConstraintsWithFormat("H:|-\(Layout.PercentageLabel.leading)-[v0]-\(Layout.PercentageLabel.trailing)-|", views: percentageLabel)
        addConstraintsWithFormat("V:|-\(Layout.PercentageLabel.top)-[v0]-\(Layout.PercentageLabel.bottom)-|", views: percentageLabel)
    }
    
}

extension PieChartView: XYPieChartDataSource {
    
    func numberOfSlices(in pieChart: XYPieChart!) -> UInt {
        return Layout.slices
    }
    
    func pieChart(_ pieChart: XYPieChart!, colorForSliceAt index: UInt) -> UIColor! {
        switch index {
        case 0:
            return percentageColor ?? .clear
        default:
            return .white()
        }
    }
    
    func pieChart(_ pieChart: XYPieChart!, valueForSliceAt index: UInt) -> CGFloat {
        guard let percentage = percentage else {
            return 0.0
        }
        switch index {
        case 0:
            return percentage
        default:
            return 100.0 - percentage
        }
    }
    
}


