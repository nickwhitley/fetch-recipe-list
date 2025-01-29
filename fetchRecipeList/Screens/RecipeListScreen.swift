import SwiftUI

struct RecipeListScreen: View {
    @Environment(RecipeListViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var vmBinding = viewModel
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
            await viewModel.fetchRecipes(recipeUrl: .malformedRecipes)
        }
        .refreshable {
            await viewModel.fetchRecipes()
        }
        .alert(viewModel.alertMessage, isPresented: $vmBinding.alertPresented) {
            Button("Try again", role: .cancel) {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
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
