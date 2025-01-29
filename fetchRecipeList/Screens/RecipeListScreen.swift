import SwiftUI

struct RecipeListScreen: View {
    @Environment(RecipeListViewModel.self) var viewModel
    
    var body: some View {
        TitleBar()
        ScrollView {
            if viewModel.recipes.isEmpty {
                Text("No recipes found.")
            } else {
                ForEach(viewModel.recipes, id: \.id) { recipe in
                    RecipeRowView(recipe: recipe)
                    Divider()
                }
            }
        }
        .listStyle(.plain)
        .task {
            await viewModel.fetchRecipes()
        }
        .refreshable {
            await viewModel.fetchRecipes()
        }
    #warning("Handle Accessibility")
    }
    
    func TitleBar() -> some View {
        HStack {
            Text("Recipes")
                .font(.title)
                .bold()
                .frame(alignment: .center)
                .padding(.horizontal)
            Spacer()
        }
    }
}

#Preview {
    RecipeListScreen()
        .addEnvironments()
}
