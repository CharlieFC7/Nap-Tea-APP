//
//  MapLocation.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/10.
//
//幫資料設定資料型態

import Foundation
import MapKit

struct MapLocation: Identifiable, Equatable {
    
    let id = UUID()  //這讓給個資料是獨一無二的 identifiable
    let name: String
    let storeNumber: String
    let storeAddress: String
    let coordinate: CLLocationCoordinate2D  //儲存經緯度用的
    
    //Equatable
    static func == (lhs: MapLocation, rhs: MapLocation) -> Bool {
        lhs.id == rhs.id
    }
    
}
