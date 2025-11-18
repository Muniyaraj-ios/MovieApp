//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//


import SwiftUI

struct MovieDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: MovieDetailViewModel
    @State private var selectedTab: DetailTab = .about
    @State private var showTrailer = false

    
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 18/255, green: 19/255, blue: 23/255).ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .medium))
                    }
                    
                    Spacer()
                    
                    Text("Detail")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Button{
                        withAnimation {
                            viewModel.toggleFavorite()
                        }
                    } label: {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isFavorite ? .red : .white)
                            .font(.system(size: 18))
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                ScrollView(showsIndicators: false) {
                    if let movie = viewModel.movie_detail {
                        
                        if let key = viewModel.trailerKey {
                            Button {
                                showTrailer = true
                            } label: {
                                ZStack {
                                    AsyncImageView(url: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path)")
                                        .frame(height: 200)
                                        .scaledToFill()
                                        .clipped()
                                        .cornerRadius(12)
                                    
                                    Circle()
                                        .fill(Color.black.opacity(0.6))
                                        .frame(width: 60, height: 60)
                                    
                                    Image(systemName: "play.fill")
                                        .foregroundColor(.white)
                                        .font(.system(size: 28, weight: .bold))
                                }
                                .padding(.horizontal)
                                .padding(.top, 10)
                            }
                            .sheet(isPresented: $showTrailer) {
                                if let url = URL(string: "https://www.youtube.com/watch?v=\(key)") {
                                    SafariView(url: url)
                                }
                            }
                        }else{
                            AsyncImageView(url: "https://image.tmdb.org/t/p/w500\(movie.backdrop_path)")
                                .frame(height: 220)
                                .scaledToFill()
                                .clipped()
                        }
                        
                        HStack(alignment: .top, spacing: 14) {
                            
                            AsyncImageView(url: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")
                                .frame(width: 90, height: 130)
                                .cornerRadius(10)
                                .offset(y: -40)
                            
                            VStack(alignment: .leading, spacing: 6) {
                                Text(movie.title)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold))
                                    .multilineTextAlignment(.leading)
                                
                                HStack(spacing: 4) {
                                    Image(systemName: "star.fill")
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 14))
                                    Text(String(format: "%.1f", movie.vote_average))
                                        .foregroundColor(.yellow)
                                        .font(.system(size: 14))
                                }
                            }
                            .offset(y: -30)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        
                        HStack(spacing: 20) {
                            
                            Label(movie.release_date.prefix(4), systemImage: "calendar")
                            Label("\(movie.runtime) Minutes", systemImage: "clock")
                            if let genre = movie.genres.first?.name {
                                Label(genre, systemImage: "film")
                            }
                            
                        }
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                        .offset(y: -30)
                        
                        Text("Cast")
                            .foregroundColor(.white)
                            .font(.system(size: 17, weight: .bold))
                            .padding(.horizontal)
                            .padding(.top, 6)

                        CastView(cast: viewModel.castList)
                            .padding(.top, 6)
                        
                        tabBarView
                        
                        tabContentView(movie: movie)
                        
                        Spacer(minLength: 30)
                    }
                    
                    else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.top, 50)
                    }
                }.padding(.top, 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .task {
            await viewModel.loadMovies()
        }
    }
}

enum DetailTab { case about, reviews, cast }

extension MovieDetailView {
    
    var tabBarView: some View {
        VStack(alignment: .leading) {
            tabButton(.about, title: "About Movie")
//            tabButton(.reviews, title: "Reviews")
//            tabButton(.cast, title: "Cast")
        }
        .padding(.horizontal)
        .padding(.top, 20)
    }
    
    func tabButton(_ tab: DetailTab, title: String) -> some View {
        VStack {
            Button(action: { selectedTab = tab }) {
                Text(title)
                    .foregroundColor(selectedTab == tab ? .white : .gray)
                    .font(.system(size: 17, weight: .bold))
            }
            
//            if selectedTab == tab {
//                Rectangle()
//                    .frame(height: 2)
//                    .foregroundColor(.white)
//                    .cornerRadius(1)
//                    .padding(.top, 2)
//            } else {
//                Rectangle().frame(height: 2).foregroundColor(.clear)
//            }
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    func tabContentView(movie: MovieDetailModel) -> some View {
        switch selectedTab {
        case .about:
            Text(movie.overview)
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .multilineTextAlignment(.leading)
                .padding(.top, 14)
                .padding(.horizontal)
            
        case .reviews:
            Text("Reviews will appear here.")
                .foregroundColor(.gray)
                .padding(.top, 20)
            
        case .cast:
            Text("Cast list will appear here.")
                .foregroundColor(.gray)
                .padding(.top, 20)
        }
    }
}
