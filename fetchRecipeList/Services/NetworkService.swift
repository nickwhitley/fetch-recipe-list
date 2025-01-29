import Foundation

class NetworkService: NetworkServiceProtocol {
    private let logger = BasicLogger<NetworkService>()
    private let session: URLSession = .shared
    private let decoder = JSONDecoder()
    
    func sendRequest<T: Decodable>(url: String) async throws -> T {
        guard let requestUrl = URL(string: url) else {
            throw NetworkServiceError.invalidURL
        }
        
        let (data, respone) = try await session.data(from: requestUrl)
        
        guard let httpResponse = respone as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkServiceError.requestFailed
        }
        
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkServiceError.responseMalformed
        }
    }
}

enum NetworkServiceError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case responseMalformed
    case responseEmpty
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("The provided URL is invalid.", comment: "Invalid URL Error")
        case .requestFailed:
            return NSLocalizedString("The network request failed. Please check your internet connection and try again.", comment: "Request Failed Error")
        case .responseMalformed:
            return NSLocalizedString("The response from the server was not in the expected format.", comment: "Malformed Response Error")
        case .responseEmpty:
            return NSLocalizedString("The server response was empty. Please try again later.", comment: "Empty Response Error")
        }
    }
}
