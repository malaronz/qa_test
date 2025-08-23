import Foundation

struct User {
    let id: Int
    let name: String
    let liked: [Item]
    let bought: [Item]
    let cart: [Item]
    let wardrobes: [Wardrobe]
}
