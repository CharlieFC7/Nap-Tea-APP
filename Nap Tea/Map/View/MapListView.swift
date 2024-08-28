//
//  MapListView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/10.
//
//門市清單頁面

import SwiftUI

struct MapListView: View {
    
    @EnvironmentObject private var vm: MapViewModel
    
    var body: some View {
        List{
            ForEach(vm.locations) { location in
                listRowView(location: location)
            }
        }
    }
}

struct MapListView_Previews: PreviewProvider {
    static var previews: some View {
        MapListView()
            .environmentObject(MapViewModel())
    }
}

extension MapListView{
    
    private func listRowView(location: MapLocation) -> some View {
        
        Button {
            vm.showNextLocation(location: location)         //按鈕按下去會更新地圖
            vm.showMapPreiviewView = true
        } label: {
            HStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 45, height: 45)
                Text(location.name)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .font(.title2)
        }
    }
}
