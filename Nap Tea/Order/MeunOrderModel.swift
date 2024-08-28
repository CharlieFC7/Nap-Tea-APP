//
//  MeunOrderModel.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/16.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift


struct Drinks: Codable, Identifiable, Hashable {                //Meun
    @DocumentID var id: String?
    let name: String
    let englishName: String
    let category: String
    let mediumPrice: Int
    let largePrice: Int
    let recommend: Bool
    let image: String
}


struct CartOrder: Codable, Identifiable, Hashable {             //cart 購物車
    @DocumentID var id: String?
    var orderName: String
    var drink: String
    var image: String
    var size: String
    var sugar: String
    var ice: String
    var toppings: Array<String>
    var amount: Int
    var price: Int
}
