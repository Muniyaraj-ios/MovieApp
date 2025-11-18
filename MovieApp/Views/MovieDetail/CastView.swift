//
//  CastView.swift
//  MovieApp
//
//  Created by ihub on 19/11/25.
//

import SwiftUI

struct CastView: View {
    let cast: [CastData]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(cast, id: \.id) { member in
                    VStack {
                        AsyncImageView(url: "https://image.tmdb.org/t/p/w200\(member.profile_path)")
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                        
                        Text(member.name)
                            .foregroundColor(.white)
                            .font(.system(size: 13))
                            .lineLimit(1)
                        
                        Text(member.character)
                            .foregroundColor(.gray)
                            .font(.system(size: 12))
                            .lineLimit(1)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
