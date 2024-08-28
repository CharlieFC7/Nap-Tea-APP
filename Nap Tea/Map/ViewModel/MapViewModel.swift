//
//  MapViewModel.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/10.
//

import Foundation
import MapKit
import SwiftUI
import CoreLocation


class MapViewModel: NSObject ,ObservableObject, CLLocationManagerDelegate {
    
    
    @Published var locations: [MapLocation]                         // 抓取地標
    
    @Published var userLocation: Bool = true
    
    @Published var showMapPreiviewView: Bool = false            //一開始讓MapPreviewView 未出現
    
    @Published var alertShow: Bool = false
    @Published var alertTitle = ""
    
    
    //現在的位子在地圖上
    @Published var mapLocation: MapLocation{
        didSet{
            updateMapRegion(location: mapLocation)   //mapLocation 變更後, mapRegion 也會跟著更新
        }
    }
    

    
    
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()                 //呈現地圖上現在的位置
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)        //地圖顯示的距離
    
    
    let locationManger = CLLocationManager()
    
    //詢問是否允許定位
    func requestAllowOnceLocationPermission() {
        locationManger.requestLocation()
    }
    
    //定位成功的動作
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let latestLocation = locations.first
        else{
            return
        }
        DispatchQueue.main.async {
            self.mapRegion = MKCoordinateRegion(center: latestLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        }
    }
    
    //定位失敗的動作
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        alertShow = true
        alertTitle = "\(error.localizedDescription)"
    }
     
    
    
    
    
    //更新地圖位置
    private func updateMapRegion(location: MapLocation) {
        withAnimation(.easeInOut){
            mapRegion = MKCoordinateRegion(
                center: location.coordinate,
                span: mapSpan)
        }
    }
    
    
    //地圖會跑到那間分店的地址
    func showNextLocation(location: MapLocation) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationSheet = false   //案完後，mapListView會隱藏
            userLocation = false
        }
    }
    
    
    //MapListView 一開始是未出現
    @Published var showLocationSheet:Bool = false
    
    override init() {
        let locations = LocationData.locations
        self.locations = locations
        self.mapLocation = locations.first!
        
        super.init()
        locationManger.delegate = self
        
        self.updateMapRegion(location: locations.first!)
    }
    
}
