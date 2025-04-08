//
//  GemeNavigation.swift
//  Seminole
//
//  Created by Pavel Ivanov on 16.03.2025.
//

import SwiftUI

struct GemeNavigation: View {
    
    @Binding var level: Int
    let stars: Int
    let mainTapped: (() -> Void)
    let settingsTapped: (() -> Void)
    
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    // Действие для закрытия экрана
                    mainTapped()
                }) {
                    Assets.Button.home
                        .resizable()
                        .frame(width: Constants.Button.circleSmall.width, height: Constants.Button.circleSmall.height)
                    
                }
                .padding()
                
                Spacer()
                
                HStack(spacing: 8) {
                    ForEach(0..<3) { index in
                        if index < stars {
                            Assets.Star.filled
                                .resizable()
                                .frame(width: 56, height: 56)
                        } else {
                            Assets.Star.empty
                                .resizable()
                                .frame(width: 56, height: 56)
                        }
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // Действие для закрытия экрана
                    settingsTapped()
                }) {
                    Assets.Button.settings
                        .resizable()
                        .frame(width: Constants.Button.circleSmall.width, height: Constants.Button.circleSmall.height)
                }
                .padding()
            }
            StrokedText(text: "\(level) level", strokeColor: .black, textColor: .white, size: 32)
        }
    }
}
