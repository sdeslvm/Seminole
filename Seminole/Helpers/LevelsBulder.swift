import CoreGraphics

final class LevelsBulder {
    
    var levelsCount: Int {
        getLevels().count
    }
    
    func getLevel(_ level: Int) -> [CellModel] {
        guard level < levelsCount, level != 0 else {
            return []
        }
        return getLevels()[level - 1]
    }
    
    private func getLevels() -> [[CellModel]] {
        var levels: [[CellModel]] = [
            // Level 1 - Легкий старт, игрок обучается
            [
                CellModel(type: .normal, owner: .player, health: 20, position: CGPoint(x: 150, y: 500)),
                CellModel(type: .normal, owner: .neutral, health: 5, position: CGPoint(x: 300, y: 300)),
                CellModel(type: .normal, owner: .enemy, health: 10, position: CGPoint(x: 200, y: 400)),
            ],
            
            // Level 2 - Добавление врага
            [
                CellModel(type: .normal, owner: .player, health: 25, position: CGPoint(x: 100, y: 500)),
                CellModel(type: .normal, owner: .neutral, health: 5, position: CGPoint(x: 250, y: 400)),
                CellModel(type: .normal, owner: .enemy, health: 15, position: CGPoint(x: 350, y: 300)),
                CellModel(type: .attack, owner: .enemy, health: 10, position: CGPoint(x: 300, y: 200)),
            ],
            
            // Level 3 - Первый вызов
            [
                CellModel(type: .attack, owner: .player, health: 30, position: CGPoint(x: 100, y: 500)),
                CellModel(type: .defense, owner: .neutral, health: 10, position: CGPoint(x: 250, y: 400)),
                CellModel(type: .normal, owner: .enemy, health: 25, position: CGPoint(x: 350, y: 300)),
                CellModel(type: .attack, owner: .enemy, health: 20, position: CGPoint(x: 300, y: 200)),
            ]
        ]

        // Генерация уровней 4-10 с возрастающей сложностью
        for level in 4...10 {
            var cells: [CellModel] = [
                CellModel(type: .attack, owner: .player, health: Double(30 + level * 2), position: CGPoint(x: 100, y: 500)),
                CellModel(type: .defense, owner: .neutral, health: Double(10 + level), position: CGPoint(x: 250, y: 400)),
                CellModel(type: .normal, owner: .enemy, health: Double(25 + level), position: CGPoint(x: 350, y: 300)),
                CellModel(type: .attack, owner: .enemy, health: Double(20 + level), position: CGPoint(x: 300, y: 200)),
            ]
            
            if level >= 6 {
                cells.append(CellModel(type: .multiplier, owner: .neutral, health: Double(15 + level), position: CGPoint(x: 200, y: 600)))
            }
            if level >= 8 {
                cells.append(CellModel(type: .defense, owner: .enemy, health: Double(30 + level), position: CGPoint(x: 400, y: 350)))
            }
            
            levels.append(cells)
        }

        // Добавляем уровни 11-20 динамически
        levels.append(contentsOf: generateRandomLevels(start: 11, end: 20))

        return levels
    }
    
    private func generateRandomLevels(start: Int, end: Int) -> [[CellModel]] {
        return (start...end).map { level in
            var cells: [CellModel] = [
                CellModel(type: .attack, owner: .player, health: Double(80 + level * 2), position: CGPoint(x: 150, y: 500)),
                CellModel(type: .normal, owner: .enemy, health: Double(70 + level * 2), position: CGPoint(x: 250, y: 400)),
                CellModel(type: .attack, owner: .enemy, health: Double(60 + level * 2), position: CGPoint(x: 350, y: 300)),
            ]

            // Добавляем больше врагов и нейтральных
            for _ in 1...(level / 2 + 1) {
                cells.append(CellModel(type: .defense, owner: .enemy, health: Double(Int.random(in: 40...80)), position: CGPoint(x: Int.random(in: 100...400), y: Int.random(in: 200...600))))
            }
            for _ in 1...(level / 3 + 1) {
                cells.append(CellModel(type: .multiplier, owner: .neutral, health: Double(Int.random(in: 20...50)), position: CGPoint(x: Int.random(in: 100...400), y: Int.random(in: 200...600))))
            }
            return cells
        }
    }
}
