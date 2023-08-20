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
    @EnvironmentObject var viewModel: WeatherViewModel
    @State var searchText = ""
    @FocusState private var nameIsFocused: Bool
    @State var weather = ""
    @State private var isRaining = false
    var body: some View {
        ZStack (alignment: .top){
                //TODO: if you want to have the lottie animation background uncomment the below line and choose a naming convention for your animation files that it goes along with your codes
//                if viewModel.newDataLoaded {
//                    LottieView(loopMode: .loop, name: "\(viewModel.model.first?.current?.condition?.code ?? 0 == 1009 ? "Clouds": "Clear")").opacity(0.9)
//                }
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .center, spacing: 20) {
                
                TextField("Enter City", text: $viewModel.cityText).focused($nameIsFocused).frame(height: 50) .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6)).background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2).padding()
                Spacer()
                if let weather = viewModel.model?.current?.condition?.text {
                Image(systemName: viewModel.chooseWeatherIcon(weather)).frame(width: 100, height: 100)
                    .font(.system(size: 100))
                    .foregroundColor(.white)
                    .offset(y: isRaining ? 0 : -200)
                    .opacity(isRaining ? 1 : 0)
                    .animation(.easeInOut(duration: 0.5), value: isRaining)
                    .onAppear {
                        withAnimation(.linear(duration: 2).repeatForever(autoreverses: false)) {
                            isRaining.toggle()
                        }
                    }
            }
                    Text(viewModel.cityName).font(.largeTitle).whiteStyle
                    Text("\(viewModel.model?.current?.temp ?? 0)" + "\u{00B0}").font(.largeTitle).whiteStyle
                    Text("\(viewModel.model?.current?.condition?.text ?? "")").whiteStyle
                    HStack {
                        Text("H:\(viewModel.model?.forecast?.forecastday?.first?.day?.maxTemp ?? 0)" + "\u{00B0}").whiteStyle
                        Text("L:\(viewModel.model?.forecast?.forecastday?.first?.day?.minTemp ?? 0)" + "\u{00B0}").whiteStyle
                    }
                   Spacer()

                    if let data = viewModel.model?.forecast?.forecastday {
                        List(data) { item in
                            VStack {
                                WeatherDayRowView(data: item.getRowData())
                            }.listRowBackground(Color.white.opacity(0.3))
                        }.background(Color.clear).scrollContentBackground(.hidden).frame(maxHeight: .infinity, alignment: .bottom)
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
            
            }.background(Color.clear)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        @State var viewModel = WeatherViewModel()
        ContentView().environmentObject(viewModel)
    }
}
