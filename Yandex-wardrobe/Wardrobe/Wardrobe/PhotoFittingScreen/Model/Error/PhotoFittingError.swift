import Foundation

enum PhotoFittingError: LocalizedError, Equatable {
    case cameraDenied(String)
    case cameraUnavailable(String)
    case processing(String)
    case saving(String)
    case generic(String)

    var errorDescription: String? {
        switch self {
        case let .cameraDenied(message),
             let .cameraUnavailable(message),
             let .processing(message),
             let .saving(message),
             let .generic(message):
            return message
        }
    }
}
