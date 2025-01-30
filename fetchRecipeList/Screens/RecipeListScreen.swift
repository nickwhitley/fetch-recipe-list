import SwiftUI

struct RecipeListScreen: View {
    @Environment(RecipeListViewModel.self) var viewModel
    
    var body: some View {
        @Bindable var vmBinding = viewModel
        RecipeTitleBar()
        ScrollView {
            if viewModel.recipes.isEmpty {
                Text("No recipes found.")
            } else {
                ForEach(viewModel.filteredRecipes, id: \.id) { recipe in
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
        .alert(viewModel.alertMessage, isPresented: $vmBinding.alertPresented) {
            Button("Try again", role: .cancel) {
                Task {
                    await viewModel.fetchRecipes()
                }
            }
        }
        .overlay {
            if viewModel.isLoading {
                LoadingView()
            }
            if let recipe = viewModel.largeImageViewRecipe {
                LargeImageView(recipe: recipe)
                    .onTapGesture {
                        viewModel.largeImageViewRecipe = nil
                    }
            }
        }
    }
    
    
    
    func LargeImageView(recipe: Recipe) -> some View {
        Rectangle()
            .foregroundStyle(.ultraThinMaterial)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .overlay {
                VStack {
                    if let imageUrl = recipe.largeImageUrl {
                        RecipeImageView(imageUrl: imageUrl)
                        .frame(width: 350, height: 350)
                    }
                    Text(recipe.name)
                        .font(.title)
                        .bold()
                }
            }
    }
    
    func LoadingView() -> some View {
        Group {
            Rectangle()
                .foregroundStyle(.white)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(2.0, anchor: .center)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    }
                }
        }
    }
}

#Preview {
    RecipeListScreen()
        .addEnvironments()
}
