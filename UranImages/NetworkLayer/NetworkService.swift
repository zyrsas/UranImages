//
//  NetworkService.swift
//  UranImages
//
//  Created by Sasha on 21.10.2019.
//  Copyright © 2019 Sasha. All rights reserved.
//

import Moya

private struct Keys {
    static let baseUrl = "https://api.unsplash.com/"
    static let apiKey = "4c9fbfbbd92c17a2e95081cec370b4511659666240eb4db9416c40c641ee843b"
    static let clientId = "Client-ID"
}

enum PhotosAPI {
    case photos(PhotosKey)
    case searchPhotos(SearchKey)
}

extension PhotosAPI: TargetType {
    
    public var baseURL: URL {
        return URL(string: Keys.baseUrl)!
    }
    
    public var path: String {
        switch self {
        case .photos:
            return "photos"
        case .searchPhotos:
            return "search/photos"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .photos(let photosKey):
            return .requestParameters(parameters: [
                                                    NetworkKeys.page: photosKey.page,
                                                    NetworkKeys.perPage: photosKey.per_page
                                                    ],
                                      encoding: URLEncoding.default)
        case .searchPhotos(let searchKey):
            return .requestParameters(parameters: [
                                                    NetworkKeys.page: searchKey.page,
                                                    NetworkKeys.perPage: searchKey.per_page,
                                                    NetworkKeys.query: searchKey.query
                                                    ],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    public var headers: [String : String]? {
        return [
            "Authorization": "\(Keys.clientId) \(Keys.apiKey)"
                ]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
