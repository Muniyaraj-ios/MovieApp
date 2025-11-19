//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import Foundation

class MovieDetailViewModel: ObservableObject{
    
    @Published var movie_detail: MovieDetailModel? = nil
    @Published var trailerKey: String?
    @Published var castList: [CastData] = []
    @Published var crewList: [CrewData] = []
    
    private let service = NetworkService()
    private var isLoading = false
    let movie_id: Int
    
    var favorites: Set<Int> = []{
        didSet{
            isFavorite = favorites.contains(movie_id)
        }
    }
    
    @Published var isFavorite: Bool = false
    private let FAVORITES_KEY = "favorite_movies"
    
    init(movie_id: Int){
        self.movie_id = movie_id
        self.loadFavorites()
    }
    
    @MainActor
       func loadMovies() async {
           await withTaskGroup(of: Void.self) { group in
               
               group.addTask { await self.fetchMovieDetail() }
               group.addTask { await self.fetchTrailer() }
               group.addTask { await self.fetchCredits() }
           }
       }
       
       @MainActor
       private func fetchMovieDetail() async {
           do {
               let param = NetworkParams(endPoint: .movieDetail(movie: movie_id), method: .get)
               let response: MovieDetailModel = try await service.performNetworkService(networkParam: param)
               movie_detail = response
           } catch {
               print("DETAIL ERROR:", error)
           }
       }
    
       @MainActor
       private func fetchTrailer() async {
           do {
               let param = NetworkParams(endPoint: .videos(movie: movie_id), method: .get)
               let response: MovieVideoModel = try await service.performNetworkService(networkParam: param)
               
               trailerKey = response.results.first(where: {
                   $0.site == "YouTube" && $0.type == "Trailer"
               })?.key
               
           } catch {
               print("TRAILER ERROR:", error)
           }
       }
       
       @MainActor
       private func fetchCredits() async {
           do {
               let param = NetworkParams(endPoint: .credits(movie: movie_id), method: .get)
               let response: MovieCastModel = try await service.performNetworkService(networkParam: param)
               for cast in response.cast where !castList.contains(where: { $0.id == cast.id }){
                   castList.append(cast)
               }
               for crew in response.crew where !crewList.contains(where: { $0.id == crew.id }){
                   crewList.append(crew)
               }
//               castList = response.cast
//               crewList = response.crew
           } catch {
               print("CAST ERROR:", error)
           }
       }
    
}

extension MovieDetailViewModel{
    
    func toggleFavorite() {
        if favorites.contains(movie_id) {
            favorites.remove(movie_id)
        } else {
            favorites.insert(movie_id)
        }
        saveFavorites()
    }
    
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favorites), forKey: FAVORITES_KEY)
    }
    
    private func loadFavorites() {
        if let saved = UserDefaults.standard.array(forKey: FAVORITES_KEY) as? [Int] {
            favorites = Set(saved)
        }
    }
}
