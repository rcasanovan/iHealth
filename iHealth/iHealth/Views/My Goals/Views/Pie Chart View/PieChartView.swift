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
        pieChart.pieCenter = CGPoint(x: 40.0, y: 40.0)
        pieChart.setPieBackgroundColor(UIColor.clear)
        pieChart.isUserInteractionEnabled = false
        pieChart.pieRadius = 40.0
        pieChart.labelRadius = 40.0
        
        percentageLabel.layer.cornerRadius = 60.0 / 2
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
        
    }
    
    /**
     * Add subviews
     */
    private func addSubviews() {
        addSubview(pieChart)
        addSubview(percentageLabel)
        
        addConstraintsWithFormat("H:|[v0]|", views: pieChart)
        addConstraintsWithFormat("V:|[v0]|", views: pieChart)
        
        addConstraintsWithFormat("H:|-10.0-[v0]-10.0-|", views: percentageLabel)
        addConstraintsWithFormat("V:|-10.0-[v0]-10.0-|", views: percentageLabel)
    }
    
}

extension PieChartView: XYPieChartDataSource {
    
    func numberOfSlices(in pieChart: XYPieChart!) -> UInt {
        return 2
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


