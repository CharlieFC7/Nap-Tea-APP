//
//  LocationData.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/10.

// 這個擋是所有地標資料，之後要在加其它地標的話，這邊再加上就可以了

import Foundation
import MapKit

class LocationData{
    
    static let locations: [MapLocation] = [
    MapLocation(name: "台北南陽店", storeNumber: "02-2370-5200", storeAddress: "台北市中正區南陽街24號", coordinate: CLLocationCoordinate2D(latitude: 25.044477, longitude: 121.516006)),
    MapLocation(name: "台北大安店", storeNumber: "02-2740-5200", storeAddress: "台北市大安區大安路一段17號", coordinate: CLLocationCoordinate2D(latitude: 25.044524, longitude: 121.546367)),
    MapLocation(name: "台北江南店", storeNumber: "02-2799-8200", storeAddress: "台北市內湖區港墘里江南街73號", coordinate: CLLocationCoordinate2D(latitude: 25.077098, longitude: 121.577338)),
    MapLocation(name: "台北寧夏店", storeNumber: "02-2558-2578", storeAddress: "台北市大同區民生西路208號", coordinate: CLLocationCoordinate2D(latitude: 25.056892, longitude: 121.515079)),
    MapLocation(name: "台北錦州店", storeNumber: "02-2518-1765", storeAddress: "台北市中山區錦州街446號", coordinate: CLLocationCoordinate2D(latitude: 25.060040, longitude: 121.543193)),
    MapLocation(name: "台北伊通店", storeNumber: "02-2507-7994", storeAddress: "台北市中山區伊通街83號", coordinate: CLLocationCoordinate2D(latitude: 25.052839, longitude: 121.534953)),
    MapLocation(name: "台北吳興店", storeNumber: "02-2722-0056", storeAddress: "台北市信義區吳興街53號", coordinate: CLLocationCoordinate2D(latitude: 25.031112, longitude: 121.560337)),
    
    MapLocation(name: "新北樂華店", storeNumber: "02-2925-0001", storeAddress: "新北市永和區永和路一段158號", coordinate: CLLocationCoordinate2D(latitude: 25.008400, longitude: 121.514175)),
    MapLocation(name: "新北民權店", storeNumber: "02-2218-0652", storeAddress: "新北市新店區民權路125號", coordinate: CLLocationCoordinate2D(latitude: 25.089900, longitude: 121.472014)),
    MapLocation(name: "新北幸福店", storeNumber: "02-2990-6595", storeAddress: "新北市新莊區幸福路770號", coordinate: CLLocationCoordinate2D(latitude: 25.049228, longitude: 121.447081)),
    
    MapLocation(name: "桃園統領店", storeNumber: "03-339-1765", storeAddress: "桃園市桃園區中正路61號1樓館外 F1-004櫃位", coordinate: CLLocationCoordinate2D(latitude: 24.991094, longitude: 121.312396)),
    
    MapLocation(name: "台中一中店", storeNumber: "04-2225-5010", storeAddress: "台中市北區尊賢街7號", coordinate: CLLocationCoordinate2D(latitude: 24.148776, longitude: 120.685294)),
    MapLocation(name: "台中誠品店", storeNumber: "04-2251-1348", storeAddress: "台中市西屯區市政路480號B1 B116櫃位", coordinate: CLLocationCoordinate2D(latitude: 24.159755, longitude: 120.638499)),
    MapLocation(name: "台南南紡店", storeNumber: "06-237-0789", storeAddress: "台南市東區中華東路一段366號B1 B13櫃位", coordinate: CLLocationCoordinate2D(latitude: 22.991689, longitude: 120.233563)),
    
    MapLocation(name: "高雄義享店", storeNumber: "07-550-8342", storeAddress: "高雄市鼓山區大順一路115號B2 05櫃位", coordinate: CLLocationCoordinate2D(latitude: 22.991689, longitude: 120.233563))
    ]
}
