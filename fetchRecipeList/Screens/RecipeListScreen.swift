import SwiftUI

struct RecipeListScreen: View {
    @Environment(RecipeListViewModel.self) var viewModel
    
    var body: some View {
        ScrollView {
            if viewModel.recipes.isEmpty {
                Text("No recipes found.")
            } else {
                ForEach(viewModel.recipes, id: \.id) { recipe in
                    RecipeRowView(recipe: recipe)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Recipes")
        .task {
            await viewModel.fetchRecipes()
        }
        .refreshable {
            await viewModel.fetchRecipes()
        }
    #warning("Handle Accessibility")
    }
}

#Preview {
    RecipeListScreen()
        .addEnvironments()
}
