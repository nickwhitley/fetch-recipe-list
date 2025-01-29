import Foundation

class MockRecipeService: RecipeServiceProtocol {
    private let session: URLSession
    private let decoder = JSONDecoder()
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = URLCache.shared
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        session = URLSession(configuration: configuration)
    }
    
    func fetchRecipes(recipeUrl: RecipeUrl) async throws -> [Recipe] {
        switch recipeUrl {
        case .validRecipes:
            return try loadRecipes(from: "MockValidRecipes.json")
        case .malformedRecipes:
            return try loadRecipes(from: "MockMalformedRecipes.json")
        case .emptyRecipes:
            return try loadRecipes(from: "MockEmptyRecipes.json")
        }
    }
    
    private func loadRecipes(from filename: String) throws -> [Recipe] {
        guard let url = Bundle.main.url(forResource: filename, withExtension: nil) else {
            throw NetworkServiceError.invalidURL
        }
        
        let data = try Data(contentsOf: url)
        let recipeList = try decoder.decode(RecipeList.self, from: data).toRecipeList()
        return recipeList
    }
}
