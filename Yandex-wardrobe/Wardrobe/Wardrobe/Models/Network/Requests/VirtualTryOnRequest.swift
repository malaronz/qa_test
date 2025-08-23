import Foundation

struct VirtualTryOnRequest: Codable {
    let person: String // base64 encoded image
    let top: String
    let bottom: String
    let shoes: String
}
