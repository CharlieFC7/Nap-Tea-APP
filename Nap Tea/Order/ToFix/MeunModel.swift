//
//  MeunModel.swift
//  Nap Tea
//
//  Created by Charlie on 2024/6/16.
//

import Foundation


struct DrinkResponse: Decodable {
    let records: [DrinkRecord]
}

struct DrinkRecord: Decodable {
    let id, createdTime: String
    let fields: DrinkFields
}

struct DrinkFields: Decodable {
    let name: String
    let englishName: String
    let description: String
    let mediumPrice: Int?
    let largePrice: Int?
    let recommend: Bool
    let upgradeToOatmilk: Bool
    let milkCapToGo: Bool
    let iceLevel: String
    let sugerLevel: String
    let extraToppings: String
    let drinkImage: [DrinkImage]
    let category: Category
}

//enum 方便之後 Meun 切換使用
enum Category: String, Decodable, CaseIterable {
    case cream
    case latte
    case tea
    case fruit
    case milk
    case hot
    case mix
    
    var title: String {
        switch self {
        case .cream: return "棉被厚奶蓋"
        case .latte: return "躺著喝歐蕾"
        case .tea: return "簡單喝原茶"
        case .fruit: return "清爽喝果茶"
        case .milk: return "好濃純鮮奶"
        case .hot: return "暖暖喝熱飲"
        case .mix: return "清爽喝過茶"
        }
    }
}

struct DrinkImage: Decodable {
    let url: URL
}
