//
//  OrderView.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/14.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

struct OrderView: View {
    
    @StateObject var mvm = MeunViewModel()
    @State var drinks: Drinks
    
    @Environment(\.dismiss) var dismiss         //回去上一個頁面
    
    let lightThemeColor = Color("themeColorNapTea")
    let darkThemeColor = Color("NapTeaDark")
    let width = UIScreen.main.bounds.width
    
    
    @State var selectedBabo = false
    @State var selectedJelly = false
    @State var selectedTaro = false
    @State var selectedTofu = false
    
    @State var selectedSize = ""
    @State var selectedIce = ""
    @State var selectedSugar = ""
    
    @State var drinkAmount = 1
    @State var drinkPrice = 0
    @State var ovSize = ""
    @State var ovIce = ""
    @State var ovSugar = ""
    @State var ovExtra = Array<String>()
    let onlyMedium = true
    
    
    @State private var alertTitle = ""
    @State var showAlert: Bool = false


    var body: some View {
        
        ZStack {
            VStack {
                ScrollView{
                    ZStack {
                        imagedrink
                        
                        exitButton
                    }
                    
                    VStack(alignment: .leading) {
                        Text(drinks.name)
                            .foregroundColor(darkThemeColor)
                            .font(.title)

                        Text(drinks.englishName)
                            .foregroundColor(.black)
                            .font(.title3)
                        
                        lineDivider
                        
                        drinkSize
                        
                        lineDivider
                                               
                        iceLevel
                        
                        lineDivider
                        
                        sugarlevel
                                                
                        lineDivider
                        
                        extraToppings
                        
                    }
                    .padding(.horizontal,20)
                }
                
                bottomView
                
            }

        }
        .ignoresSafeArea()
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(drinks: Drinks(name: "棉被厚奶蓋", englishName: "Signature Black Tea with Milk cap", category: "棉被厚奶蓋", mediumPrice: 60, largePrice: 75, recommend: true, image: "https://i.ibb.co/qgXzMTC/IMG-6940.jpg"))
    }
}

extension OrderView {
    
    private var imagedrink: some View {
        ZStack {
            AsyncImage(url: URL(string: drinks.image)) {photo in
                if let image = photo.image {
                    image
                        .resizable()
                } else {
                    Image("logo")
                        .resizable()
                }
            }
            .scaledToFit()
        }
    }
    
    private var exitButton: some View {
        HStack{
            VStack {
                Button{
                    dismiss()               //回去上一個頁面
                } label:{
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .rotationEffect(Angle(degrees: 45))
                        
                }
                Spacer()
            }
            Spacer()
        }
        .padding(30)
    }
    
    
    private var lineDivider: some View {                //分割線
        Path { (path) in
            path.move(to: CGPoint(x: -20, y: 0))
            path.addLine(to: CGPoint(x: width, y: 0))
        }
        .stroke(Color("backGroundColorNapTea"), lineWidth: 10)
    }
    
