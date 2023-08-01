//
//  ContentView.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import SwiftUI
import Lottie
struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    @State var searchText = ""
    var body: some View {
            ZStack {
                LottieView(loopMode: .loop, name: viewModel.model.first?.weather.first?.main ?? "").frame(maxWidth: .infinity, maxHeight: .infinity).opacity(0.9).cornerRadius(10).shadow(radius: 3)
                VStack(spacing: 20) {
                
                    VStack(alignment: .leading) {
                        TextField("Enter City", text: $viewModel.cityText).frame(height: 50).background(Color.white.opacity(0.4))
                        if !viewModel.viewData.isEmpty && !viewModel.cityText.isEmpty {
                            List(viewModel.viewData) { item in
                            VStack(alignment: .leading) {
                                Text(item.title)
                                Text(item.subtitle)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    }
                    Spacer()
                    Text("\(viewModel.cityName)") .font(.system(size: 40, weight: .bold, design: .rounded))
                    Text("Feels like: " + "\(viewModel.calculateCelsius(fahrenheit: Double(viewModel.model.first?.main?.feelsLike ?? 0)))")
                    Text("Highest: " + "\(viewModel.calculateCelsius(fahrenheit: Double(viewModel.model.first?.main?.tempMax ?? 0)))")
                    Text("Lowest: " + "\(viewModel.calculateCelsius(fahrenheit: Double(viewModel.model.first?.main?.tempMin ?? 0))))")
                    Spacer()
                }.padding()
            }.background(Color.blue)
            Text("data")
        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
