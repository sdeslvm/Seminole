//
//  ContentView.swift
//  Seminole
//
//  Created by Pavel Ivanov on 13.03.2025.
//

import SwiftUI

struct MainMenuView: View {
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Assets.Images.backgroundImage
                Assets.Images.logo
                
                VStack(spacing: 20) {
                    HStack {
                        Button {
                            path.append("settings")
                            ShopStorage.shared.currentScreen = "settings"
                        } label: {
                            Assets.Button.settings
                                .resizable()
                                .frame(width: Constants.Button.circleBig.width, height: Constants.Button.circleBig.width)
                        }.padding(.horizontal)
                        
                        Spacer()
                        
                        Button {
                            path.append("shop")
                            ShopStorage.shared.currentScreen = "shop"
                        } label: {
                            Assets.Button.shop
                                .resizable()
                                .frame(width: Constants.Button.circleBig.width, height: Constants.Button.circleBig.width)
                        }.padding(.horizontal)

                    }
                    
                    Spacer()
                    
                    MainButton(text: "START", size: 44) {
                        path.append("game")
                        ShopStorage.shared.currentScreen = "game"
                    }.padding(.horizontal)
                }
                .padding()
            }
            .navigationDestination(for: String.self) { value in
                switch value {
                case "settings": SettingsView(path: $path)
                case "shop": ShopView()
                case "game": LevelSelectionView(path: $path)
                case "rules": RulesView(path: $path)
                default: Text("")
                }
            }
        }
    }
}

#Preview {
    MainMenuView()
}

enum Constants {
    enum Button {
        static let circleBig = CGSize(width: 80, height: 80)
        static let circleSmall = CGSize(width: 60, height: 60)
        static let rectangleBig = CGSize(width: 240, height: 80)
    }
}
