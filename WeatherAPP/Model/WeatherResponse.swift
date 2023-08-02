//
//  WeatherResponse.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import Foundation
import SwiftUI
struct WeatherResponse: Decodable {
    let location: Coordinate?
    let current: Current?
    let forecast: Forecast?
}


struct Coordinate: Decodable {
    let lat: CGFloat?
    let lon: CGFloat?
    let name: String?
}

struct Current: Decodable {
    let temp: CFloat?
    let isDay: Int?
    let condition: Condition?
    let feelsLike: CFloat?
    
    enum CodingKeys: String, CodingKey {
        case temp = "temp_c"
        case feelsLike = "feelslike_c"
        case isDay = "is_day"
        case condition = "condition"
    }
}


struct Condition: Decodable {
    let text: String?
    let icon: String?
    let code: Int?
    var image: Image? {
        guard let code = code else { return nil }
        return Image(systemName: "\(code)")
    }
    
}
struct Forecast: Decodable {
    let forecastday: [ForecastDay]?
}
struct ForecastDay: Decodable, Identifiable {
    var id = UUID()
    let day: Day?
    let dateEpoch: Int
    enum CodingKeys: String, CodingKey {
        case day
        case dateEpoch = "date_epoch"
    }
}


struct Day: Decodable {

    let maxTemp: CGFloat?
    let minTemp: CGFloat?
    let willRain: Int?
    let willSnow: Int?
    let chanceOfRain: Int?
    let chanceOfSnow: Int?
    let condition: Condition?
    enum CodingKeys: String, CodingKey {

        case maxTemp = "maxtemp_c"
        case minTemp = "mintemp_c"
        case willRain = "daily_will_it_rain"
        case willSnow = "daily_will_it_snow"
        case chanceOfRain = "daily_chance_of_rain"
        case chanceOfSnow = "daily_chance_of_snow"
        case condition
    }
}



enum ConditionCode: Int {
    case partlycloudy
    case cloudy
    case overcast
    case mist
    case patchyrainpossible
    case patchysnowpossible
    case patchysleetpossible
    case patchyfreezingdrizzlepossible
    case thunderyoutbreakspossible
    case blowingsnow
    case blizzard
    case fog
    case freezingfog
    case patchylightdrizzle
    case lightdrizzle
    case freezingdrizzle
    case heavyfreezingdrizzle
    case patchylightrain
    case lightrain
    case moderaterainattimes
    case moderaterain
    case heavyrainattimes
    case heavyrain
    case lightfreezingrain
    case Moderateorheavyfreezingrain
    case lightsleet
    case moderateorheavysleet
    case patchylightsnow
    case lightsnow
    case patchymoderatesnow
    case moderatesnow
    case patchyheavysnow
    case heavysnow
    case icepellets
    case lightrainshower
    case moderateorheavyrainshower
    case torrentialrainshower
    case lightsleetshowers
    case moderateorheavysleetshowers
    case lightsnowshowers
    case moderateorheavysnowshowers
    case lightshowersoficepellets
    case moderateorheavyshowersoficepellets
    case patchylightrainwiththunder
    case moderateorheavyrainwiththunder
    case patchylightsnowwiththunder
    case moderateorheavysnowwiththunder
}
