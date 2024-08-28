//
//  MeunOptionsView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/7.
//
//類別分類

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MeunOptionsView: View {
    
    let lightColor = Color("themeColorNapTea")
    let darkColor = Color("NapTeaDark")

    
    let tabTitle = ["棉被厚奶蓋", "躺著喝歐蕾", "簡單喝原茶", "清爽喝果茶", "好濃純鮮奶", "暖暖喝熱飲"]
    @State var selectedCategory = "棉被厚奶蓋"
    
    @FirestoreQuery(collectionPath: "drinks") var drink: [Drinks]
    
    var body: some View {
        
        VStack{
            
            optionsBar
            
            drinksMeun
            
            Spacer()
            
        }
    }
}

struct MeunOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("backGroundColorNapTea")
                .ignoresSafeArea()
            
            MeunOptionsView()
        }
    }
}

extension MeunOptionsView {
    
    private var optionsBar: some View {
        ZStack{
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 30) {
                    
                    Spacer()
                    
                    ForEach(0..<tabTitle.count, id: \.self) {index in
                        VStack{
                            Text(tabTitle[index])
                                .foregroundColor(tabTitle[index] == selectedCategory ? darkColor : .gray)
                            
                            if selectedCategory == tabTitle[index] {               //被選上時的狀態
                                Capsule()
                                    .fill(darkColor)
                                    .frame(height: 3)
                                    .padding(.horizontal, -10)
                            } else {                                    //沒被選上時的狀態
                                Capsule()
                                    .fill(.clear)
                                    .frame(height: 3)
                                    .padding(.horizontal, -10)
                            }
                        }
                        .onTapGesture {
                            self.selectedCategory = tabTitle[index]
                        }
                    }
                }
            }
        }
    }
    
    private var drinksMeun: some View {
        ZStack{
            ScrollView{
                ForEach(drink) { drink in
                    if selectedCategory == drink.category{
                        MeunPreviewView(drink: drink)
                    }
                }
                
            }
            .padding(.vertical)
        }
    }
    
}
