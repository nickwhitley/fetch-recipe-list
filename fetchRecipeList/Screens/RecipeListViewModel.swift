import Observation

@Observable
@MainActor
class RecipeListViewModel {
    private let recipeService: RecipeServiceProtocol
    var recipes: [Recipe] = []
    
    init(recipeService: RecipeServiceProtocol){
        self.recipeService = recipeService
    }
    
    func fetchRecipes() async {
        do {
            recipes = try await recipeService.fetchRecipes(recipeUrl: .validRecipes)
        } catch {
            
        }
    }
}
