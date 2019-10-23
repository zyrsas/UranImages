//
//  ImageViewerView.swift
//  UranImages
//
//  Created by Sasha on 22.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import UIKit

class ImageViewerView: BaseView {
    
    // MARK: - UI Elements

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let ai = UIActivityIndicatorView(style: .medium)
        return ai
    }()
    
    private lazy var photoImage: UIImageView = {
        let photoImage = UIImageView()
        photoImage.clipsToBounds = true
        photoImage.contentMode = .scaleAspectFit
        return photoImage
    }()
    
    // MARK: - Life cycle

    override func addSubViews() {
        addSubview(photoImage)
        addSubview(activityIndicator)
        photoImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Setup

    public func setupWithImage(_ photo: Photo) {
        photoImage.image = nil
        DispatchQueue.global(qos: .utility).async {
            let imageData = NSData(contentsOf: URL(string: photo.urls?.regular ?? "")!)!
            DispatchQueue.main.async {
                let image = UIImage(data: imageData as Data)
                self.photoImage.image = image
                self.activityIndicator.stopAnimating()
            }
        }
        
        if photoImage.image == nil {
            activityIndicator.startAnimating()
        }
    }
}
