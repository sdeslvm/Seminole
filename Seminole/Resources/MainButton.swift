//
//  MainButton.swift
//  Seminole
//
//  Created by Pavel Ivanov on 13.03.2025.
//

import SwiftUI

struct MainButton: View {
    
    let text: String
    let strokeColor: Color
    let textColor: Color
    let size: CGFloat
    let settedFrame: CGSize?
    let action: (() -> Void)?
    
    init(
        text: String,
        strokeColor: Color = .black,
        textColor: Color = .white,
        size: CGFloat = 36,
        settedFrame: CGSize? = nil,
        action:  (() -> Void)? = nil
    ) {
        self.text = text
        self.strokeColor = strokeColor
        self.textColor = textColor
        self.size = size
        self.settedFrame = settedFrame
        self.action = action
    }
    
    var body: some View {
        Button {
            action?()
        } label: {
            ZStack {
                Assets.Button.main
                    .resizable()
                    .frame(width: settedFrame?.width ?? Constants.Button.rectangleBig.width, height: settedFrame?.height ?? Constants.Button.rectangleBig.height)
                StrokedText(
                    text: text,
                    strokeColor: strokeColor,
                    textColor: textColor,
                    size: size
                )
            }
        }
    }
}
