//
//  StoreCell.swift
//  Nap Tea
//
//  Created by Charlie on 2024/6/18.
//
//詳細門市資料頁面設計

import SwiftUI


struct MapPreviewView: View {
    
    let location: MapLocation
    
    var body: some View {
        
        ZStack{
            information
        }
    }
}

struct MapPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.init((#colorLiteral(red: 0.9542911649, green: 0.9239712358, blue: 0.8992015123, alpha: 1)))
                .ignoresSafeArea()
            
            MapPreviewView(location: LocationData.locations.first!)
                .padding()
        }
    }
}


extension MapPreviewView {
    
    private var information: some View {
        
        HStack{
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(10)
                .padding(6)
            
            VStack(alignment: .leading) {
                Text(location.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(5)
                    
                Text(location.storeAddress)
                    .font(.subheadline)

                //按電話號碼可以直接連接電話
                Link(destination: URL(string: "tel:\(location.storeNumber)")!, label: {
                        Text(location.storeNumber)
                            .font(.subheadline)
                })

            }
            .frame(alignment: .leading)
        }
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
            )
    }
    
}
