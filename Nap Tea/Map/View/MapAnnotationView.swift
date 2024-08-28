//
//  MapAnnotationView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/11.
//
//  地圖上的標記圖設計

import SwiftUI

struct MapAnnotationView: View {
    
    let themeColor = Color("NapTeaDark")
    
    var body: some View {
        VStack(spacing:0) {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width:40, height: 40)
                .font(.headline)
                .padding(6)
                .background(themeColor)
                .cornerRadius(10)
            
            Image(systemName: "triangle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(themeColor)
                .frame(width: 20, height: 20)
                .rotationEffect(Angle(degrees: 180))
                .offset(y: -3.5)
                .padding(.bottom, 35)
        }
    }
}

struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            
            MapAnnotationView()
        }
    }
}
