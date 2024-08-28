//
//  OrderView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/2.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MeunView: View {
    
    @StateObject var mvm = MeunViewModel()
    
    @FirestoreQuery(collectionPath: "drinks") var drink: [Drinks]
    
    @State var CartYes: Bool = false
    
    var body: some View {
        
        ZStack {
            Color("backGroundColorNapTea")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                header
                
                MeunOptionsView()
                
                Spacer()
                
            }
        }
    }
}

struct MeunView_Previews: PreviewProvider {
    static var previews: some View {
        MeunView()
    }
}


extension MeunView {
    
    private var header: some View {
        
        ZStack{
            Image("topbarphoto")
            .scaledToFill()
            .overlay(alignment: .trailing){
                //overlay 可以疊在上面 ; alignment可以選擇靠上下左右
                Button {
                    CartYes = true
                } label: {
                    Image(systemName: "cart.fill")
                        .resizable()
                        .scaledToFit()
                        .padding()
                        .foregroundColor(Color("NapTeaDark"))
                        .fullScreenCover(isPresented: $CartYes){         //換頁是整個頁面換掉
                            CartView()
                        }
                    }
                }
            }
        }
    }
