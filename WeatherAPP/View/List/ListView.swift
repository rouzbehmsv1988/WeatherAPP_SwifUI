//
//  SwiftUIView.swift
//  ListView
//
//  Created by rouzbeh on 31.07.23.
//

import SwiftUI

class RowAnimationManager: ObservableObject {
    @Published var animatedIndices: [Int: Bool] = [:]
}
struct ListView: View, TabSelector {
    @Binding var tabSelection: Int
    @EnvironmentObject var viewModel: WeatherViewModel
    @ObservedObject var animationManager = RowAnimationManager()

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
            if !viewModel.searchedCities.isEmpty {
                List {
                    ForEach(Array(viewModel.searchedCities).indices, id: \.self) { index in
                        ListRowView(name: Array(viewModel.searchedCities)[index], index: index, animationManager: animationManager).frame(height: 100).onTapGesture {
                            viewModel.searchCity(name: Array(viewModel.searchedCities)[index])
                            tabSelection = 1
                           
                        }
                    }.listRowBackground(Color.clear)
                }.background(.white.opacity(0.1)).scrollContentBackground(.hidden).padding()
            } else {
                Text("search some cities to see the list of them here").foregroundColor(.white
                ).font(.largeTitle).padding()
            }
            
        }.ignoresSafeArea()
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        @State var model = WeatherViewModel()
        @State var selected = 2
        ListView(tabSelection: $selected).environmentObject(model)
    }
}
