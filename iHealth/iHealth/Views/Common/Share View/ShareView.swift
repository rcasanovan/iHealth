//
//  ShareView.swift
//  iHealth
//
//  Created by Ricardo Casanova on 18/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

protocol ShareViewDelegate: class {
    func shareViewPressed()
}

class ShareView: UIView {
    
    public weak var delegate: ShareViewDelegate?
    
    private let shareButton: UIButton = UIButton(type: .custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
}

// MARK: - Setup views
extension ShareView {
    
    private func setupViews() {
        backgroundColor = .clear
        
        configureSubviews()
        addSubviews()
    }
    
    private func configureSubviews() {
        shareButton.setTitleColor(.black, for: .normal)
        shareButton.setBackgroundImage(UIImage(named: "shareIcon"), for: .normal)
        shareButton.setBackgroundImage(UIImage(named: "shareIcon"), for: .highlighted)
        shareButton.addTarget(self, action: #selector(shareButtonPressed) , for: .touchUpInside)
    }
    
}

// MARK: - User actions
extension ShareView {
    
    @objc private func shareButtonPressed() {
        delegate?.shareViewPressed()
    }
    
}

// MARK: - Layout & constraints
extension ShareView {
    
    private func addSubviews() {
        //__ Add subviews
        addSubview(shareButton)
        
        //__ Add constraints
        addConstraintsWithFormat("H:|[v0]|", views: shareButton)
        addConstraintsWithFormat("V:|[v0]|", views: shareButton)
    }
    
}
