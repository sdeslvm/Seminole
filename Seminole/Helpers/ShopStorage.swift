//
//  ShopStorage.swift
//  Seminole
//
//  Created by Pavel Ivanov on 17.03.2025.
//

import Foundation

final class ShopStorage {
    
    static let shared = ShopStorage()
    
    private init() {}
    
    var greetingURL: URL?
    var currentScreen: String?
    var greetingShown: Bool = false
    
    private let defaults = UserDefaults.standard
    private let skinKey = "storedLevels"
    private let sphereKey = "storedLevels"
    private let boughtItemsKey = "boughtItems"
    private let showGreetingsKey = "showGreetings"
    
    func loadBoughtItems() -> Set<String> {
        if let boughtItems = defaults.array(forKey: boughtItemsKey) as? [String] {
            return Set(boughtItems)
        } else {
            saveBoughtItems(items: ["skin1", "sphere1"])
            return ["skin1", "sphere1"]
        }
    }
    
    func saveGreeting(_ greeting: Bool) {
        defaults.set(greeting, forKey: showGreetingsKey)
    }
    
    func getGreeting() {
        greetingShown = defaults.bool(forKey: showGreetingsKey)
    }
    
    func saveBoughtItems(items: Set<String>) {
        let itemsArray = Array(items)
        defaults.set(itemsArray, forKey: boughtItemsKey)
    }

    func loadSkinId() -> String {
        if let decodedSkin = defaults.string(forKey: skinKey) {
            return decodedSkin
        } else {
            saveSkinId("skin1")
            return "skin1"
        }
    }

    func saveSkinId(_ id: String) {
        defaults.set(id, forKey: skinKey)
    }
    
    func loadSphereId() -> String {
        if let decodedSkin = defaults.string(forKey: skinKey) {
            return decodedSkin
        } else {
            saveSphereId("sphere1")
            return "sphere1"
        }
    }

    func saveSphereId(_ id: String) {
        defaults.set(id, forKey: skinKey)
    }
}
