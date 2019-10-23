//
//  RemoteImageView.swift
//  UranImages
//
//  Created by Sasha on 23.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import UIKit

class RemoteImageView: UIImageView {

    private let imageCache = NSCache<NSString, UIImage>()
    
    func imageFromServerURL(_ URLString: String, placeHolder: UIImage? = nil) {
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
            self.image = cachedImage
            return
        }

        if let url = URL(string: URLString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            self.imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
    
}
