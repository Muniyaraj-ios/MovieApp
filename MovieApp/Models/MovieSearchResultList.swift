//
//  MovieSearchResultList.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import Foundation

struct MovieSearchResultList: BaseSwiftyJSON{
    var id: Int
    var results: [MovieListData]
    
    init(json: JSONLocal) {
        self.id = json["id"].intValue
        self.results = json["results"].arrayValue.compactMap{ MovieListData(json: $0) }
    }
}

struct MovieSearchResultData: BaseSwiftyJSON{
    var iso_639_1: String
    var iso_3166_1: String
    var name: String
    var key: String
    var site: String
    var size: Int
    var type: String
    var official: Bool
    var published_at: String
    var id: String
    
    init(json: JSONLocal) {
        self.iso_639_1 = json["iso_639_1"].stringValue
        self.iso_3166_1 = json["iso_3166_1"].stringValue
        self.name = json["name"].stringValue
        self.key = json["key"].stringValue
        self.site = json["site"].stringValue
        self.size = json["size"].intValue
        self.type = json["type"].stringValue
        self.official = json["official"].boolValue
        self.published_at = json["published_at"].stringValue
        self.id = json["id"].stringValue
    }
}
