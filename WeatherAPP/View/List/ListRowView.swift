//
//  ListRowView.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//

import SwiftUI

struct ListRowView: View {
    var name: String
    var index: Int
    @ObservedObject var animationManager: RowAnimationManager
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color.blue]), startPoint: .topLeading, endPoint: .bottomTrailing).cornerRadius(10)
            Text(name)
                .font(.headline)
                .foregroundColor(.white).font(.largeTitle)
        }        .opacity(animationManager.animatedIndices[index] ?? false ? 1.0 : 0.0)
            .onAppear {
                withAnimation(.easeIn(duration: 1).delay(Double(index) * 0.2)) {
                    animationManager.animatedIndices[index] = true
                }
            }
        }
    }


