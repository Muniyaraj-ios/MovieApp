//
//  MovieCastModel.swift
//  MovieApp
//
//  Created by ihub on 19/11/25.
//


struct MovieCastModel: BaseSwiftyJSON {
    var cast: [CastData]
    var crew: [CrewData]
    
    init(json: JSONLocal) {
        self.cast = json["cast"].arrayValue.compactMap { CastData(json: $0) }
        self.crew = json["crew"].arrayValue.compactMap { CrewData(json: $0) }
    }
}

struct CastData: BaseSwiftyJSON {
    var id: Int
    var name: String
    var character: String
    var profile_path: String
    
    init(json: JSONLocal) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.character = json["character"].stringValue
        self.profile_path = json["profile_path"].stringValue
    }
}

struct CrewData: BaseSwiftyJSON {
    var id: Int
    var name: String
    var job: String
    var department: String
    var profile_path: String
    
    init(json: JSONLocal) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.job = json["job"].stringValue
        self.department = json["department"].stringValue
        self.profile_path = json["profile_path"].stringValue
    }
}
