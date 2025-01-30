import Observation

@Observable
@MainActor
class RecipeListViewModel {
    private let recipeService: RecipeServiceProtocol
    var recipes: [Recipe] = []
    var filteredRecipes: [Recipe] = []
    var alertPresented: Bool = false
    var alertMessage: String = ""
    var isLoading: Bool = true
    var largeImageViewRecipe: Recipe?
    var nameSort: RecipeSort = .descending
    var cuisineSort: RecipeSort = .none
    var searchText: String = "" {
        didSet {
            applySearchFilter()
        }
    }
    
    init(recipeService: RecipeServiceProtocol){
        self.recipeService = recipeService
    }
    
    func fetchRecipes(recipeUrl: RecipeUrl = .validRecipes) async {
        isLoading = true
        defer { isLoading = false }
        do {
            recipes = try await recipeService.fetchRecipes(recipeUrl: recipeUrl)
            recipes.sort {
                $0.name < $1.name
            }
            filteredRecipes = recipes
        } catch {
            alertPresented = true
            alertMessage = "Could not fetch recipes at this time, please try again later."
        }
    }
    
    func sortRecipesByCuisine() {
        nameSort = .none
        switch cuisineSort {
        case .descending:
            // sets to descend from A to Z by cuisine
            cuisineSort = .ascending
            recipes.sort {
                $0.cuisine > $1.cuisine
            }
        default:
            // sets to ascend from Z to A by cuisine
            cuisineSort = .descending
            recipes.sort {
                $0.cuisine < $1.cuisine
            }
        }
        applySearchFilter()
    }
    
    func sortRecipesByName() {
        cuisineSort = .none
        switch nameSort {
        case .descending:
            // sets to descend from A to Z by name
            nameSort = .ascending
            recipes.sort {
                $0.name > $1.name
            }
        default:
            // sets to ascend from Z to A by name
            nameSort = .descending
            recipes.sort {
                $0.name < $1.name
            }
        }
        applySearchFilter()
    }
    
    func applySearchFilter() {
        if searchText.isEmpty {
            filteredRecipes = recipes
        } else {
            filteredRecipes = recipes.filter { recipe in
                recipe.name.localizedCaseInsensitiveContains(searchText) ||
                recipe.cuisine.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

enum RecipeSort {
    case none
    case descending
    case ascending
}
