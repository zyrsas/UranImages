//
//  RequestKey.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import Foundation

protocol Pagination {
    var page: Int { get set }
    var per_page: Int { get set }
}

struct PhotosKey: Pagination, APIRequestParameters {
    var page: Int
    var per_page: Int
}

struct SearchKey: Pagination, APIRequestParameters {
    var page: Int
    var per_page: Int
    var query: String
}
