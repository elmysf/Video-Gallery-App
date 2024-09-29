//
//  NetworkingManager.swift
//  VideosEngine
//
//  Created by Sufiandy Elmy on 29/09/24.
//


import SwiftUI
import Combine
import Foundation

public enum HTTPMethodType: String {
    case get     = "GET"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
}

public protocol BaseNetwork {
    var endpoint: String { get }
    var type: String { get }
    var params: [String: Any] { get }
}

public extension BaseNetwork {
    var params: [String: Any] {
        [:]
    }
}

public struct Errors: Decodable {
    let timestamp: Int
    let status: String
    let message: String
}


public class NetworkingManager {
    public init() {}

    enum NetworkingError: LocalizedError {
        case badURLResponse(url: String)
        case unknown

        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url):
                return "\(url)"
            case .unknown:
                return "[⚠️] Unknown error occurred"
            }
        }
    }

    public static func get<T: Decodable>(for url: URLRequest) -> AnyPublisher<T, Error> {
        return URLSession(configuration: .ephemeral)
            .dataTaskPublisher(for: url)
            .tryMap { output in
                try handleURLResponse(output: output, url: url)
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }


    public static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URLRequest) throws -> Data {
        if let response = output.response as? HTTPURLResponse {
            if response.statusCode == 401 {
                print("response error with status code")
            }
        }
        guard let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            let jsonResp = try JSONSerialization.jsonObject(with: output.data, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
            let information = jsonResp as? NSDictionary
            let errorResp = ("\(information!.value(forKey: "message") ?? "")")
            throw NetworkingError.badURLResponse(url: errorResp)
        }
        return output.data
    }
    
    public static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print("Network request failed with error: \(error.localizedDescription)")
        }
    }
}

