import Foundation

class RecipeService: RecipeServiceProtocol {
    private let session: URLSession = .shared
    private let decoder = JSONDecoder()
    private let logger = BasicLogger<RecipeService>()
    
    func fetchRecipes(recipeUrl: RecipeUrl) async throws -> [Recipe] {
        logger.info("Fetching recipes")
        guard let url = recipeUrl.url else {
            throw RecipeServiceError.invalidURL
        }
        
        do {
            let (data, respone) = try await session.data(from: url)
            
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
