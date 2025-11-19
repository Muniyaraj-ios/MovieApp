//
//  MovieListView.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import SwiftUI

struct MoviesListView: View {
    @StateObject private var viewModel = MovieListViewModel()
    
    var body: some View {
        navigationView
    }
    
    @ViewBuilder
    var navigationView: some View{
        if #available(iOS 16.0, *) {
            NavigationStack{
                contentFullView
            }
        } else {
            NavigationView {
                contentFullView
            }
        }
    }
    
    var contentFullView: some View{
        VStack {
            
            HStack {
                TextField("Search movies...", text: $viewModel.searchText)
                    .foregroundColor(.white)

                if !viewModel.searchText.isEmpty {
                    Button(action: {
                        viewModel.searchText = ""
                        viewModel.isSearching = false
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(12)
            .background(Color.gray.opacity(0.15))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    
                    if viewModel.isSearching {
                        if viewModel.search_movies.isEmpty {
                            VStack {
                                Spacer()
                                Text("No results found")
                                    .foregroundColor(.gray)
                                    .padding()
                                Spacer()
                            }
                        } else {
                            ForEach(viewModel.search_movies, id: \.id) { movie in
                                NavigationLink {
                                    MovieDetailView(viewModel: MovieDetailViewModel(movie_id: movie.id), onFavoriteTap: {
                                        viewModel.loadFavorites()
                                    })
                                } label: {
                                    MovieRowView(movie: movie, favorites: viewModel.favorites)
                                }
                            }
                        }
                    } else {
                        ForEach(viewModel.movies, id: \.id) { movie in
                            NavigationLink {
                                MovieDetailView(viewModel: MovieDetailViewModel(movie_id: movie.id), onFavoriteTap: {
                                    viewModel.loadFavorites()
                                })
                            } label: {
                                MovieRowView(movie: movie, favorites: viewModel.favorites)
                            }
                            .task {
                                if movie.id == viewModel.movies.last?.id {
                                    Task { await viewModel.loadMovies() }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.top, 10)
            }
        }
        .navigationBarTitle(Text("Popular Movies"), displayMode: .inline)
        .background(Color(red: 18/255, green: 19/255, blue: 23/255).ignoresSafeArea())
        .task {
            await viewModel.loadMovies()
        }
    }
}

#Preview {
    MoviesListView()
}

