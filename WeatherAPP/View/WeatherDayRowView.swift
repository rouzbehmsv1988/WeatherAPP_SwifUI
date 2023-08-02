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
           
            Text(getTodayWeekDay()).background(.clear).foregroundColor(.white).font(.system(size: 12))
            data.image
            Text("\(Int(data.minTemp))" + "\u{00B0}").foregroundColor(.white).font(.system(size: 12))
            ProgressView(value: data.minTemp, total: data.maxTemp).tint(.yellow)
            Text("\(Int(data.maxTemp))" + "\u{00B0}").foregroundColor(.white).font(.system(size: 12))
        } .background(Color.clear)
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

