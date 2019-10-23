//
//  SearchModel.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import ObjectMapper

struct SearchModel: Mappable {
    var total: Int?
    var total_pages: Int?
    var results: [Photo] = []
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        total <- map["total"]
        total_pages <- map["total_pages"]
        results <- map["results"]
    }
}
