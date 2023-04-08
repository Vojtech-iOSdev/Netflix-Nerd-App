//
//  NetworkingManager.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 24.03.2023.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case invalidURL
        case invalidStatusCode(url: URL)
        case unknown(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .invalidURL: return "The URL is incorrect."
            case .invalidStatusCode(url: let url): return "[🔥] Bad response from URL: \(url)"
            case .unknown: return "[☢️] Unknown error occured."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ try handleOutput(output: $0, url: url) })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    static func handleOutput(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.invalidStatusCode(url: url)
              }
        return output.data
    }

    
    static func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let error):
            print(NetworkingError.unknown(error: error))
        }
    }
    
}
