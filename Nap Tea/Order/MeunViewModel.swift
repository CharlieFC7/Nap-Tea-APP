//
//  MeunViewModel.swift
//  Nap Tea
//
//  Created by Charlie on 2024/8/14.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class MeunViewModel: ObservableObject {
    
    @FirestoreQuery(collectionPath: "cart") var cartData: [CartOrder]
    
    @Published var totalPrice = 0                // 用來計算購物車中的訂單金額  to fix
    @Published var totalAmount = 0               // 用來計算購物車中的訂單金額   to fix
    
    @Published var orders = [CartOrder]()
    
    @Published var orderid = ""
    @Published var orderAmount = 1
    
    @Published var lgName = ""          //使用者名稱
    
    let db = Firestore.firestore()

    
    func modifyOrder() {                    //修改訂單數量
        let documentReference =
        db.collection("cart").document(orderid)
        documentReference.getDocument { document, error in
            
            guard let document,
                  document.exists,
                  var drink = try? document.data(as: CartOrder.self)
            else {
                return
            }
            drink.amount = self.orderAmount
            do {
                try documentReference.setData(from: drink)
            } catch {
                print(error)
            }
            
        }
    }
    
    
    func removeOrder() {
        let db = Firestore.firestore()
        let documentReference = db.collection("cart").document(orderid)
        documentReference.delete()
        }
        
    
    func userName() {               //找出Firebase 的使用者名稱
        if let user = Auth.auth().currentUser {
            lgName = user.displayName!
        }
    }
    
}
