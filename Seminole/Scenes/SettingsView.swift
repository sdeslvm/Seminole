//
//  SettingsView.swift
//  Seminole
//
//  Created by Pavel Ivanov on 13.03.2025.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath
    @State private var soundEnabled = MusicCentre.shared.isSoundOn
    
    var body: some View {
        ZStack {
            Assets.Images.backgroundImage
            
            VStack(spacing: 16) {
                
                NavigationItem(title: "SETTINGS", type: .home) {
                    dismiss()
                }
                
                Spacer()
                
                Button(action: {
                    soundEnabled.toggle()
                    MusicCentre.shared.isSoundOn = soundEnabled
                }) {
                    soundEnabled ? Assets.Button.soundOn.resizable() : Assets.Button.soundOff.resizable()
                }
                .frame(width: 150, height: 150)
                
                StrokedText(
                    text: soundEnabled ? "SOUND: ON" : "SOUND: OFF",
                    strokeColor: .white,
                    textColor: soundEnabled ? .black : .gray,
                    strokeWidth: 1,
                    size: 32
                )
                
                Spacer()
                
                MainButton(text: "RULES") {
                    path.append("rules")
                    ShopStorage.shared.currentScreen = "rules"
                }

            }.padding()
        }
        .navigationBarBackButtonHidden(true)
    }
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct RulesView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath

    var body: some View {
        ZStack {
            Assets.Images.backgroundImage
            VStack {
                NavigationItem(title: "Rules",type: .home) {
                    path = NavigationPath()
                    ShopStorage.shared.currentScreen = nil
                }
                Spacer()
                Text("The goal of the game is to capture all cells using tentacles for attack and defense, with different cell types offering various abilities. The interface includes a shop, settings, and buttons for starting levels and viewing rules.")
                    .font(.Cubano(size: 30))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(24)
                    .padding(.bottom, 44)
                MainButton(text: "Back") {
                    dismiss()
                }
            }.padding()
           
        }.navigationBarBackButtonHidden(true)
    }
    
    
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
    
    private func home() {
        
    }
}
