//
//  LottieSetup.swift
//  iosApp
//
//  Created by florida on 12/09/26.
//
import SwiftUI
import DotLottie

struct RunLottie : View {
    let fileName : String
    let size: CGFloat
    var body: some View {
        if let asset = NSDataAsset(name: fileName),
           let animationData = String(data: asset.data, encoding: .utf8) {
            DotLottiePlayerView(
                animation: DotLottieAnimation(
                    animationData: animationData,
                    config: AnimationConfig(autoplay: true, loop: true, speed: 1.0)
                )
            )
            .playing()
            .looping()
            .frame(width: size, height: size)
        } else {
            Color.clear
                .frame(width: 100, height: 100)
        }
    }
}
