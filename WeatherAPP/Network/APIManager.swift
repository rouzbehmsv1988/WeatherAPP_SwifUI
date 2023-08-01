//
//  APIManager.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import Foundation
import Combine

// middle layer between viewModels and the APIClient Layer
final class APIManager<T: Decodable> {
    static var shared: APIManager<T> {
        return APIManager<T>()
    }
    func request(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        return APIClient().fetchData(endpoint.request).eraseToAnyPublisher()
    }
}

