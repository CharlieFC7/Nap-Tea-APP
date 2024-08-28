//
//  SignUpView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/7/30.
//

import SwiftUI
import FirebaseAuth
import FirebaseCore


struct SignUpView: View {
    
    let backGroundColor = Color("themeColorNapTea")
    let themeColor = Color("NapTeaDark")
    let width = UIScreen.main.bounds.width
    
    @Environment(\.dismiss) var dismiss         //回去上一個頁面
    
    @State private var spAccount = ""
    @State private var spPassword = ""
    @State private var spName = ""
    
    @State var uppercaseCount = 0
    @State var lowercaseCount = 0
    @State var digiCount = 0
    
    @State private var showAlert = false
    @State private var alertTitle = ""
    
    var body: some View {
        
        ZStack{
            backGroundColor.ignoresSafeArea()
                
            VStack{
                    
                Spacer()
                    
                header
                    
                Spacer()
                    
                register
                    
                Spacer()
            }
            VStack{
                returnBack
                
                Spacer()
            }
        }
        .ignoresSafeArea(.container)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

extension SignUpView {
    
    private var returnBack: some View {
        
        HStack {
            Button{
                dismiss()               //回去上一個頁面
            } label:{
                Image(systemName: "arrowshape.turn.up.backward.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(Color("NapTeaDark"))
            }
            Spacer()
        }
        .padding(.vertical)
        .frame(width: width - 40, height: 75)
    }
    
    private var header: some View {
        
        VStack{
            
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 400)
                .padding()
            
            VStack(spacing: 5) {
                
                HStack{
                    
                    Text("使用者名稱")
                        .foregroundColor(themeColor)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .frame(width: width - 35)
                
                TextField("請輸入暱稱", text: $spName)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: width - 30)
            }
            
            VStack(spacing: 5) {
                
                HStack{
                    
                    Text("電子信箱")
                        .foregroundColor(themeColor)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .frame(width: width - 35)
                
                TextField("請輸入電子信箱", text: $spAccount)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: width - 30)
            }
           
            VStack(spacing: 5){
                HStack{
                    
                    Text("密碼")
                        .foregroundColor(themeColor)
                        .fontWeight(.bold)
                    
                    Spacer()
                }
                .frame(width: width - 35)
                
                SecureField("6~12個數字", text: $spPassword)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: width  - 30)
            }

        }
    }
    
    private var register: some View{
        
        Button {
            
            for character in spPassword {
                if character.isUppercase{
                    uppercaseCount += 1
                } else if character.isLowercase {
                    lowercaseCount += 1
                } else if character.isHexDigit {
                    digiCount += 1
                }
            }
            
            if !spAccount.isEmpty {
                
                if spName.count == 0 {
                    self.showAlert = true
                    self.alertTitle = "請輸入暱稱"
                } else if spPassword.count < 6 || spPassword.count > 12 {
                    self.showAlert = true
                    self.alertTitle = "密碼需要在6~12字"
                } else if uppercaseCount == 0 {
                    self.showAlert = true
                    self.alertTitle = "密碼至少要有一個大寫字母"
                } else if lowercaseCount == 0 {
                    self.showAlert = true
                    self.alertTitle = "密碼至少要有一個小寫字母"
                } else if digiCount == 0 {
                    self.showAlert = true
                    self.alertTitle = "密碼內要有數字"
                } else {
                    firebaseRegister()
                }
                
            } else {
                showAlert = true
                alertTitle = "欄位填寫不完整，請重新輸入"
            }
            
        } label: {
            Text(" 註冊 ")
                .frame(width: width - 100)
                .padding()
                .background(themeColor)
                .foregroundColor(.white)
                .font(.title2)
                
        }
        .alert(alertTitle, isPresented: $showAlert) {
            if alertTitle == "完成註冊"{
                Button("OK"){
                    dismiss()
                }
            } else {
                Button("OK") {}
            }
        }
    }
    
    
    func firebaseRegister() {
        Auth.auth().createUser(withEmail: spAccount, password: spPassword) { result, error in
            guard let user = result?.user, error == nil else {
                
                //註冊失敗
                alertTitle = "\(error!.localizedDescription)"
                
                return
            }
            
            //註冊成功
            let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = spName
            changeRequest?.commitChanges(completion: { error in
                
                //使用者名稱設定失敗
                guard error == nil else{
                    alertTitle = "\(error!.localizedDescription)"
                    return
                }
                
                //使用者名稱設定成功
                showAlert = true
                alertTitle = "完成註冊"
            })
        }
    }
    
}
