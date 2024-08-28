//
//  NapTeaMeun.swift
//  Nap Tea
//
//  Created by Charlie on 2024/6/8.
//

import Foundation
import SwiftUI


class MeunViewModel0: ObservableObject {

    var alertTitle = "123"

     private let baseURL = URL(string: "https://api.airtable.com/v0/appMPIuBCHQkPplou/Drink")!
     private let apiKey = "patLTqZELfEqCx3dv.c95d1de915282dc8ba212846c85daf44d66480bfcc88477c420fe313c6c077bb"

     var drinks = [DrinkRecord]()
     private var drinksOfselectedCategory = [DrinkRecord]()
    

    
    // GET Drink
     func fetchDrinkData() {
         //let drinkURL = baseURL.appendingPathComponent("Drink")
         var request = URLRequest(url: baseURL)
         request.httpMethod = "GET"
         request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
         URLSession.shared.dataTask(with: request) { data, response, error in
             let decoder = JSONDecoder()                                                            // 抓取資料時(GET)，建立Decoder進行解碼

             if let data {
             do {
                 let drink = try decoder.decode(DrinkResponse.self, from: data)
                 // 將抓到的資料存入變數drinks
                 self.drinks = drink.records
                 // 將飲品類別第一頁「季節限定」的飲品存入變數drinksOfselectedCategory
                 /*for drink in self.drinks {
                     if drink.fields.category == Category.cream {
                         self.drinksOfselectedCategory.append(drink)
                     }
                 }*/
                 print("get data")
                 self.alertTitle = "get data"
             } catch {
                 print(error)
                 self.alertTitle = "erro"
                }
             } else {
                 //print(error)
                 self.alertTitle = "erro"
             }
         }.resume()
         self.alertTitle = "erro"
     }

 }
