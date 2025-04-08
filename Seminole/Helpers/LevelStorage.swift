//
//  LevelStorage.swift
//  Seminole
//
//  Created by Pavel Ivanov on 16.03.2025.
//

import Foundation

final class LevelStorage {
    
    static let shared = LevelStorage()
    
    private init() {}
    
    private let defaults = UserDefaults.standard
    private let levelsKey = "storedLevels"
    
    /// Загружает уровни из UserDefaults или создает дефолтные
    func loadLevels() -> [LevelModel] {
        if let data = defaults.data(forKey: levelsKey),
           let decodedLevels = try? JSONDecoder().decode([LevelModel].self, from: data) {
            print("Загруженные уровни: \(decodedLevels)")
            return decodedLevels
        } else {
            return createDefaultLevels()
        }
    }
    
    /// Сохраняет уровни в UserDefaults
    func saveLevels(_ levels: [LevelModel]) {
        if let encoded = try? JSONEncoder().encode(levels) {
            defaults.set(encoded, forKey: levelsKey)
            print("Уровни сохранены: \(levels)")
        } else {
            print("Ошибка при кодировании уровней")
        }
    }
    
    /// Обновляет уровень (меняет `isLocked` и количество `stars`) и открывает следующий
    func updateLevel(levelNumber: Int, isLocked: Bool, stars: Int? = nil) {
        var allLevels = loadLevels()
        guard levelNumber <= allLevels.count else { return }
        
        if let _ = allLevels.first(where: { $0.id == levelNumber }) {
            // Обновляем текущий уровень
            var newLevel = LevelModel(number: levelNumber, isLocked: isLocked, stars: stars)
            allLevels[levelNumber - 1] = newLevel
            
            // Разблокируем следующий уровень, если он есть
            if levelNumber + 1 < allLevels.count {
                var nextLevel = LevelModel(number: levelNumber + 1, isLocked: false, stars: nil)
                allLevels[levelNumber] = nextLevel
            }
            
            // Сохраняем обновленный список уровней
            saveLevels(allLevels)
        }
    }
    
    /// Создает уровни по умолчанию (только первый открыт)
    private func createDefaultLevels() -> [LevelModel] {
        let levels = (1...20).map { number in
            LevelModel(number: number, isLocked: number != 1, stars: nil)
        }
        saveLevels(levels)
        return levels
    }
}

/// Модель уровня
struct LevelModel: Identifiable, Codable, Equatable {
    let id: Int
    let isLocked: Bool
    let stars: Int?

    init(number: Int, isLocked: Bool, stars: Int?) {
        self.id = number
        self.isLocked = isLocked
        self.stars = stars
    }
}