    private var drinkSize: some View {
        ZStack {
            if drinks.largePrice == 0 {
                VStack(alignment: .leading) {
                    Text("尺寸 Size")
                        .foregroundColor(.black)
                        .font(.title)

                        HStack {
                            Text("中杯 Medium 480ml")
                                .foregroundColor(darkThemeColor)
                                .font(.title3)
                            
                            Spacer()
                            
                            Circle()
                                .fill(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)).opacity(0.8))
                                .frame(width: 20, height: 20)
                        }
                    }
            } else {
                sizeRadioButton(selectedSize: self.$selectedSize)
                    .onChange(of: selectedSize) { sizePrice in
                        
                        if selectedSize == "中杯 Medium 480ml" {
                            drinkPrice = drinks.mediumPrice*drinkAmount
                            ovSize = "中杯"
                            
                            if selectedBabo == true {
                                drinkPrice = drinkPrice + (drinkAmount*5)
                            }
                            
                            if selectedJelly == true {
                                drinkPrice = drinkPrice + (drinkAmount*10)
                            }

                            if selectedTaro == true {
                                drinkPrice = drinkPrice + (drinkAmount*15)
                            }

                            if selectedTofu == true {
                                drinkPrice = drinkPrice + (drinkAmount*20)
                            }

                        } else {
                            drinkPrice = drinks.largePrice*drinkAmount
                            ovSize = "大杯"
                            
                            if selectedBabo == true {
                                drinkPrice = drinkPrice + (drinkAmount*5)
                            }
                            
                            if selectedJelly == true {
                                drinkPrice = drinkPrice + (drinkAmount*10)
                            }

                            if selectedTaro == true {
                                drinkPrice = drinkPrice + (drinkAmount*15)
                            }

                            if selectedTofu == true {
                                drinkPrice = drinkPrice + (drinkAmount*20)
                            }
                        }
                    }
            }
        }
    }
    
    private var iceLevel: some View {
        
        ZStack{
            if drinks.category == "暖暖喝熱飲" {
                
                VStack(alignment: .leading) {
                    Text("冰量 Ice level")
                        .foregroundColor(.black)
                        .font(.title)
                    
                    HStack {
                        Text("熱飲 Hot")
                            .foregroundColor(darkThemeColor)
                            .font(.title3)
                        
                        Spacer()
                        
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)).opacity(0.8))
                            .frame(width: 20, height: 20)
                    }
                }
            } else {
                iceRadioButton(selectedIce: self.$selectedIce)
                    .onChange(of: selectedIce) {ice in
                        
                        if drinks.largePrice == 0 {
                            ovIce = "中杯"
                            drinkPrice = drinks.mediumPrice*drinkAmount
                            
                            if selectedBabo == true{
                                drinkPrice = drinkPrice + (drinkAmount*5)
                            }
                            if selectedJelly == true{
                                drinkPrice = drinkPrice + (drinkAmount*10)
                            }
                            if selectedTaro == true{
                                drinkPrice = drinkPrice + (drinkAmount*15)
                            }
                            if selectedTofu == true{
                                drinkPrice = drinkPrice + (drinkAmount*20)
                            }
                        }
                        
                        if ice == "正常冰 Regular ice"{
                            ovIce = "正常冰"
                        } else if ice == "少冰 Less ice" {
                            ovIce = "少冰"
                        } else if ice == "微冰 Light ice" {
                            ovIce = "微冰"
                        } else if ice == "去冰 ice free" {
                            ovIce = "去冰"
                        }
                    }
            }
        }

    }
    
    private var sugarlevel: some View {
        ZStack {
            sugarRadioButton(selectedSugar: self.$selectedSugar)
                .onChange(of: selectedSugar) {sugar in
                    
                    if drinks.largePrice == 0 {
                        ovSize = "中杯"
                        drinkPrice = drinks.mediumPrice*drinkAmount
                        
                        if selectedBabo == true{
                            drinkPrice = drinkPrice + (drinkAmount*5)
                        }
                        if selectedJelly == true{
                            drinkPrice = drinkPrice + (drinkAmount*10)
                        }
                        if selectedTaro == true{
                            drinkPrice = drinkPrice + (drinkAmount*15)
                        }
                        if selectedTofu == true{
                            drinkPrice = drinkPrice + (drinkAmount*20)
                        }
                            }
                    
                    if drinks.category == "暖暖喝熱飲"{
                        ovIce = "熱"
                    }
                    
                    if sugar == "全糖 full sugar"{
                        ovSugar = "全糖"
                    } else if sugar == "少糖 less sugar" {
                        ovSugar = "少糖"
                    } else if sugar == "半糖 half sugar" {
                        ovSugar = "半糖"
                    } else if sugar == "微糖 light sugar" {
                        ovSugar = "微糖"
                    } else if sugar == "一分糖 10% sugar" {
                        ovSugar = "一分糖"
                    } else if sugar == "無糖 sugar free" {
                        ovSugar = "無糖"
                    }
                }
        }
    }
    
    private var extraToppings: some View {
        
        VStack(alignment: .leading) {
            
            Text("加料 Extra Toppings")
                .foregroundColor(.black)
                .font(.title)
            
                Button {
                    
                    if selectedBabo == false {
                        selectedBabo = true
                        drinkPrice = drinkPrice + (drinkAmount*5)
                        ovExtra.append("+珍珠")
                    } else {
                        selectedBabo = false
                        drinkPrice = drinkPrice - (drinkAmount*5)
                        if let indexToRemove = ovExtra.firstIndex(of: "+珍珠") {
                            ovExtra.remove(at: indexToRemove)
                        }
                    }
                    
                } label: {
                    HStack {
                        
                        Text("珍珠 Babo  +$5")
                            .foregroundColor(darkThemeColor)
                            .font(.title3)
                        
                        Spacer()
                        
                        if selectedBabo == true {
                            
                            Circle()
                                .fill(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)).opacity(0.8))
                                .frame(width: 20, height: 20)
                        } else {
                            Circle()
                                .stroke(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)), lineWidth: 4)
                                .frame(width: 20, height: 20)
                    }
                }
            }
            
            
            Button {
                
                if selectedJelly == false {
                    selectedJelly = true
                    drinkPrice = drinkPrice + (drinkAmount*10)
                    ovExtra.append("+仙草")
                } else {
                    selectedJelly = false
                    drinkPrice = drinkPrice - (drinkAmount*10)
                    if let indexToRemove = ovExtra.firstIndex(of: "+仙草") {
                        ovExtra.remove(at: indexToRemove)
                    }
                }
                
            } label: {
                HStack {
                    
                    Text("嫩仙草 Grass Jelly  +$10")
                        .foregroundColor(darkThemeColor)
                        .font(.title3)
                    
                    Spacer()
                    
                    if selectedJelly == true {
                        
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)).opacity(0.8))
                            .frame(width: 20, height: 20)
                    } else {
                        Circle()
                            .stroke(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)), lineWidth: 4)
                            .frame(width: 20, height: 20)
                    }
                }
            }
            
            
            Button {
                
                if selectedTaro == false {
                    selectedTaro = true
                    drinkPrice = drinkPrice + (drinkAmount*15)
                    ovExtra.append("+啵啵")
                } else {
                    selectedTaro = false
                    drinkPrice = drinkPrice - (drinkAmount*15)
                    if let indexToRemove = ovExtra.firstIndex(of: "+啵啵") {
                        ovExtra.remove(at: indexToRemove)
                    }

                }
                
            } label: {
                HStack {
                    
                    Text("啵啵 Taro Balls  +$15")
                        .foregroundColor(darkThemeColor)
                        .font(.title3)
                    
                    Spacer()
                    
                    if selectedTaro == true {
                        
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)).opacity(0.8))
                            .frame(width: 20, height: 20)
                    } else {
                        Circle()
                            .stroke(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)), lineWidth: 4)
                            .frame(width: 20, height: 20)
                }
            }
        }
            
            Button {
                
                if selectedTofu == false {
                    selectedTofu = true
                    drinkPrice = drinkPrice + (drinkAmount*20)
                    ovExtra.append("+枕頭")
                } else {
                    selectedTofu = false
                    drinkPrice = drinkPrice - (drinkAmount*20)
                    if let indexToRemove = ovExtra.firstIndex(of: "+枕頭") {
                        ovExtra.remove(at: indexToRemove)
                    }

                }
                
            } label: {
                HStack {
                    
                    Text("豆腐枕頭 Soymilk Tofu  +$20")
                        .foregroundColor(darkThemeColor)
                        .font(.title3)
                    
                    Spacer()
                    
                    if selectedTofu == true {
                        
                        Circle()
                            .fill(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)).opacity(0.8))
                            .frame(width: 20, height: 20)
                    } else {
                        Circle()
                            .stroke(Color(#colorLiteral(red: 0.4732829332, green: 0.3226000667, blue: 0.2053641677, alpha: 1)), lineWidth: 4)
                            .frame(width: 20, height: 20)
                    }
                }
                
            }
        }
    }
    
    private var amountButton: some View {
        HStack {
            
            Button {
                if drinkAmount <= 1 {
                    
                } else {
                    drinkAmount = drinkAmount - 1
                    if drinkAmount <= 2 {
                        drinkPrice = drinkPrice/2
                    } else {
                        drinkPrice = drinkPrice - (drinkPrice/(drinkAmount-1))      //to fix
                    }
                }
            } label: {
                Text("-")
                    .foregroundColor(darkThemeColor)
                    .font(.title2)
                }
            
            Text("\(drinkAmount)")
                .foregroundColor(darkThemeColor)
                .font(.title2)
                .padding(.horizontal,10)
            
            Button {
                drinkAmount = drinkAmount + 1
                if drinkAmount <= 2 {
                    drinkPrice = drinkPrice*2
                } else {
                    drinkPrice = drinkPrice + (drinkPrice/(drinkAmount-1))
                }

            } label: {
                Text("+")
                    .foregroundColor(darkThemeColor)
                    .font(.title2)
            }
        }
        .frame(width: 90, height: 30)
        .background(lightThemeColor)
        .cornerRadius(40)
    }
    
    
    private var bottomView: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack{
                    
                    Text("$\(drinkPrice)")
                        .foregroundColor(.white)
                        .font(.title)
                        .padding(.trailing)
                        .padding(.leading)
                    
                    //amountButton
                    
                    Spacer()
                }
                if ovSize != "" && ovIce != "" && ovSugar != ""{
                    Text("\(ovSize)/\(ovIce)/\(ovSugar)")
                        .foregroundColor(lightThemeColor)
                        .padding(.leading)
                }
            }
            
            Button {
                
                if ovSize.isEmpty {
                    self.showAlert = true
                    self.alertTitle = "請選擇尺寸"
                } else if ovIce.isEmpty {
                    self.showAlert = true
                    self.alertTitle = "請選擇冰量"
                } else if ovSugar.isEmpty {
                    self.showAlert = true
                    self.alertTitle = "請選擇甜度"
                } else {
                    mvm.userName()
                    createOrder()
                    }
                
            } label: {
                HStack{
                    Image(systemName: "cart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                        .foregroundColor(darkThemeColor)
                    
                    Text("加入購物車")
                        .foregroundColor(darkThemeColor)
                }
            }
            .frame(width: 150, height: 40)
            .background(lightThemeColor)
            .cornerRadius(5)
            .padding(.trailing)
            .alert(alertTitle, isPresented: $showAlert) {
                if alertTitle == "訂購成功"{
                    Button("OK"){
                        dismiss()
                    }
                } else {
                    Button("OK") {}
                }
            }
        }
        .padding(.bottom)
        .frame(width: width, height: 100)
        .background(darkThemeColor)
    }
    
    
    func createOrder() {                    //新增訂單到firsbase
        let db = Firestore.firestore()
        
        let order = CartOrder(orderName: mvm.lgName, drink: drinks.name, image: drinks.image, size: ovSize, sugar: ovSugar, ice: ovIce, toppings: ovExtra, amount: drinkAmount, price: drinkPrice)
        do {
            let documentReference = try db.collection("cart").addDocument(from: order)
            print(documentReference.documentID)
            showAlert = true
            alertTitle = "訂購成功"
        } catch {
            print(error)
        }
    }
    
}
