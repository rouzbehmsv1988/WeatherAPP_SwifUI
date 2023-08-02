//
//  Extensions.swift
//  WeatherAPP
//
//  Created by rouzbeh on 02.08.23.
//

import Foundation
import SwiftUI

extension Text {
    var whiteStyle: Text {
        self.foregroundColor(.white)
    }
}
extension Current {
    func getImage() -> Image? {
        guard let code = condition?.code else { return nil }
        let postFix = isDay == 1 ? "": "-night"
        return Image(systemName: "\(code)" + postFix)
    }
}

extension ForecastDay {
    func getRowData() -> WeatherRowData {
        return WeatherRowData(day: dateEpoch, image: day?.condition?.image ?? Image(""), minTemp: day?.minTemp ?? 0, maxTemp: day?.maxTemp ?? 0)
    }
}

extension Int {
    func getDate() -> Date {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        return date
    }
}





