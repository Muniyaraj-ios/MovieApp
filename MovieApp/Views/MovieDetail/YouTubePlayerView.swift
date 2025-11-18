//
//  YouTubePlayerView.swift
//  MovieApp
//
//  Created by ihub on 19/11/25.
//

import SwiftUI

struct YouTubePlayerView: View {
    let videoKey: String
    
    var body: some View {
        let url = URL(string: "https://www.youtube.com/embed/\(videoKey)")!
        
        WebView(url: url)
            .frame(height: 220)
            .cornerRadius(12)
            .padding(.horizontal)
    }
}

import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}
