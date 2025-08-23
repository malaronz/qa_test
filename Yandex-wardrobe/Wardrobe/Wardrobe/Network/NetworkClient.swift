import Foundation

final class NetworkClient {
    private let session: URLSession
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder
    private let token: String

    init(token: String = Constants.token, session: URLSession = .shared) {
        self.token = token
        self.session = session
        self.jsonEncoder = JSONEncoder()
        self.jsonDecoder = JSONDecoder()
    }

    func request<RequestBody: Encodable, ResponseBody: Decodable>(
        url: URL,
        method: HttpMethod = .post,
        requestBody: RequestBody,
        responseType: ResponseBody.Type
    ) async throws -> ResponseBody {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("\(token)", forHTTPHeaderField: "X-Ya-User-Ticket")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            request.httpBody = try await encode(requestBody)
        } catch {
            throw NetworkError.serializationError(error)
        }

        let (data, response) = try await session.data(for: request)
        try validateResponse(response, data: data)

        do {
            return try await decode(data, to: ResponseBody.self)
        } catch {
            throw NetworkError.deserializationError(error)
        }
    }

    func request<ResponseBody: Decodable>(
        url: URL,
        method: HttpMethod = .get,
        responseType: ResponseBody.Type
    ) async throws -> ResponseBody {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("\(token)", forHTTPHeaderField: "X-Ya-User-Ticket")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await session.data(for: request)
        try validateResponse(response, data: data)

        do {
            return try await decode(data, to: ResponseBody.self)
        } catch {
            throw NetworkError.deserializationError(error)
        }
    }

    func request(
        url: URL,
        method: HttpMethod = .delete
    ) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")

        let (data, response) = try await session.data(for: request)
        try validateResponse(response, data: data)
    }

    private func validateResponse(_ response: URLResponse, data: Data) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.httpError(statusCode: httpResponse.statusCode, data: data)
        }
    }

    private func encode<T: Encodable>(_ body: T) async throws -> Data {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().async {
                do {
                    let data = try self.jsonEncoder.encode(body)
                    continuation.resume(returning: data)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    private func decode<T: Decodable>(_ data: Data, to type: T.Type) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global().async {
                do {
                    let decoded = try self.jsonDecoder.decode(T.self, from: data)
                    continuation.resume(returning: decoded)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
