//
//  CartPreviewView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/16.
//

import SwiftUI

struct CartPreviewView: View {
    
    let darkThemeColor = Color("NapTeaDark")
    
    @State var cartData: CartOrder
    @StateObject var mvm = MeunViewModel()
    
    var body: some View {
        VStack {
            HStack {
                imagedrink
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(cartData.drink)
                        .font(.headline)
                        .foregroundColor(darkThemeColor)
                    
                    Text("\(cartData.size)/\(cartData.ice)/\(cartData.sugar)")
                        .font(.subheadline)
                        .foregroundColor(darkThemeColor)
                    
                    if cartData.toppings == [] {
                        
                    } else {
                        HStack(spacing: 0) {
                            ForEach(cartData.toppings, id: \.self) { cartData in
                                if !cartData.isEmpty {
                                    Text(cartData)
                                        .font(.caption)
                                        .foregroundColor(darkThemeColor)
                                }
                            }
                        }
                    }
                    
                    amountButton
                }
                
                Spacer()
                
                ZStack {
                    Text("$\(cartData.price * cartData.amount)")
                        .font(.title2)
                        .foregroundColor(darkThemeColor)
                        .padding(.horizontal)
                    
                    HStack {
                        
                        Spacer()
                        
                        removeButton
                        
                    }
                }
            }
            .padding(.leading)
            
            Divider()
        }
    }
}

struct CartPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.init("backGroundColorNapTea")
                .ignoresSafeArea()
            
            CartPreviewView(cartData: CartOrder(orderName: "Charlie", drink: "日安紅濃茶歐蕾", image: "https://i.ibb.co/9yhFj16/IMG-6944.jpg", size: "大杯", sugar: "微糖", ice: "微冰", toppings: ["+珍珠", "＋仙草"], amount: 1, price: 60))
        }
    }
}


extension CartPreviewView {
    
    private var removeButton: some View {
        VStack {
            
            Button {
                mvm.orderid = cartData.id!
                mvm.removeOrder()
            } label: {
                Image(systemName: "trash.fill")
                    .foregroundColor(.red)
                    .frame(alignment: .topTrailing)
                }
            .padding(.trailing)
            
            Spacer()
        }
    }
    
    private var imagedrink: some View {
        ZStack {
            AsyncImage(url: URL(string: cartData.image)) {photo in
                if let image = photo.image {
                    image
                        .resizable()
                } else {
                    Image("logo")
                        .resizable()
                }
            }
            .scaledToFit()
            .cornerRadius(10)
            .frame(width: 100, height: 100)
            .padding(5)
        }
    }
    
    private var amountButton: some View {
        HStack {
            Button {
                if cartData.amount <= 1 {
                    
                } else {
                    cartData.amount = cartData.amount - 1
                    mvm.orderid = cartData.id!
                    mvm.orderAmount = cartData.amount
                    mvm.modifyOrder()
                }
            } label: {
                Text("-")
                    .foregroundColor(.white)
                    .font(.title2)
                }
            
            Text("\(cartData.amount)")
                .foregroundColor(.white)
                .font(.title2)
                .padding(.horizontal,10)
            
            Button {
                cartData.amount = cartData.amount + 1
                mvm.orderid = cartData.id!
                mvm.orderAmount = cartData.amount
                mvm.modifyOrder()
            } label: {
                Text("+")
                    .foregroundColor(.white)
                    .font(.title2)
            }
        }
        .frame(width: 100, height: 30)
        .background(darkThemeColor)
        .cornerRadius(40)
    }
}
