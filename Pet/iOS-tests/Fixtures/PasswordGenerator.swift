import Foundation

struct PasswordGenerator {
    static func randomPassword() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let length = Int.random(in: 7...20)
        let password = String((0..<length).compactMap { _ in chars.randomElement() })
        assert(password.count >= 7 && password.count <= 20, "Password length is out of bounds: \(password.count)")
        print("[PasswordGenerator] Generated password: \(password) (length: \(password.count))")
        return password
    }
} 
