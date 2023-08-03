//
//  ContentView.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import SwiftUI
import Lottie
import Combine
struct ContentView: View {
    @ObservedObject var viewModel = WeatherViewModel()
    @State var searchText = ""
    @FocusState private var nameIsFocused: Bool
    @State var weather = ""
    var body: some View {
        ZStack (alignment: .top){
                //TODO: if you want to have the lottie animation background uncomment the below line and choose a naming convention for your animation files that it goes along with your codes
//                if viewModel.newDataLoaded {
//                    LottieView(loopMode: .loop, name: "\(viewModel.model.first?.current?.condition?.code ?? 0 == 1009 ? "Clouds": "Clear")").opacity(0.9)
//                }
     
                VStack(alignment: .center, spacing: 20) {
                    
                    TextField("Enter City", text: $viewModel.cityText).focused($nameIsFocused).frame(height: 50) .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)).foregroundColor(.white).background(Color.white.opacity(0.4)).cornerRadius(10)
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
                            VStack {
                                WeatherDayRowView(data: item.getRowData())
                            }.listRowBackground(Color.white.opacity(0.3))
                        }.background(Color.blue).scrollContentBackground(.hidden).frame(maxHeight: .infinity, alignment: .bottom)
                    }
                        


                }
            if !viewModel.viewData.isEmpty && !viewModel.cityText.isEmpty {
                List(viewModel.viewData) { item in
                VStack(alignment: .leading) {
                    Text(item.title).foregroundColor(.white)
                    Text(item.subtitle)
                        .foregroundColor(.secondary)
                }.onTapGesture {
                    viewModel.cityText = ""
                    viewModel.searchCity(name: item.title)
                    nameIsFocused = false
                }.listRowBackground(Color.mint)
                }.background(Color.white.opacity(0.6)).scrollContentBackground(.hidden).frame(height: 150, alignment: .top).padding(.top, 80)
            }
            }.padding().background(Color.blue)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
