//
//  Launch.swift
//  Seminole
//
//  Created by Pavel Ivanov on 17.03.2025.
//

import SwiftUI

struct Launch: View {
    
    @State var isShowGreeting: Bool = false
    @State var isLoaded: Bool = false
    
    var body: some View {
        ZStack {
            ZStack {
                Assets.Images.backgroundImage
                Assets.Images.logo
                
                VStack {
                    Spacer()
                    StrokedText(text: "Loading...", strokeColor: .black, textColor: .white)
                }
            }
            
            if isLoaded {
                if isShowGreeting || ShopStorage.shared.greetingShown {
                    if let url = ShopStorage.shared.greetingURL {
                        BrowserView(pageURL: url)
                            .padding()
                            .background(ignoresSafeAreaEdges: .all)
                            .onAppear {
                                print("BrowserView appeared")
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    UIDevice.current.setValue(UIInterfaceOrientation.unknown.rawValue, forKey: "orientation")
                                    UIViewController.attemptRotationToDeviceOrientation()
                                }
                            }
                    }
                } else {
                    MainMenuView()
                }
            }
        }.onAppear {
            validateGreetingURL()
        }
    }
    
    func validateGreetingURL() {
        Task {
            if await !Network.isURLValid() {
                ShopStorage.shared.greetingURL = URL(string: urlForValidation)
                ShopStorage.shared.currentScreen = "greeting"
                ShopStorage.shared.saveGreeting(true)
                ShopStorage.shared.getGreeting()
                isShowGreeting = ShopStorage.shared.greetingShown
            }
            isLoaded = true
        }
    }
}
