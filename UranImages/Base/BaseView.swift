//
//  BaseView.swift
//  UranImages
//
//  Created by Sasha on 22.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    var isLoaded = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        configure()
    }
    
    private func configure() {
        if !isLoaded && superview != nil {
            isLoaded = true
            
            addSubViews()
            setupUI()
            onViewLoaded()
        }
    }
    
    open func onViewLoaded() {
        
    }
    
    open func addSubViews() {

    }
    
    open func setupUI() {
        backgroundColor = .white
    }
    
}
