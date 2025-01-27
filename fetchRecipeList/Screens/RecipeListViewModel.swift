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
        recipes = await recipeService.fetchRecipes()
    }
}
