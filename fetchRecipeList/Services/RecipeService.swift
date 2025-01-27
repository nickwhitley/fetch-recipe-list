import Foundation

class RecipeService {
    private let session: URLSession = .shared
    private let recipeURL = URLs.recipes
    private let decoder = JSONDecoder()
    
    func fetchRecipes() async -> [Recipe] {
        do {
            let (data, _) = try await session.data(from: recipeURL)
            let response = try decoder.decode(RecipeList.self, from: data)
            return response.recipes
        } catch {
            return []
        }
    }
}

