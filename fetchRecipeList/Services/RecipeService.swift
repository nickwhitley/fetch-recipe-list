import Foundation

class RecipeService: RecipeServiceProtocol {
    private let logger = BasicLogger<RecipeService>()
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    func fetchRecipes(recipeUrl: RecipeUrl) async throws -> [Recipe] {
        logger.info("Fetching recipes")
        do {
            let recipeData: RecipeList = try await networkService.sendRequest(url: recipeUrl.rawValue)
            let recipes = recipeData.toRecipeList()
            logger.info("Fetched \(recipes.count) recipes")
            return recipes
        } catch {
            logger.error(error.localizedDescription)
            throw error
        }
    }
}


