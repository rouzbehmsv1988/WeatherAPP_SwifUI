//
//  WeatherResponse.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import Foundation

struct WeatherResponse: Decodable {
    let coord: Coordinate
    let weather: [Weather]
    let main: MainData?
    let visibility: Int
}

struct Coordinate: Decodable {
    let lat: CGFloat
    let lon: CGFloat
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct MainData: Decodable {
    let temp: CGFloat?
    let feelsLike: CGFloat?
    let tempMin: CGFloat?
    let tempMax: CGFloat?
    let pressure: CGFloat?
    let humidity: Int?
    let seaLevel: Int?
    let grandLevel: Int?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case humidity = "humidity"
        case seaLevel = "sea_level"
        case grandLevel = "grnd_level"
    }
}
