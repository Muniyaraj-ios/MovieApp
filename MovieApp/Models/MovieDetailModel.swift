//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import Foundation

struct MovieDetailModel: BaseSwiftyJSON{
    var adult: Bool
    var backdrop_path: String
    var budget: Int
    var id: Int
    var imdb_id: String
    var origin_country: [String]
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: String
    var poster_path: String
    var release_date: String
    var revenue: Int
    var runtime: Int
    var status: String
    var tagline: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
    var genres: [genresData]
    var production_companies: [ProdCompanyData]
    var production_countries: [ProdCountryData]
    var spoken_languages: [SpokenLangData]
    
    init(json: JSONLocal) {
        self.adult = json["adult"].boolValue
        self.backdrop_path = json["backdrop_path"].stringValue
        self.budget = json["budget"].intValue
        self.id = json["id"].intValue
        self.imdb_id = json["imdb_id"].stringValue
        self.origin_country = json["origin_country"].arrayValue.compactMap{ $0.stringValue }
        self.original_language = json["original_language"].stringValue
        self.original_title = json["original_title"].stringValue
        self.overview = json["overview"].stringValue
        self.popularity = json["popularity"].stringValue
        self.poster_path = json["poster_path"].stringValue
        self.release_date = json["release_date"].stringValue
        self.revenue = json["revenue"].intValue
        self.runtime = json["runtime"].intValue
        self.status = json["status"].stringValue
        self.tagline = json["tagline"].stringValue
        self.title = json["title"].stringValue
        self.video = json["video"].boolValue
        self.vote_average = json["vote_average"].doubleValue
        self.vote_count = json["vote_count"].intValue
        self.genres = json["genres"].arrayValue.compactMap{ genresData(json: $0) }
        self.production_companies = json["production_companies"].arrayValue.compactMap{ ProdCompanyData(json: $0) }
        self.production_countries = json["production_countries"].arrayValue.compactMap{ ProdCountryData(json: $0) }
        self.spoken_languages = json["spoken_languages"].arrayValue.compactMap{ SpokenLangData(json: $0) }
    }
}

struct genresData: BaseSwiftyJSON{
    var id: Int
    var name: String
    
    init(json: JSONLocal) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
    }
}

struct ProdCompanyData: BaseSwiftyJSON{
    var id: Int
    var name: String
    var logo_path: String
    var origin_country: String
    
    init(json: JSONLocal) {
        self.id = json["id"].intValue
        self.name = json["name"].stringValue
        self.logo_path = json["logo_path"].stringValue
        self.origin_country = json["origin_country"].stringValue
    }
}

struct ProdCountryData: BaseSwiftyJSON{
    var iso_3166_1: String
    var name: String
    
    init(json: JSONLocal) {
        self.iso_3166_1 = json["namiso_3166_1e"].stringValue
        self.name = json["name"].stringValue
    }
}
struct SpokenLangData: BaseSwiftyJSON{
    var english_name: String
    var iso_639_1: String
    var name: String
    
    init(json: JSONLocal) {
        self.english_name = json["english_name"].stringValue
        self.iso_639_1 = json["iso_639_1"].stringValue
        self.name = json["name"].stringValue
    }
}
