import Foundation

enum ImageProcessingError: Error, LocalizedError {
    case network(String)
    case imageConversionFailed
    case invalidResultURL
    case resultImageDownloadFailed
    case insufficientClothingItems
    case unknown

    var errorDescription: String? {
        switch self {
        case let .network(message):
            return message
        case .imageConversionFailed:
            return "Не удалось конвертировать изображение"
        case .invalidResultURL:
            return "Получен некорректный URL результата"
        case .resultImageDownloadFailed:
            return "Не удалось загрузить результат"
        case .insufficientClothingItems:
            return "Недостаточно элементов одежды для примерки"
        case .unknown:
            return "Неизвестная ошибка обработки изображения"
        }
    }
}
