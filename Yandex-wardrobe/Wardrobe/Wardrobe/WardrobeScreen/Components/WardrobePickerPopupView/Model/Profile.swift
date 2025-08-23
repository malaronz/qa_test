import Foundation

struct Profile: Identifiable, Equatable {
    let id: UUID
    var name: String
    var emoji: String
}
