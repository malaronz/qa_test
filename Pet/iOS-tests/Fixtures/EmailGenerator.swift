import Foundation

struct EmailGenerator {
    static func randomEmail() -> String {
        let uuid = UUID().uuidString.prefix(8)
        return "test_\(uuid)@example.com"
    }
} 