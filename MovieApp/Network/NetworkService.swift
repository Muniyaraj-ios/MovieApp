//
//  NetworkService.swift
//  MovieApp
//
//  Created by ihub on 18/11/25.
//

import Foundation
import SwiftyJSON

actor NetworkService: AdvancedService{
    
    func performNetworkService<T: BaseSwiftyJSON>(networkParam: NetworkParams) async throws -> T {
        guard let request = try networkParam.generateURLRequest() else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<299 ~= httpResponse.statusCode else {
            if let httpResponse = response as? HTTPURLResponse{
                Console.log("httpResponse : \(httpResponse.statusCode)")
            }
            forLog(networkParam, json: JSONLocal())
            throw URLError(.badServerResponse)
        }
        
        let jsonData = JSONLocal(data)
        #if DEBUG
        forLog(networkParam, json: jsonData)
        #endif
        
        let result = T(json: jsonData)
        return result
    }
    
    private func forLog(_ networkParam: NetworkParams, json: JSONLocal){
        let urlString = String(describing: try? networkParam.generateURLRequest()?.url?.absoluteString ?? "")
        Console.log("networkParam URL : \(urlString) | method : \(networkParam.method.rawValue)")
        if let param = networkParam.parameters{
            Console.log("networkParam Params : \(param)")
        }
        Console.log("networkParam Response : \(json)")
        
    }
}

protocol AdvancedService: AnyObject{
    func performNetworkService<T: BaseSwiftyJSON>(networkParam: NetworkParams) async throws -> T
}

struct Console {
    static func log(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        let message = items.map { "\($0)" }.joined(separator: separator)
        Swift.print("🟢 \(message)", terminator: terminator)
        #else
        #endif
    }
}

public typealias JSONLocal = JSON

protocol BaseSwiftyJSON{
    init(json: JSONLocal)
}
