//
//  HomeScreenView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/6/16.
//

import SwiftUI
import FirebaseAuth

struct HomeScreenView: View {
    
    @State var logoutYes = false
    
    @State var lgName = ""
    
    var widthIg = UIScreen.main.bounds.width        //設定出裝置的寬度
    
    
    let bannerImages = ["banner_0", "banner_1", "banner_2", "banner_3", "banner_4", "banner_5", "banner_6", "banner_7", "banner_8", "banner_9"]         //放banner要放的圖片
    public let bannerTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()          //every動一次設定幾秒 ; autoconnect 自動化
    @State private var bannerSelection = 0
    
    
    
    var body: some View {
        
        NavigationStack{
            ZStack{
                Color("backGroundColorNapTea")
                    .ignoresSafeArea()
                
                VStack {
                    
                    header
                    ScrollView{
                        bannerView
                            .frame(width: widthIg, height: widthIg/2.5)
                        
                        PostGridView(igData: InstagramData.shared.igData.first!)
                            
                    }
                }
                
            }

        }
    }
}

struct HomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenView()
    }
}

extension HomeScreenView {
    
    private var header: some View {
        
        ZStack{
            Image("topbarphoto")
            .scaledToFill()
            .overlay(alignment: .trailing){
                //overlay 可以疊在上面 ; alignment可以選擇靠上下左右
                Button ("登出"){
                    logout()
                }
                .padding()
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
                .foregroundColor(.init(#colorLiteral(red: 0.4732009172, green: 0.3230406046, blue: 0.2047396004, alpha: 1)))        //文字顏色
                .fullScreenCover(isPresented: $logoutYes){         //換頁是整個頁面換掉
                    LoginView()
                }
            }
            userNameView
        }
    }
    
    
    private var userLogo: some View {
        
        HStack{
            Button {                        //使用者的logo，按下去會出現使用者名稱
                userName()
            } label: {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35, height: 35)
                    .foregroundColor(Color("NapTeaDark"))
                    .padding()
            }
            Spacer()
        }
    }
    
    private var userNameView: some View {
        
        ZStack{
            if lgName == ""{
                userLogo
            } else {
                HStack{
                    Button {
                        lgName = ""
                    } label: {
                        Text(lgName)
                            .font(.title2)
                            .foregroundColor(Color("NapTeaDark"))
                    }
                    
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    
    private var bannerView: some View {
        
        ZStack{
            TabView(selection: $bannerSelection) {
                ForEach(0..<10){ i in
                    Image("\(bannerImages[i])")
                        .resizable()
                }
            }
            .frame(width: widthIg)                      //圖片大小
            .scaledToFill()
            .tabViewStyle(PageTabViewStyle())           //可以左右滑動
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .automatic))          //自動判斷現在在第幾頁
            .onReceive(bannerTimer, perform: {_ in
                withAnimation{
                    bannerSelection = bannerSelection < 10 ? bannerSelection + 1 : 0
                    //圖片數量大於等於的數字就回到第一張
                }
            })
        }
    }
    
    
    func logout() {               //Firebase 登出功能
        do {
            try Auth.auth().signOut()
            logoutYes = true
        } catch {
            print(error)
        }
    }
    
    func userName() {               //找出Firebase 的使用者名稱
        if let user = Auth.auth().currentUser {
            lgName = user.displayName!
        }
    }
    
}
