import Observation

@Observable
@MainActor
class RecipeListViewModel {
    private let recipeService: RecipeServiceProtocol
    var recipes: [Recipe] = []
    var alertPresented: Bool = false
    var alertMessage: String = ""
    
    init(recipeService: RecipeServiceProtocol){
        self.recipeService = recipeService
    }
    
    func fetchRecipes(recipeUrl: RecipeUrl = .malformedRecipes) async {
        do {
            recipes = try await recipeService.fetchRecipes(recipeUrl: recipeUrl)
        } catch {
            alertPresented = true
            alertMessage = "Could not fetch recipes at this time, please try again later."
        }
    }
}
