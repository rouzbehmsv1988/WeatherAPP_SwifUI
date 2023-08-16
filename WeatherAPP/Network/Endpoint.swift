//
//  Endpoint.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import Foundation
import Combine

// you can input your baseURL and API Key here inorder to have access to the API service you want
enum Endpoint {
    static let baseURL = URL(string: "https://weatherapi-com.p.rapidapi.com")!
    static let headers = [
        "X-RapidAPI-Key": "Your API KEY",
        "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com"
    ]
    case getWeather(lat: CGFloat, long: CGFloat)
    case forcaste(cityName: String, numberOfDays: Int)
    enum MethodTypes: String {
        case get = "GET"
        case put = "PUT"
        case post = "POST"
        case delete = "Delete"
    }
    // add your path here based on each endpoint you want to call
    var path: String {
        switch self {
        case .getWeather:
            return "/data/2.5/weather"
        case .forcaste:
            return "/forecast.json"
            
        }
        
    }
    // define your HTTPMethod here based on the endpoint you want to call
    var method: MethodTypes {
        switch self {
        case .getWeather:
            return .get
        default:
            return .get
        }
    }
    // for each endpoint you can add your own query items
    var queryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        switch self {
        case .getWeather(let lat, let long):
            items.append(URLQueryItem(name: "lat", value: "\(lat)"))
            items.append(URLQueryItem(name: "lon", value: "\(long)"))
        case .forcaste(let city, let days):
            items.append(URLQueryItem(name: "q", value: "\(city)"))
            items.append(URLQueryItem(name: "days", value: "\(days)"))
        }
        return items
    }
    
    var request: URLRequest {
        guard var component = URLComponents(url: Endpoint.baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)
        else {
            fatalError("Could not create component")
        }
        component.queryItems = queryItems
        
        guard let url = component.url else {fatalError("couldnt find url")}
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = Endpoint.headers
        return request
    }

}




