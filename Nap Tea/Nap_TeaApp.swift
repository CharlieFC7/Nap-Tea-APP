//
//  Nap_TeaApp.swift
//  Nap Tea
//
//  Created by Charlie on 2024/5/30.
//

import SwiftUI
import Firebase

@main
struct Nap_TeaApp: App {
    
    init() {
        FirebaseApp.configure()             //呼叫firebase
    }
    
    var body: some Scene {
        WindowGroup {
            if Auth.auth().currentUser != nil {
                //登入狀態下
                ContentView()
                    .environmentObject(MapViewModel())
            } else {
                //未登入狀態下
                LoginView()
                    .environmentObject(MapViewModel())
            }
                
        }
    }
}
