//
//  TopTabView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/6.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct TopTabView: View {
    
    @FirestoreQuery(collectionPath: "drinks") var drink: [Drinks]
    
    let lightColor = Color("themeColorNapTea")
    let darkColor = Color("NapTeaDark")
    
    @State private var selectedTabIndex = 0
    @State private var selectedTabID: Int? = nil
    let tabTitle = ["棉被厚奶蓋", "躺著喝歐蕾", "簡單喝原茶", "清爽喝果茶", "好濃純鮮奶", "暖暖喝熱飲", "清爽喝過茶"]
    
    let appearance = UITabBarAppearance()
    
    init() {
        appearance.shadowColor = UIColor(Color.black)
        //tabbar 上面的那條線的顏色
    }
    
    var body: some View {
        
        GeometryReader(content: {geometry in                //GeometryReader 取得元件在整個螢幕的座標尺寸
            VStack (spacing: 0) {
                ScrollView(.horizontal, showsIndicators:  false) {
                    LazyHStack(spacing: 20) {                           //LazyHStack 元件將在需要時才生成
                        ForEach(0..<tabTitle.count, id:\.self) {index in
                            Button(action: {
                                withAnimation {
                                    selectedTabIndex = index
                                    selectedTabID = index
                                }
                            }) {
                                //設定tabview 外貿
                                Text(tabTitle[index])
                                    .font(.headline)
                                    .foregroundColor(selectedTabIndex == index ? darkColor: .black)
                                    .frame(width: 87)
                                    
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .frame(height: 50)
                
                
                //tabView的頁面呈現
                TabView(selection: $selectedTabIndex) {
                    ForEach(0..<tabTitle.count, id: \.self) {index in
                        VStack {
                            ForEach(drink) { drink in
                                if tabTitle[index] == drink.category{
                                    MeunPreviewView(drink: drink)
                                }
                            }
                        }
                        .ignoresSafeArea(edges: .bottom)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
                }
        })
        .ignoresSafeArea(edges: .bottom)
        .onChange(of: selectedTabIndex) { newValue in
            withAnimation {
                selectedTabIndex = newValue
                selectedTabID = newValue
            }
        }
    }
}

struct TopTabView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color("backGroundColorNapTea")
                .ignoresSafeArea()
            TopTabView()
        }
    }
}
