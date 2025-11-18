//
//  NetworkParams.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import Foundation

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: Any]

public struct HTTPMethod: Equatable{
    public static let get = HTTPMethod(rawValue: "GET")
    public static let post = HTTPMethod(rawValue: "POST")
    let rawValue: String
    private init(rawValue: String) {
        self.rawValue = rawValue
    }
}

public enum APIURL{
    case baseURL
    case custom(urlString: String)
    
    var Value: String{
        switch self {
        case .baseURL: return "https://api.themoviedb.org/3/"
        case .custom(urlString: let urlString): return urlString
        }
    }
}

public struct NetworkParams{
    var baseURL: APIURL = .baseURL
    private(set) var apiKey: String = "1d9b898a212ea52e283351e521e17871"
    var endPoint: Endpoint
    var method: HTTPMethod
    var parameters: Parameters?
    var headers: HTTPHeaders?
    var encodingType: EncodingType = .urlEncoded
}

public enum Endpoint {
    case popular
    case movieDetail(movie: Int), videos(movie: Int), credits(movie: Int)
    case search
    case custom(path: String)
    
    func path() -> String {
        switch self {
        case .popular:
            return "movie/popular"
        case let .movieDetail(movie):
            return "movie/\(String(movie))"
        case .search:
            return "search/movie"
        case let .videos(movie):
            return "movie/\(String(movie))/videos"
        case let .credits(movie):
            return "movie/\(movie)/credits"
        case let .custom(path):
            return path
        }
    }
}

enum EncodingType {
    case urlEncoded
    case json
}

extension NetworkParams {
    
    func generateURLRequest() throws -> URLRequest? {
        guard var urlComponents = URLComponents(string: baseURL.Value + endPoint.path()) else { return nil }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "language", value: Locale.preferredLanguages[0])
        ]
        
        if method == .get, let parameters = parameters {
            for (key, value) in parameters {
                urlComponents.queryItems?.append(URLQueryItem(name: key, value: "\(value)"))
            }
        }
        
        guard let finalURL = urlComponents.url else { return nil }
        
        var request = URLRequest(url: finalURL)
        request.httpMethod = method.rawValue
        
        if method != .get{
            let contentType: String = {
                switch encodingType {
                case .urlEncoded: return "application/x-www-form-urlencoded"
                case .json:       return "application/json"
                }
            }()
            
            let combinedHeaders = getHeaders(contentType: contentType)
            for (key, value) in combinedHeaders {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }else{
            request.allHTTPHeaderFields = nil
        }

        if method != .get, let parameters_ = parameters {
            switch encodingType {
            case .urlEncoded:
                let paramString = parameters_.map {
                    "\($0.key)=\("\($0.value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
                }.joined(separator: "&")
                request.httpBody = paramString.data(using: .utf8)

            case .json:
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters_, options: [])
            }
        }

        return request
    }
}


extension NetworkParams {
    
    func getHeaders(contentType: String = "application/x-www-form-urlencoded") -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        
        if method != .get {
            headers["Content-Type"] = contentType
        }
        
        return headers
    }
}
