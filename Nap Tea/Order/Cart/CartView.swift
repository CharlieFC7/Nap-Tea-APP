//
//  CartView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/16.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct CartView: View {
    
    let lightThemeColor = Color("themeColorNapTea")
    let darkThemeColor = Color("NapTeaDark")
    let width = UIScreen.main.bounds.width
    
    @Environment(\.dismiss) var dismiss         //回去上一個頁面
    
    @FirestoreQuery(collectionPath: "cart") var cartData: [CartOrder]
    
    
    @StateObject var mvm = MeunViewModel()
    
    @State var totalPrice = 0
    @State var totalAmount = 0

    var body: some View {
        ZStack{
            
            Color("backGroundColorNapTea")
                .ignoresSafeArea()
            
            VStack {
                
                header
                
                orderList
                
                //price
                
            }
            
            VStack{
                returnBack
                
                Spacer()
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.init("backGroundColorNapTea")
                .ignoresSafeArea()
            
            CartView()
        }
    }
}

extension CartView {
    
    private var header: some View {
        ZStack{
            Image("topbarphoto")
            .scaledToFill()
        }
    }
    
    private var orderList: some View {
        ZStack {
            ScrollView{
                ForEach(cartData) { cartData in
                    if cartData.orderName == mvm.lgName {
                        CartPreviewView(cartData: cartData)
                        //Text("\(cartData.amount)")
                    }
                }
                .onChange(of: cartData) { data in
                    if let user = Auth.auth().currentUser {
                        mvm.lgName = user.displayName!
                    }
                }
            }
        }
    }
    
    
    private var price: some View {

        
        HStack{
            Text("總金額")
                .font(.title2)
                .foregroundColor(darkThemeColor)
                .padding(.horizontal)
            
                Spacer()
            
            Text("共計\(cartData.count)杯")
                .font(.callout)
                .foregroundColor(.black)
                
            if cartData == [] {
                Text("$0")
                    .font(.title2)
                    .foregroundColor(darkThemeColor)
                    .padding(.horizontal)
            } else {
                Text("$100")                        //need to fix
                    .font(.title2)
                    .foregroundColor(darkThemeColor)
                    .padding(.horizontal)
            }
        }
        .padding()
        .background(lightThemeColor)
    }
    
    private var returnBack: some View {
        HStack {
            Button{
                dismiss()               //回去上一個頁面
            } label:{
                Image(systemName: "arrowshape.turn.up.backward.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(darkThemeColor)
            }
            Spacer()
        }
        .padding(.vertical)
        .frame(width: width - 40, height: 30)
    }
}
