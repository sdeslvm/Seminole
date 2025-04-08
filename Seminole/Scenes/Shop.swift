//
//  Shop.swift
//  Seminole
//
//  Created by Pavel Ivanov on 17.03.2025.
//

import SwiftUI

struct ShopView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedSkin: String = ShopStorage.shared.loadSkinId() // Выбранный скин
    @State private var selectedSphere: String = ShopStorage.shared.loadSphereId() // Выбранный скин
    @State private var stars: Int = LevelStorage.shared.loadLevels().compactMap { $0.stars }.reduce(0, +) // Количество звезд игрока
    
    @State private var ownedItems: Set<String> = ShopStorage.shared.loadBoughtItems() // Набор купленных скинов
    
    private let spheres: [ShopItem] = [
        ShopItem(id: "sphere1", image: Assets.Sphere.first, price: 0),
        ShopItem(id: "sphere2", image: Assets.Sphere.second, price: 25),
        ShopItem(id: "sphere3", image: Assets.Sphere.third, price: 50),
        ShopItem(id: "sphere4", image: Assets.Sphere.fourth, price: 75)
    ]
    
    private let skins: [ShopItem] = [
        ShopItem(id: "skin1", image: Assets.Cell.Player.red, price: 0),
        ShopItem(id: "skin2", image: Assets.Cell.Player.purple, price: 10),
        ShopItem(id: "skin3", image: Assets.Cell.Player.green, price: 20)
    ]
    
    var body: some View {
        ZStack(alignment: .top) {
            Assets.Images.backgroundImage
            
            VStack {
                VStack(spacing: 0) {
                    NavigationItem(title: "SHOP", type: .home, action: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    
                    HStack {
                        StrokedText(text: "\(stars)", strokeColor: .black, textColor: .yellow, size: 32)
                        Assets.Star.filled
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
                VStack(spacing: 16) {
                    HStack(spacing: 16) {
                        ForEach(spheres.prefix(2), id: \.id) { item in
                            let state: ButtonState = ownedItems.contains(item.id) ?
                                (selectedSphere == item.id ? .selected : .select) : .buy(price: item.price)
                            
                            ItemView(item: item, buttonState: state) { state, item in
                                handleItemSelection(state, item)
                            }
                        }
                    }
                    HStack(spacing: 16) {
                        ForEach(spheres.suffix(2), id: \.id) { item in
                            let state: ButtonState = ownedItems.contains(item.id) ?
                                (selectedSphere == item.id ? .selected : .select) : .buy(price: item.price)

                            ItemView(item: item, buttonState: state) { state, item in
                                handleItemSelection(state, item)
                            }
                        }
                    }
                    HStack(spacing: 16) {
                        ForEach(skins, id: \.id) { item in
                            let state: ButtonState = ownedItems.contains(item.id) ?
                            (selectedSkin == item.id ? .selected : .select) : .buy(price: item.price)

                            ItemView(item: item, buttonState: state) { state, item in
                                handleItemSelection(state, item)
                            }
                        }
                    }
                }
            }.padding()
        }.navigationBarBackButtonHidden()
            .onDisappear(perform: {
                ShopStorage.shared.saveBoughtItems(items: ownedItems)
                ShopStorage.shared.saveSkinId(selectedSkin)
                ShopStorage.shared.saveSphereId(selectedSphere)
            })
    }
    
    private func handleItemSelection(_ state: ButtonState, _ item: ShopItem) {
        switch state {
        case .buy(let price):
            if stars >= price {
                stars -= price
                ownedItems.insert(item.id)
                if item.id.contains("sphere") {
                    selectedSphere = item.id
                } else if item.id.contains("skin") {
                    selectedSkin = item.id
                }
            }
        case .select:
            if item.id.contains("sphere") {
                selectedSphere = item.id
            } else if item.id.contains("skin") {
                selectedSkin = item.id
            }
        default:
            break
        }
    }
}

// MARK: - Модель предмета магазина

struct ShopItem: Identifiable {
    let id: String
    let image: Image
    let price: Int
}

struct ItemView: View {
    let item: ShopItem
    var buttonState: ButtonState
    let onTap: (ButtonState, ShopItem) -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            if item.id.contains("sphere") {
                SpherView(image: item.image)
                    .frame(width: 90, height: 90)
            } else {
                item.image
                    .resizable()
                    .frame(width: 90, height: 90)
            }
            ShopButton(state: buttonState) { state in
                onTap(state, item)
            }
        }.frame(width: 100)
    }
}

struct ShopButton: View {
    var state: ButtonState
    let onTap: (ButtonState) -> Void
    
    var body: some View {
        switch state {
        case .buy(let price):
            ZStack(alignment: .bottomTrailing) {
                MainButton(text: "BUY", strokeColor: .black, textColor: .white, size: 22, settedFrame: .init(width: 100, height: 60)) {
                    onTap(state)
                }
                HStack(spacing: 4) {
                    StrokedText(text: "\(price)", strokeColor: .black, textColor: .yellow, size: 16)
                    Assets.Star.filled
                        .resizable()
                        .frame(width: 16, height: 16)
                }.padding(6)
            }.frame(width: 100, height: 80)
            
        case .select:
            MainButton(text: "SELECT", strokeColor: .black, textColor: .white, size: 22, settedFrame: .init(width: 100, height: 60)) {
                onTap(state)
            }.frame(width: 100, height: 80)
        case .selected:
            StrokedText(text: "SELECTED", strokeColor: .yellow, textColor: .black, size: 22)
                .frame(width: 100, height: 80)
        }
    }
}

struct SpherView: View {
    let image: Image
    
    var body: some View {
        ZStack {
            Assets.Sphere.uLayer
                .resizable()
                .frame(width: 90, height: 90)
            image
                .resizable()
                .frame(width: 70, height: 70)
        }
    }
}

enum ButtonState {
    case buy(price: Int)
    case select
    case selected
}

// MARK: - Превью
#Preview {
    ShopView()
}
