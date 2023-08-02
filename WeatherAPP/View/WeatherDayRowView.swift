//
//  WeatherDayRowView.swift
//  WeatherAPP
//
//  Created by rouzbeh on 01.08.23.
//

import SwiftUI

struct WeatherRowData {
    let day: Int
    let image: Image
    let minTemp: CGFloat
    let maxTemp: CGFloat
}

struct WeatherDayRowView: View {
    var data: WeatherRowData
    var body: some View {
        HStack(spacing: 20) {
           
            Text(getTodayWeekDay())
            data.image
            Text("\(Int(data.minTemp))")
            ProgressView(value: data.minTemp, total: data.maxTemp).tint(.yellow)
            Text("\(Int(data.maxTemp))")
        } .background(Color.white.opacity(0.1))
    }
                 
    func getTodayWeekDay()-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let weekDay = dateFormatter.string(from: data.day.getDate())
        return weekDay
                  }
}


struct WeatherDayRowView_preview: PreviewProvider {
    static var previews: some View {
        WeatherDayRowView(data: WeatherRowData(day: 0, image: Image(""), minTemp: 0, maxTemp: 0))
    }
}

