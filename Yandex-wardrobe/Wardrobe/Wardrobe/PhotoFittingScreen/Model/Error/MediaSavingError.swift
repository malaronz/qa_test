import Foundation

enum MediaSavingError: Error, LocalizedError {
    case denied
    case failed

    var errorDescription: String? {
        switch self {
        case .denied:
            return "Нет доступа к сохранению в медиатеку"
        case .failed:
            return "Не удалось сохранить изображение"
        }
    }
}
