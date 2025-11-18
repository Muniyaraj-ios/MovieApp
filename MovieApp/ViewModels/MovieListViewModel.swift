//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import Foundation
import Combine
import SwiftUI

class MovieListViewModel: ObservableObject {
    
    @Published var movies: [MovieListData] = []
    @Published var search_movies: [MovieListData] = []
    private var searchTask: Task<Void, Never>?
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    private let service = NetworkService()
    private var isLoading = false
    private var currentPage = 1
    private var totalPages = 1
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        observeSearchText()
    }
    
    @MainActor
    func loadMovies() async {
        guard !isLoading, currentPage <= totalPages else { return }
        isLoading = true
        
        do {
            let networkParam = NetworkParams(endPoint: .popular, method: .get, parameters: ["page": currentPage], encodingType: .json)
            let response: MovieListModel = try await service.performNetworkService(networkParam: networkParam)
            movies.append(contentsOf: response.results)
            totalPages = response.total_pages
            currentPage += 1
        } catch {
            print("Error fetching movies: \(error)")
        }
        
        isLoading = false
    }
    
    @MainActor
    func searchMovies() async {
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            search_movies = []
            isSearching = false
            return
        }
        
        do {
            let networkParam = NetworkParams(endPoint: .search, method: .get, parameters: ["query": searchText], encodingType: .json)
            let response: MovieSearchResultList = try await service.performNetworkService(networkParam: networkParam)
            search_movies = response.results
            isSearching = true
        } catch {
            print("Search error:", error.localizedDescription)
        }
    }
    
    private func observeSearchText() {
        $searchText
            .removeDuplicates()
            //.debounce(for: .milliseconds(300), scheduler: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self else { return }
                
                searchTask?.cancel()
                searchTask = Task { await self.searchMovies() }
            }
            .store(in: &cancellables)
    }
}
