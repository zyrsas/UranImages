//
//  NetworkKeys.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import Foundation

struct NetworkKeys {
    static let page = "page"
    static let perPage = "per_page"
}

struct PaginationKey: APIRequestParameters {
    let page: Int
    let per_page: Int
}
