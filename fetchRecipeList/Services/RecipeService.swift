import Foundation

class RecipeService: RecipeServiceProtocol {
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache.shared
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession(configuration: configuration)
    }
    
    func fetchRecipes(recipeUrl: RecipeUrl) async throws -> [Recipe] {
        guard let url = recipeUrl.url else {
            throw RecipeServiceError.invalidURL
        }
        
        do {
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            let (data, respone) = try await session.data(for: request)
            
            guard let httpResponse = respone as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw RecipeServiceError.requestFailed
            }
            
            let recipeData = try decoder.decode(RecipeList.self, from: data)
            guard !recipeData.recipes.isEmpty else {
                throw RecipeServiceError.responseEmpty
            }
            
            return recipeData.recipes
        } catch let error as RecipeServiceError {
            if error == .responseMalformed || error == .requestFailed {
                throw error
            }
        } catch {
            print("Error fetching recipes: \(error)")
            throw error
        }
        return []
    }
}

enum RecipeServiceError: Error {
    case invalidURL
    case requestFailed
    case responseMalformed
    case responseEmpty
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided."
        case .requestFailed:
            return "Request failed."
        case .responseMalformed:
            return "Response was malformed."
        case .responseEmpty:
            return "Response was empty."
        }
    }
}
