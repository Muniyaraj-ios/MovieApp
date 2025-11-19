//
//  RatingCircle.swift
//  MovieApp
//
//  Created by ihub on 19/11/25.
//

import SwiftUI

struct RatingCircle: View {
    let percentage: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 4)
                .frame(width: 45, height: 45)
            
            Circle()
                .trim(from: 0, to: percentage / 100)
                .stroke(
                    AngularGradient(colors: [.yellow, .orange], center: .center),
                    style: StrokeStyle(lineWidth: 4, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 45, height: 45)

            Text("\(Int(percentage))%")
                .foregroundColor(.yellow)
                .font(.system(size: 13, weight: .bold))
        }
    }
}
