//
//  IgPostView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/6/18.
//

import SwiftUI


struct IgPostView: View {
    
    @Environment(\.dismiss) var dismiss             //回去上一個頁面
    
    let igData: InstagramInformation
    
    var wordColor = Color("NapTeaDark")
    var widthIg = UIScreen.main.bounds.width              //尋找出裝置的寬
    
    var body: some View {
        
        VStack {
            
            header
            
            poster
            
            article
                        
            Spacer()

        }
        .ignoresSafeArea()
        .toolbar(.hidden, for: .tabBar)         //tabView隱藏起來
        
    }
}

struct IgPostView_Previews: PreviewProvider {
    static var previews: some View {
        IgPostView(igData: InstagramData.shared.igData.first!)
    }
}

extension IgPostView {
    
    private var header: some View {
        
        VStack(spacing: 1) {
            HStack{
                Button{
                    dismiss()               //回去上一個頁面
                } label:{
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color("NapTeaDark"))
                        .padding()
                }
                
                    Spacer()
            }

            HStack {
                //按下上面的napteazzz 可以直接跳到再睡五分鐘的Ig 官網
                Link(destination: URL(string: "https://www.instagram.com/napteazzz/")!, label: {
                    HStack {
                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 48, height: 48)
                            .clipShape(Circle())
                            .padding(10)
                         
                        Text("napteazzz")
                            .font(.title)
                            .foregroundColor(wordColor)
                            .offset(x: -10,y: -2 )
                    }
                })
                
                Spacer()
                
                Text(igData.postDate)
                    .font(.subheadline)
                    .foregroundColor(wordColor)
                    .padding()
            }
            
        }
        .padding()
    }
    
    private var poster: some View {
        
        ZStack(){
            TabView {
                ForEach(igData.postImage, id: \.self) {
                    Image($0)
                         .resizable()
                         .scaledToFit()
                         .frame(width: widthIg)
                         .clipped()
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }
    
    private var article: some View{
        
        HStack {
            ScrollView{
                Text(igData.postContent)
                    .padding()
                    .font(.title3)
                    .foregroundColor(wordColor)
            }
            
            
            Spacer()
        }

    }
    
}
