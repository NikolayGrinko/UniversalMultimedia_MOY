//  CartManager.swift
//  CollectionViewWaldberries
//
//  Created by Николай Гринько on 01.04.2025.
//

import Foundation

class CartManager {
    static let shared = CartManager()
    
    private(set) var cartItems: [Produc: Int] = [:] // [Product: Quantity]
    
    var totalItems: Int {
        return cartItems.values.reduce(0, +)
    }
    
    var totalPrice: Double {
        return cartItems.reduce(0) { $0 + ($1.key.price * Double($1.value)) }
    }
    
    func addToCart(_ product: Produc) {
        cartItems[product, default: 0] += 1
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
    }
    
    func removeFromCart(_ product: Produc) {
        guard let quantity = cartItems[product], quantity > 0 else { return }
        if quantity == 1 {
            cartItems.removeValue(forKey: product)
        } else {
            cartItems[product] = quantity - 1
        }
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
    }
    
    func getQuantity(for product: Produc) -> Int {
        return cartItems[product] ?? 0
    }
    
    func clearCart() {
        cartItems.removeAll()
        NotificationCenter.default.post(name: .cartDidUpdate, object: nil)
    }
}

extension Notification.Name {
    static let cartDidUpdate = Notification.Name("cartDidUpdate")
}
