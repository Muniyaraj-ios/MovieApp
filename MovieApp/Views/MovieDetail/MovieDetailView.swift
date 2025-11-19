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
    @State private var showTrailer = false
    @State private var readMoreTapped = false
    let onFavoriteTap: () -> Void

    
    var body: some View {
        ZStack(alignment: .top) {
            Color(red: 18/255, green: 19/255, blue: 23/255).ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                /*HStack {
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
                            onFavoriteTap()
                        }
                    } label: {
                        Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(viewModel.isFavorite ? .red : .white)
                            .font(.system(size: 18))
                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 12)*/
                
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
                        headerSection
                        overviewSection
                        castSection
                        crewSection
                        
                        Spacer(minLength: 30)
                    }
                    
                    else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.top, 50)
                    }
                }.padding(.top, 20)
            }
            .task {
                await viewModel.loadMovies()
            }
        }
        .navigationBarTitle(Text(viewModel.movie_detail?.title ?? "Detail"), displayMode: .inline)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            
            // Leading Back Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.system(size: 18, weight: .medium))
                }
            }
            
            // Trailing Favorite Button
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    withAnimation {
                        viewModel.toggleFavorite()
                        onFavoriteTap()
                    }
                } label: {
                    Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(viewModel.isFavorite ? .red : .white)
                        .font(.system(size: 18))
                }
            }
        }
    }
}

extension MovieDetailView{
    
    private var overviewSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Overview:")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(.white)
            
            Text(viewModel.movie_detail?.overview ?? "")
                .foregroundColor(.gray)
                .font(.system(size: 14))
                .lineLimit(readMoreTapped ? nil : 4)
                .animation(.easeInOut, value: readMoreTapped)
            
            if let text = viewModel.movie_detail?.overview, text.count > 120 {
                Button(action: {
                    withAnimation {
                        readMoreTapped.toggle()
                    }
                }) {
                    Text(readMoreTapped ? "Read less" : "Read more")
                        .foregroundColor(Color(#colorLiteral(red: 0.4, green: 0.8, blue: 1, alpha: 1)))
                        .font(.system(size: 15, weight: .medium))
                }
            }
            
        }
        .padding()
        .background(Color.black.opacity(0.25))
        .cornerRadius(14)
        .padding(.horizontal)
    }

}

extension MovieDetailView{
    
    private var castSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text("Cast")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.castList, id: \.id) { cast in
                        VStack(spacing: 8) {
                            AsyncImageView(url: "https://image.tmdb.org/t/p/w200\(cast.profile_path)")
                                .frame(width: 80, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text(cast.name)
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .lineLimit(1)
                            
                            Text(cast.character)
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
//        .padding(.top, 10)
        .padding()
    }

}

extension MovieDetailView{
    
    private var crewSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            HStack {
                Text("Crew")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(viewModel.crewList, id: \.id) { crew in
                        VStack(spacing: 8) {
                            AsyncImageView(url: "https://image.tmdb.org/t/p/w200\(crew.profile_path)")
                                .frame(width: 80, height: 100)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            
                            Text(crew.name)
                                .foregroundColor(.white)
                                .font(.system(size: 14))
                                .lineLimit(1)
                            
                            Text(crew.job)
                                .foregroundColor(.gray)
                                .font(.system(size: 12))
                                .lineLimit(1)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
        }
//        .padding(.top, 10)
        .padding()
    }

}

extension MovieDetailView{
    
    private var headerSection: some View {
        VStack{
            if let movie = viewModel.movie_detail {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    HStack(alignment: .top, spacing: 20) {
                        
                        AsyncImageView(url: "https://image.tmdb.org/t/p/w300\(movie.poster_path)")
                            .frame(width: 120, height: 160)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            
                            Text("\(movie.release_date.prefix(4))  •  \(movie.runtime) minutes  •  Released")
                                .foregroundColor(.white)
                                .font(.system(size: 12, weight: .medium))
                                .lineLimit(2)
                            
                            Text(movie.origin_country.first ?? "Unknown")
                                .foregroundColor(.white.opacity(0.8))
                                .font(.system(size: 15))
                            
                            HStack(spacing: 14) {
                                RatingCircle(percentage: movie.vote_average * 10)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("\(movie.vote_count) ratings")
                                        .foregroundColor(.white)
                                        .font(.system(size: 14))
                                }
                            }
                        }
                        
                        Spacer()
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 14) {
                            ForEach(movie.genres, id: \.id) { genre in
                                GenreChip(text: genre.name)
                            }
                        }
                    }
                }
                .padding()
                .background(
                    LinearGradient(
                        colors: [
                            Color.black.opacity(0.35),
                            Color.black.opacity(0.15)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .cornerRadius(20)
                .padding(.horizontal)
                .padding(.top, 10)
            }
        }
    }

}
