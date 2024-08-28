//
//  MeunPreviewView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/7.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MeunPreviewView: View {
    
    @State var drink: Drinks
    
    @State var openOrderView = false
    
    let lightColor = Color("themeColorNapTea")
    let darkColor = Color("NapTeaDark")
    
    var body: some View {
                ZStack{
                    HStack{
                        VStack(alignment: .leading) {
                            HStack{
                                Text(drink.name)
                                    .font(.title2)
                                    .foregroundColor(.black)
                                
                                if drink.recommend == true {
                                    Image(systemName: "checkmark.seal.fill")
                                        .foregroundColor(darkColor)
                                }
                            }
                            Text(drink.englishName)
                                .font(.callout)
                                .foregroundColor(darkColor)
                            
                            if drink.largePrice == 0 {
                                Text("中杯：$\(drink.mediumPrice)")
                                    .font(.callout)
                                    .foregroundColor(.black)
                            } else {
                                Text("中杯：$\(drink.mediumPrice) / 大杯：$\(drink.largePrice)")
                                    .font(.callout)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        imagedrink
                        
                    
                    Divider()
                }
        }
        .onTapGesture {
            openOrderView = true
        }.sheet(isPresented: $openOrderView) {
            OrderView(drinks: drink)
        }
        
    }
}

struct MeunPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        
        ZStack{
            Color("backGroundColorNapTea")
                .ignoresSafeArea()
            MeunPreviewView(drink: Drinks(name: "棉被厚奶蓋", englishName: "Signature Black Tea with Milk cap", category: "棉被厚奶蓋", mediumPrice: 60, largePrice: 75, recommend: true, image: "https://i.ibb.co/qgXzMTC/IMG-6940.jpg"))
        }
    }
}

extension MeunPreviewView {
    
    private var imagedrink: some View {
        ZStack {
            AsyncImage(url: URL(string: drink.image)) {photo in
                if let image = photo.image {
                    image
                        .resizable()
                } else {
                    Image("logo")
                        .resizable()
                }
            }
            .scaledToFit()
            .frame(width: 100, height: 100)
            .padding(.horizontal)
        }
    }
}
