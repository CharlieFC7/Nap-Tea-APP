//
//  MainTabView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/19.
//

import SwiftUI

struct MainTabView: View {
    
    init(){
        
        let itemAppearance = UITabBarItemAppearance()
        
        itemAppearance.normal.iconColor = UIColor(Color.gray)
        //tabbar 圖標未被選取的顏色
        itemAppearance.selected.iconColor = UIColor(#colorLiteral(red: 0.4732009172, green: 0.3230406046, blue: 0.2047396004, alpha: 1))
        //tabbar 圖標選取的顏色
        
        itemAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.gray)]
        //tabbar 文字未被選取的顏色
        itemAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(#colorLiteral(red: 0.4732009172, green: 0.3230406046, blue: 0.2047396004, alpha: 1))]
        //tabbar 文字選取的顏色
        
        
        itemAppearance.normal.badgeBackgroundColor = UIColor(Color.red)
        //tabbar 通知圓圈未選取的顏色
        itemAppearance.selected.badgeBackgroundColor = UIColor(Color.red)
        //tabbar 通知圓圈選取的顏色
        
        itemAppearance.normal.badgeTextAttributes = [.foregroundColor: UIColor(Color.white)]
        //tabbar 通知圓圈未選取文字的顏色
        itemAppearance.selected.badgeTextAttributes = [.foregroundColor: UIColor(Color.white)]
        //tabbar 通知圓圈選取文字的顏色
        
        itemAppearance.normal.badgePositionAdjustment = UIOffset(horizontal: 10, vertical: 10)
        //tabbar 通知圓圈＆文字未選取的位子
        itemAppearance.selected.badgePositionAdjustment = UIOffset(horizontal: 10, vertical: 10)
        //tabbar 通知圓圈＆文字選取的位子
        
        
        let appearance1 = UITabBarAppearance()
        
        appearance1.stackedLayoutAppearance = itemAppearance
        //這行是將上面設置的itemAppearance 應用到 UITabBarAppearance() 的stackedLayoutAppearance屬性
        
        appearance1.backgroundColor = UIColor(#colorLiteral(red: 0.9542911649, green: 0.9239712358, blue: 0.8992015123, alpha: 1))
        //tabbar 的背景顏色
        appearance1.shadowColor = UIColor(Color.black)
        //tabbar 上面的那條線的顏色
        
        
        UITabBar.appearance().scrollEdgeAppearance = appearance1
        //這行是將剛剛全部的設定全部顯示出來

                
    }
    
    let backgroundColor = Color("backGroundColorNapTea")
    
    var body: some View {
        
        TabView {
            HomeScreenView()
            //這個頁面的呈現
                .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
                 //介面顏色的長寬調整
                .background(backgroundColor)
                 //背景顏色
                .badge(0)
                 //通知圈圈的數字
                .tabItem{
                    Image(systemName: "house")
                    //tabbar 圖標
                    Text("首頁")
                    //tabbar 文字
                }
            
            MeunView()
                .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
                .background(backgroundColor)
                .tabItem{
                    Image(systemName: "takeoutbag.and.cup.and.straw")
                    Text("訂購")
                }
            
            MapView()
                .frame(minWidth: 0,maxWidth: .infinity,minHeight: 0,maxHeight: .infinity)
                .background(backgroundColor)
                .tabItem{
                    Image(systemName: "map.fill")
                    Text("門市地圖")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
            MainTabView()
    }
}
