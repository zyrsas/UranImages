//
//  NetworkExtension.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import Moya

typealias JSON = [String: Any]

protocol APIRequestParameters {
    var parameters: JSON { get }
}

extension APIRequestParameters {
    var parameters: JSON { return JSON() }
}
