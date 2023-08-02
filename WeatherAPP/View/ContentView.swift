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
    @FocusState private var nameIsFocused: Bool
    @State var weather = ""
    var body: some View {
            ZStack {
                if viewModel.newDataLoaded {
                    LottieView(loopMode: .loop, name: "\(viewModel.model.first?.current?.condition?.code ?? 0 == 1009 ? "Clouds": "Clear")").opacity(0.9)
                }
                VStack(alignment: .center, spacing: 20) {
                    TextField("Enter City", text: $viewModel.cityText).focused($nameIsFocused).frame(height: 50).background(Color.white.opacity(0.4)).cornerRadius(10)
                    Spacer()
                    if !viewModel.viewData.isEmpty && !viewModel.cityText.isEmpty {
                        List(viewModel.viewData) { item in
                        VStack(alignment: .leading) {
                            Text(item.title)
                            Text(item.subtitle)
                                .foregroundColor(.secondary)
                        }.onTapGesture {
                            viewModel.cityText = ""
                            viewModel.searchCity(name: item.title)
                            nameIsFocused = false
                        }
                        }.frame(height: 200)
                }
                    Spacer()
                    
                    Text(viewModel.cityName).font(.largeTitle).whiteStyle
                    Text("\(viewModel.model.first?.current?.temp ?? 0)" + "\u{00B0}").font(.largeTitle).whiteStyle
                    Text("\(viewModel.model.first?.current?.condition?.text ?? "")").whiteStyle
                    HStack {
                        Text("H:\(viewModel.model.first?.forecast?.forecastday?.first?.day?.maxTemp ?? 0)" + "\u{00B0}").whiteStyle
                        Text("L:\(viewModel.model.first?.forecast?.forecastday?.first?.day?.minTemp ?? 0)" + "\u{00B0}").whiteStyle
                    }
                    viewModel.model.first?.current?.getImage()

                    if let data = viewModel.model.first?.forecast?.forecastday {
                        
                        List(data) { item in
                            WeatherDayRowView(data: item.getRowData()).background(Color.white.opacity(0.3))
                        }.scrollContentBackground(.hidden)
                            .background(Color.white.opacity(0.0)).frame(maxHeight: .infinity, alignment: .bottom)
                    }
                        


                }
            }.padding().background(Color.blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
