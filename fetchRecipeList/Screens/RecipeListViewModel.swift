import Observation

@Observable
@MainActor
class RecipeListViewModel {
    private let recipeService: RecipeService
    var recipes: [Recipe] = []
    
    init(recipeService: RecipeService){
        self.recipeService = recipeService
    }
    
    func fetchRecipes() async {
        do {
            recipes = try await recipeService.fetchRecipes(recipeUrl: .validRecipes)
        } catch {
            
        }
    }
}
