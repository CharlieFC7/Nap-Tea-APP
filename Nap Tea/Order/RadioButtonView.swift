//
//  RadioButtonView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/20.
//

import Foundation
import SwiftUI


struct sizeRadioButton: View {
    
    @Binding var selectedSize: String
 
    let darkThemeColor = Color("NapTeaDark")
    
    let size = ["中杯 Medium 480ml", "大杯 Large 660ml"]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("尺寸 Size")
                .foregroundColor(.black)
                .font(.title)
            
            ForEach(size ,id: \.self) {option in
                
                Button {
                    
                    self.selectedSize = option
                    
                } label: {
                    HStack {
                        
                        Text(option)
                            .foregroundColor(darkThemeColor)
                            .font(.title3)
                        
                        Spacer()
                        
                        if selectedSize == option {
                            
                            Circle()
                                .fill(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)).opacity(0.8))
                                .frame(width: 20, height: 20)
                        } else {
                            Circle()
                                .stroke(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)), lineWidth: 4)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
        }
    }
}


struct iceRadioButton: View {
    
    @Binding var selectedIce: String
 
    let darkThemeColor = Color("NapTeaDark")
    
    let ice = ["正常冰 Regular ice", "少冰 Less ice", "微冰 Light ice", "去冰 ice free"]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("冰量 Ice level")
                .foregroundColor(.black)
                .font(.title)
            
            ForEach(ice ,id: \.self) {option in
                
                Button {
                    
                    self.selectedIce = option
                    
                } label: {
                    HStack {
                        
                        Text(option)
                            .foregroundColor(darkThemeColor)
                            .font(.title3)
                        
                        Spacer()
                        
                        if selectedIce == option {
                            
                            Circle()
                                .fill(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)).opacity(0.8))
                                .frame(width: 20, height: 20)
                        } else {
                            Circle()
                                .stroke(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)), lineWidth: 4)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
        }
    }
}


struct sugarRadioButton: View {
    
    @Binding var selectedSugar: String
 
    let darkThemeColor = Color("NapTeaDark")
    
    let sugar = ["全糖 full sugar", "少糖 less sugar", "半糖 half sugar", "微糖 light sugar", "一分糖 10% sugar", "無糖 sugar free"]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("甜度 Sugar level")
                .foregroundColor(.black)
                .font(.title)
            
            ForEach(sugar ,id: \.self) {option in
                
                Button {
                    
                    self.selectedSugar = option
                    
                } label: {
                    HStack {
                        
                        Text(option)
                            .foregroundColor(darkThemeColor)
                            .font(.title3)
                        
                        Spacer()
                        
                        if selectedSugar == option {
                            
                            Circle()
                                .fill(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)).opacity(0.8))
                                .frame(width: 20, height: 20)
                        } else {
                            Circle()
                                .stroke(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)), lineWidth: 4)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
            }
        }
    }
}
