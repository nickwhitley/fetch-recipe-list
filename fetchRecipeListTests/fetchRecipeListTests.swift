import Testing
@testable import fetchRecipeList

@Suite struct FetchTests {
    let networkService: NetworkService
    let recipeService: RecipeService
    
    init() {
        networkService = NetworkService()
        recipeService = RecipeService(networkService: networkService)
    }
    
    @Test func fetchRecipesSuccess() async {
        do {
            let recipes = try await recipeService.fetchRecipes(recipeUrl: .validRecipes)
            #expect(recipes.count > 0)
        } catch {
            print(error)
        }
    }
    
    @Test func fetchRecipesFailMalformedResponse() async {
        async #expect(throws: NetworkServiceError.responseMalformed) {
            try await recipeService.fetchRecipes(recipeUrl: .malformedRecipes)
        }
    }
    
    @Test func fetchRecipesFailEmptyResponse() async {
        async #expect(throws: NetworkServiceError.responseEmpty) {
            try await recipeService.fetchRecipes(recipeUrl: .emptyRecipes)
        }
    }
    
    @Test func networkRequestFailInvalidUrl() async {
        async #expect(throws: NetworkServiceError.invalidURL) {
            let recipe: RecipeList = try await networkService.sendRequest(url: "errorUrl")
        }
    }
}
