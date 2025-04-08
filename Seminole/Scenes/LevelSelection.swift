//
//  LevelSelection.swift
//  Seminole
//
//  Created by Pavel Ivanov on 15.03.2025.
//

import SwiftUI

struct LevelSelectionView: View {
    // MARK: - Модель данных
    @State private var levels: [LevelModel] = LevelStorage.shared.loadLevels()
    
    // Колонки для сетки
    private let columns = Array(repeating: GridItem(.fixed(90), spacing: 8), count: 4)
    
    // MARK: - Environment
    @Environment(\.presentationMode) var presentationMode
    @Binding var path: NavigationPath  // Используем path для навигации
    
    @State private var selectedLevel: LevelModel?
    @State private var gameState: GameState?
    
    var body: some View {
        ZStack(alignment: .top) {
            Assets.Images.backgroundImage
                .ignoresSafeArea()
            
            VStack {
                // Верхняя панель навигации
                NavigationItem(title: "LEVELS", type: .back, action: {
                    presentationMode.wrappedValue.dismiss()
                })
                .padding(.bottom)
                
                LazyVGrid(columns: columns, spacing: 8) {
                    ForEach(levels) { level in
                        LevelCellView(level: level) {
                            startGame(with: level)
                        }
                        .disabled(level.isLocked)
                        .frame(width: 90, height: 90)
                    }
                }
                .padding()
                
                Spacer()
            }
            .padding()
            
            if let gameState = gameState {
                GameView(path: $path) { result in
                    if result == .win {
                        LevelStorage.shared.updateLevel(
                            levelNumber: gameState.currentLevel,
                            isLocked: false,
                            stars: gameState.starRating
                        )
                        
                        levels = LevelStorage.shared.loadLevels() // Перезагружаем уровни
                        
                        if let index = levels.firstIndex(where: { $0.id == gameState.currentLevel }),
                           index + 1 < levels.count {
                            startGame(with: levels[index + 1])
                        }
                    } else {
                        if let sameLevel = levels.first(where: { $0.id == gameState.currentLevel }) {
                            startGame(with: sameLevel)
                        }
                    }
                }
                .environmentObject(gameState)
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            levels = LevelStorage.shared.loadLevels()
        }
    }
    
    private func startGame(with level: LevelModel) {
        selectedLevel = level
        gameState = GameState(level: level.id)
    }
}

// MARK: - Ячейка уровня
struct LevelCellView: View {
    let level: LevelModel
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            guard !level.isLocked else { return }
            action()
        }) {
            ZStack {
                (level.isLocked ? Assets.Cell.locked : Assets.Cell.Enemy.normal)
                    .resizable()
                    .frame(width: 90, height: 90) // Теперь всегда квадратные

                if !level.isLocked {
                    VStack {
                        StrokedText(
                            text: "\(level.id)",
                            strokeColor: .black,
                            textColor: .white,
                            size: 32
                        )

                        if let stars = level.stars {
                            HStack(spacing: 2) {
                                ForEach(1...3, id: \.self) { index in
                                    (index <= stars ? Assets.Star.filled : Assets.Star.empty)
                                        .resizable()
                                        .frame(width: 16, height: 16)
                                }
                            }
                            .padding(.top, -16) // Поднимаем звезды выше
                        }
                    }
                }
            }
        }
    }
}
