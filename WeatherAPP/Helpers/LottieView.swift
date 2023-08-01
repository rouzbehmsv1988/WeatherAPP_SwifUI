//
//  LottieView.swift
//  WeatherAPP
//
//  Created by rouzbeh on 31.07.23.
//


import SwiftUI
import Lottie

// LottieView read to use in SwiftUI with dynamic file input name ;)
struct LottieView: UIViewRepresentable {
    let loopMode: LottieLoopMode
    let name: String
    init(loopMode: LottieLoopMode, name: String) {
        self.loopMode = loopMode
        self.name = name
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {

    }
        func makeUIView(context: Context) -> Lottie.LottieAnimationView {
            let animationView = LottieAnimationView(name: name)
            animationView.play()
            animationView.loopMode = loopMode
            animationView.contentMode = .scaleAspectFit
            return animationView
        }
        
        
    
}
