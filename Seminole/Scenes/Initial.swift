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
        if OrientationManager.shared.isHorizontalLock {
            return .portrait
        } else {
            return .allButUpsideDown
        }
        
//        let currentScreen = ShopStorage.shared.currentScreen
//        if currentScreen == "greeting" {
//            return .allButUpsideDown
//        } else {
//            return .portrait
//        }
    
    }
    
}

