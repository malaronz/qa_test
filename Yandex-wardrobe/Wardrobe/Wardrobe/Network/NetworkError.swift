import Foundation

enum NetworkError: LocalizedError {
    case invalidResponse
    case httpError(statusCode: Int, data: Data)
    case serializationError(Error)
    case deserializationError(Error)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Некорректный ответ от сервера"
        case .httpError(let statusCode, _):
            switch statusCode {
            case 400...499:
                return "Что-то пошло не так, \(statusCode)"
            case 500...599:
                return "Ошибка сервера"
            default:
                return "Ошибка сети"
            }
        case .serializationError:
            return "Ошибка при отправке данных на сервер"
        case .deserializationError:
            return "Ошибка при обработке данных от сервера"
        }
    }
}

enum ServiceError: Error {
    case invalidRequest
}
