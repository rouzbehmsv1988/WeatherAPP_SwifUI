//
//  TabView.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import SwiftUI

protocol TabSelector {
    var tabSelection: Int { get set }
}
struct UserTabView: View {
   
    @StateObject var model = WeatherViewModel()
    @State var selectedTab = 1
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white.withAlphaComponent(0.5)
        UITabBar.appearance().unselectedItemTintColor = UIColor(Color.gray)
 
    }
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selectedTab) {
                ContentView().tabItem {
                    Label("Weather", systemImage: "cloud.sun").symbolRenderingMode(.monochrome)

                }.tag(1).environmentObject(model)
                
                ListView(tabSelection: $selectedTab).tabItem {
                    Label("List", systemImage: "list.bullet")
                    Image(systemName: "gear")
                }.tag(2).environmentObject(model)
            }.accentColor(.white)
        }
    }
}

struct UserTabView_Previews: PreviewProvider {
    static var previews: some View {
        UserTabView()
    }
}
