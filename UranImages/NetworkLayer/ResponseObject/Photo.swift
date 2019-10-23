//
//  Photo.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import ObjectMapper
import DeepDiff

struct Photo: Mappable, DiffAware {
    var id: String?
    var urls: LinksObject?
    
    init?(map: Map) { }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        urls <- map["urls"]
    }
    
    public var diffId: Int {
        return id.hashValue
    }

    public static func compareContent(_ a: Photo, _ b: Photo) -> Bool {
        return a.id == b.id
    }
}

struct LinksObject: Mappable {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?

    init?(map: Map) { }
       
    mutating func mapping(map: Map) {
        raw <- map["raw"]
        full <- map["full"]
        regular <- map["regular"]
        small <- map["small"]
        thumb <- map["thumb"]
    }
}
