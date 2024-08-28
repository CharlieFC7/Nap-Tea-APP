//
//  LoginView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/9.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore

struct LoginView: View {
    
    let width = UIScreen.main.bounds.width
    
    @State var account = ""
    @State var password = ""
    
    @State private var alertTitle = ""
    
    @State var loginYes: Bool = false
    
    let backGroundColor = Color("themeColorNapTea")
    let themeColor = Color("NapTeaDark")
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                backGroundColor.ignoresSafeArea()  // 背景底色
                
                VStack(spacing: 20) {
                    Spacer()
                    
                    header
                    
                    alertText
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        loginButton

                        Spacer()
                        
                        signupButton
                        
                        Spacer()
                    }
                    .padding(5)
                }
            }
            .ignoresSafeArea(.container)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            LoginView()
            

        }
    }
}

extension LoginView {
    
    private var header: some View {
        
        VStack{
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 400)
            TextField("請輸入信箱", text: $account)
                .textFieldStyle(.roundedBorder)
                .padding()
            SecureField("請輸入密碼", text: $password)
                .textFieldStyle(.roundedBorder)
                .padding()
        }
    }
    
    private var alertText: some View {
        
        ZStack{
            Text(alertTitle)
                .foregroundColor(.red)
                .frame(width: width - 20)
        }
        
    }
    
    private var loginButton: some View {
        
        Button {
                login()

        } label: {
            Text("登入")
                .foregroundColor(themeColor)
                .font(.title2)
                .padding()
                .border(themeColor, width: 4)
                .frame(width: 150, height: 100)
        }
        .fullScreenCover(isPresented: $loginYes){
            ContentView()
        }
    }
    
    private var signupButton: some View {
        
        NavigationLink {
            SignUpView()
                .navigationBarBackButtonHidden()                //將原廠設定的退回按鍵隱藏
        } label: {
            Text("註冊")
                .padding()
                .background(themeColor)
                .foregroundColor(.white)
                .font(.title2)
                .frame(width: 150, height: 100)
        }
    }
    
    
    func login() {                  //Firebase 登入功能
        
        Auth.auth().signIn(withEmail: account, password: password ) { result, error in
            guard error == nil else {
                
                //登入失敗
                alertTitle = "\(error!.localizedDescription)"
                
                return
            }
            
            //登入成功
            loginYes = true
            alertTitle = ""
        }
    }
    
}
