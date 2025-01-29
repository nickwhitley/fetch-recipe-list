import Foundation

protocol NetworkServiceProtocol {
    func sendRequest<T: Decodable>(url: String) async throws -> T
}
