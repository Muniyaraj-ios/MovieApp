//
//  MovieRowView.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//


import SwiftUI
import SDWebImageSwiftUI

struct MovieRowView: View {
    let movie: MovieListData
    var favorites: Set<Int> = []
    
    @ObservedObject private var viewModel: MovieListViewModel
    
    init(movie: MovieListData, favorites: Set<Int>, viewModel: MovieListViewModel) {
        self.movie = movie
        self.favorites = favorites
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            
            AsyncImageView(url: "https://image.tmdb.org/t/p/w500\(movie.poster_path)")
                .frame(width: 80, height: 110)
                .cornerRadius(10)
            
            HStack{
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(movie.title)
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .semibold))
                        .lineLimit(nil)
                        .multilineTextAlignment(.leading)
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                            .font(.system(size: 13))
                        Text(String(format: "%.1f", movie.vote_average))
                            .foregroundColor(.yellow)
                            .font(.system(size: 13))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "film")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text("Action")
                            .foregroundColor(.gray)
                            .font(.system(size: 13))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text(movie.release_date.prefix(4))
                            .foregroundColor(.gray)
                            .font(.system(size: 13))
                    }
                    
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                        Text("139 minutes")
                            .foregroundColor(.gray)
                            .font(.system(size: 13))
                    }
                    
                }
                
                Spacer(minLength: 30)
                
                Button {
                    withAnimation {
                        viewModel.toggleFavorite(movie_id: movie.id)
                    }
                } label: {
                    Image(systemName: favorites.contains(movie.id) ? "heart.fill" : "heart")
                        .foregroundColor(favorites.contains(movie.id) ? .red : .white)
                        .font(.system(size: 18))
                        .frame(width: 35, height: 35)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 5)
    }
}

struct AsyncImageView: View {
    let url: String
    
    var body: some View {
        if let url_ = URL(string: url) {
            WebImage(url: url_)
                .resizable()
                .scaledToFill()
        } else {
            AsyncImage(url: URL(string: url)) { phase in
                switch phase {
                case .success(let image):
                    image.resizable().scaledToFill()
                case .failure(_):
                    Color.gray.opacity(0.3)
                default:
                    ProgressView()
                }
            }
        }
    }
}
