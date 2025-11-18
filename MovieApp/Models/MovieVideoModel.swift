//
//  MovieVideoModel.swift
//  MovieApp
//
//  Created by ihub on 19/11/25.
//


struct MovieVideoModel: BaseSwiftyJSON {
    var id: Int
    var results: [MovieVideoData]
    
    init(json: JSONLocal) {
        self.id = json["id"].intValue
        self.results = json["results"].arrayValue.compactMap { MovieVideoData(json: $0) }
    }
}

struct MovieVideoData: BaseSwiftyJSON {
    var key: String
    var name: String
    var site: String
    var type: String
    
    init(json: JSONLocal) {
        self.key = json["key"].stringValue
        self.name = json["name"].stringValue
        self.site = json["site"].stringValue
        self.type = json["type"].stringValue
    }
}
