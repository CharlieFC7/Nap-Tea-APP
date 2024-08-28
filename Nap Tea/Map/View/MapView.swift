//
//  MapView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/6/18.
//
//地圖的主要頁面

import SwiftUI
import MapKit
import CoreLocation
import CoreLocationUI


struct MapView: View {
    
    @EnvironmentObject private var  vm: MapViewModel  //方便使用MapViewModel的功能

    /*private let lm = CLLocationManager()
    init() {
        lm.requestAlwaysAuthorization()
        lm.requestWhenInUseAuthorization()
    } //先確定是否被授權定位*/

    
    var body: some View {
        
        ZStack{
            
            mapLayer
            .ignoresSafeArea()  //滿版面
            
            VStack {

                if vm.showMapPreiviewView == true {
                    MapPreviewStack
                }
                
                Spacer()
                
                VStack{
                    searchStore
                    LocationPoint
                }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
                    .padding()
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .environmentObject(MapViewModel())
    }
}



extension MapView {
    
    
    //查所有門市的列表按鈕
    private var searchStore: some View {   //查門市按鈕
        
        ZStack{
            
            Button{
                vm.showLocationSheet = true         //出現現在門市列表
            } label: {
                Image(systemName: "magnifyingglass.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    //.foregroundColor(Color("NapTeaDark"))
                    .padding()
                    .background {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                    }
            }
            //跳出MapListView頁面
            .sheet(isPresented: $vm.showLocationSheet){
             MapListView()
                    .presentationDetents([.medium]) //改變sheet的高度
            }
        }
    }
    
    
    //地圖回到定位點的按鈕
    private var LocationPoint: some View {    //將地圖回到定位
        
        ZStack{
            
            Button{
                vm.userLocation = true
                vm.showMapPreiviewView = false
                vm.requestAllowOnceLocationPermission()
            } label: {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    //.foregroundColor(Color("NapTeaDark"))
                    .padding()
                    .background {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 40, height: 40)
                    }
            }
            .alert(vm.alertTitle, isPresented: $vm.alertShow) {
                    Button("OK"){}
            }
        }
    }
    
    
    //呈現在地圖上的詳細資料
    private var MapPreviewStack: some View {
        
        ZStack{
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                MapPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .frame(maxWidth: .infinity)
                        //動畫讓UI順順的
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
    
    
    //開啟地圖，定位，放門市地標
    private var mapLayer: some View{
        
        ZStack{
            Map(coordinateRegion: $vm.mapRegion,                                 //地圖起始的位置
                showsUserLocation: vm.userLocation, userTrackingMode: .constant(.follow),  //持續追中定位
                annotationItems: vm.locations ) { location in
                MapAnnotation (coordinate: location.coordinate) {                //抓取標的地點
                    
                    ZStack{
                        VStack{
                            
                            //放置客製化的標記
                            MapAnnotationView()
                                .scaleEffect(vm.mapLocation == location ? 1:0.7)
                                .shadow(radius: 10)
                                //按下地圖標記會更新地圖
                                .onTapGesture {
                                    vm.showMapPreiviewView = true
                                    vm.showNextLocation(location: location)
                                }

                                
                            /*  用來確認是否正確
                            VStack{
                                Text(location.name)
                                Text(location.storeNumber)
                                Text(location.storeAddress)
                            }.border(.gray)
                                .foregroundColor(.white)
                                .background(Color.init(#colorLiteral(red: 0.4732009172, green: 0.3230406046, blue: 0.2047396004, alpha: 1)))*/    //出現地圖上的資料
                        }
                    }
                }
            }
                .onTapGesture {
                    vm.showMapPreiviewView = false
                }
        }
    }
    
}
