//
//  Initial.swift
//  Seminole
//
//  Created by Pavel Ivanov on 17.03.2025.
//

import SwiftUI

@main
struct SeminoleGamesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            Launch()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func applicationDidFinishLaunching(_ application: UIApplication) {
        ShopStorage.shared.getGreeting()
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        let currentScreen = ShopStorage.shared.currentScreen
        if currentScreen == "greeting" {
            return .allButUpsideDown
        } else {
            return .portrait
        }
    }
}
