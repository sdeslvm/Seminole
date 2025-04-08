//
//  StrokedText.swift
//  Seminole
//
//  Created by Pavel Ivanov on 13.03.2025.
//

import SwiftUI

struct StrokedText: View {
    var text: String
    var font: Font
    var strokeColor: Color
    var textColor: Color
    var strokeWidth: CGFloat
    
    init(text: String, strokeColor: Color, textColor: Color, strokeWidth: CGFloat = 2, size: CGFloat = 44) {
        self.text = text
        self.font = .Cubano(size: size)
        self.strokeColor = strokeColor
        self.textColor = textColor
        self.strokeWidth = strokeWidth
    }

    var body: some View {
        ZStack {
            // Обводка
            Text(text)
                .font(font)
                .foregroundColor(strokeColor)
                .offset(x: -strokeWidth, y: -strokeWidth)

            Text(text)
                .font(font)
                .foregroundColor(strokeColor)
                .offset(x: strokeWidth, y: -strokeWidth)

            Text(text)
                .font(font)
                .foregroundColor(strokeColor)
                .offset(x: -strokeWidth, y: strokeWidth)

            Text(text)
                .font(font)
                .foregroundColor(strokeColor)
                .offset(x: strokeWidth, y: strokeWidth)

            // Основной текст
            Text(text)
                .font(font)
                .foregroundColor(textColor)
        }
    }
}
