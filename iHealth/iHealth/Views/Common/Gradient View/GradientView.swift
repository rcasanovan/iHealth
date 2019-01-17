//
//  GradientView.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

class GradientView: UIView {
    
    public var colors: [CGColor] = [CGColor]() {
        didSet {
            if let gradientLayer = layer as? CAGradientLayer {
                gradientLayer.colors = colors
            }
        }
    }
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
