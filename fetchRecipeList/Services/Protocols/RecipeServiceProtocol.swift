

protocol RecipeServiceProtocol {
    func fetchRecipes(recipeUrl: RecipeUrl) async throws -> [Recipe]
}

