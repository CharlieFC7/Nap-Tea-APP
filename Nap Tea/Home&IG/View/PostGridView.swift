//
//  PostGridView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/18.
//

import SwiftUI

struct PostGridView: View {
    
    @StateObject var igvm = InstagramViewModel(service: InstagramService())
    
    let igData: InstagramInformation
    
    private let itmes = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible())
    ]
    
    private let width = (UIScreen.main.bounds.width / 3) - 2
    
    var body: some View {

        NavigationStack{
            ScrollView{
                LazyVGrid(columns: itmes, spacing: 5) {
                    ForEach(igvm.igData, id: \.self) { post in
                        NavigationLink(value: post) {
                            Image(post.postImageMain)
                                .resizable()
                                .scaledToFill()
                                .frame(width: width, height: width)
                                .clipped()
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .navigationDestination(for: InstagramInformation.self) {post in
                ForEach(igvm.igData) { data in
                    if post == data {
                        IgPostView(igData: data)
                    }
                }
                    .navigationBarBackButtonHidden()
            }
            
        }
    }
}

struct PostGridView_Previews: PreviewProvider {
    static var previews: some View {
        PostGridView(igData: InstagramData.shared.igData.first!)
    }
}
