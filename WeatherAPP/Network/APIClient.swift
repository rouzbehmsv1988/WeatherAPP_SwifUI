//
//  APIClient.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import Foundation
import Combine

// this class is responsible for calling the URLSession publisher and decode the response with JSONDecoder type and return it to upper layer
struct APIClient {
    func fetchData<T: Decodable>( _ request: URLRequest) -> AnyPublisher<T, Error> {
            return URLSession.shared
                .dataTaskPublisher(for: request)
                .receive(on: DispatchQueue.main)
                .tryMap(\.data)
                .decode(
                  type: T.self,
                  decoder: JSONDecoder()) .mapError { error in
                      print("Decoding Error: \(error)") // Print the decoding error
                      return error
                  }
                .eraseToAnyPublisher()
    }

}


