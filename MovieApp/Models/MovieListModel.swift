//
//  MovieListModel.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import Foundation

struct MovieListModel: BaseSwiftyJSON{
    var page: Int
    var total_pages: Int
    var total_results: Int
    var results: [MovieListData]
    
    init(json: JSONLocal) {
        self.page = json["page"].intValue
        self.total_pages = json["total_pages"].intValue
        self.total_results = json["total_results"].intValue
        self.results = json["results"].arrayValue.compactMap{ MovieListData(json: $0) }
    }
}

struct MovieListData: BaseSwiftyJSON{
    var adult: Bool
    var backdrop_path: String
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Double
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Double
    var vote_count: Int
    
    init(json: JSONLocal) {
        self.adult = json["adult"].boolValue
        self.backdrop_path = json["backdrop_path"].stringValue
        self.genre_ids = json["genre_ids"].arrayValue.compactMap{ $0.intValue }
        self.id = json["id"].intValue
        self.original_language = json["original_language"].stringValue
        self.original_title = json["original_title"].stringValue
        self.overview = json["overview"].stringValue
        self.popularity = json["popularity"].doubleValue
        self.poster_path = json["poster_path"].stringValue
        self.release_date = json["release_date"].stringValue
        self.title = json["title"].stringValue
        self.video = json["video"].boolValue
        self.vote_average = json["vote_average"].doubleValue
        self.vote_count = json["vote_count"].intValue
    }
    
}
