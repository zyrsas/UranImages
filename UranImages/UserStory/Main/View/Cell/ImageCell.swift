//
//  ImageCell.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import UIKit
import SnapKit

class ImageCell: BaseCell {
    
    // MARK: - IDENTIFY
    
    static public let identity = "UserLabelInfoCell"
    
    // MARK: - UI Elements

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        return ai
    }()
    
    private lazy var photoImageView: RemoteImageView = {
        let image = RemoteImageView()
        return image
    }()
    
    // MARK: - Life cycle
    
    override func addSubViews() {
        addSubview(photoImageView)
        addSubview(activityIndicator)

        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Set Data

    public func setData(photo: Photo) {
        guard let url = photo.urls?.thumb else { return }
        photoImageView.imageFromServerURL(url)
    }
}
