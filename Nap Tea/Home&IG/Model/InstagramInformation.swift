//
//  InstagramInformation.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/23.
//
//幫資料設定資料型態

import Foundation


struct InstagramInformation: Identifiable, Equatable,Hashable {
    
    let id = UUID()
    let postDate: String
    let postImageMain:String
    let postImage: [String]
    let postContent: String
    
    //Equatable
    static func == (lhs: InstagramInformation, rhs: InstagramInformation) -> Bool {
        lhs.id == rhs.id
    }
}
