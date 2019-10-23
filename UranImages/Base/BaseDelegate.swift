//
//  BaseDelegate.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import Foundation

protocol BaseDelegate: class {
    func showActivityIndicator()
    func hideActivityIndicator()
    func showAlertView(title: String, message: String)
    func reloadDataWith(_ items: [Photo])
}
