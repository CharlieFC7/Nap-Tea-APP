//
//  MapController.swift
//  Nap Tea
//
//  Created by Charlie on 2024/6/18.
//

import Foundation
import MapKit
import CoreLocation

struct AnnotationItem: Identifiable {
    let id = UUID()
    var title: String
    var storeNumber: String
    var storeAddress: String
    var coordinate: CLLocationCoordinate2D //儲存經緯度用的

    
    init(_ title: String,_ storeNumber: String,_ storeAddress: String, latitude: Double, longitude: Double) {
        self.title = title
        self.storeNumber = storeNumber
        self.storeAddress = storeAddress
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
