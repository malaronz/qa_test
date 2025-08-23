import Foundation

struct PhotoFittingAlert: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let message: String
    let allowsOpenSettings: Bool
}
