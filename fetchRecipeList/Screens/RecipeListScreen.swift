import SwiftUI

struct RecipeListScreen: View {
    @Environment(RecipeListViewModel.self) var viewModel
    
    var body: some View {
        VStack {
            Text("Recipes")
                .font(.title)
            List {
                ForEach(viewModel.recipes, id: \.id) { recipe in
                    RecipeRowView(recipe: recipe)
                }
            }
        }
        .task {
            await viewModel.fetchRecipes()
        }
        .listStyle(.plain)
        .navigationTitle("Recipes")
    }
}
