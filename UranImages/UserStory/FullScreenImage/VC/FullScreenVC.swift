//
//  FullScreenVC.swift
//  UranImages
//
//  Created by Sasha on 22.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import Foundation

class FullScreenVC: BaseVC {
    
    // MARK: - UI Elements
    
    private var imageViewerView = ImageViewerView()
    
    // MARK: - New Instance
    
    static public func newInstance(photo: Photo) -> FullScreenVC {
        let vc = FullScreenVC()
        vc.imageViewerView.setupWithImage(photo)
        return vc
    }

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Setup Constrain
    
    override func setupConstraint() {
        view.addSubview(imageViewerView)
           
        imageViewerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.left.equalToSuperview().offset(15)
        }
    }
    
    // MARK: - Setup UI
    
    override func setupUI() {
        super.setupUI()
        title = "Image Viewer"
    }
}
