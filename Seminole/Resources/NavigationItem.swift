//
//  NavigationItem.swift
//  Seminole
//
//  Created by Pavel Ivanov on 15.03.2025.
//

import SwiftUI

struct NavigationItem: View {
    
    let title: String
    let type: NavigationItemType
    let action: (() -> Void)
    
    var body: some View {
        ZStack(alignment: .center) {
            StrokedText(text: title, strokeColor: .black, textColor: .white)
            
            HStack {
                Button(action: {
                    // Действие для закрытия экрана
                    action()
                }) {
                    switch type {
                    case .back:
                        Assets.Button.back
                            .resizable()
                            .frame(width: Constants.Button.circleSmall.width, height: Constants.Button.circleSmall.height)
                    case .home:
                        Assets.Button.home
                            .resizable()
                            .frame(width: Constants.Button.circleSmall.width, height: Constants.Button.circleSmall.height)
                    }
                    
                }
                .padding()
                
                Spacer()
            }
        }
    }
}

enum NavigationItemType {
    case home
    case back
}
