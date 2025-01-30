import Foundation
import SwiftUI

struct RecipeRowView: View {
    @Environment(\.dynamicTypeSize) var dynamicSize
    @Environment(RecipeListViewModel.self) var viewModel
    var recipe: Recipe
    
    var body: some View {
        if dynamicSize < .accessibility1 {
            HorizontalView()
                .padding(.horizontal)
        } else {
            VerticalView()
                .padding([.horizontal, .top])
        }
    }
    
    func HorizontalView() -> some View {
        HStack {
            if let imageUrl = recipe.smallImageUrl {
                RecipeImageView(imageUrl: imageUrl)
                    .frame(width: 80, height: 80)
                    .onTapGesture {
                        viewModel.largeImageViewRecipe = recipe
                    }
            }
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .bold()
                    .lineLimit(2)
                Text("\(recipe.cuisine) cuisine")
                HStack {
                    if let youtubeUrl = recipe.youtubeUrl {
                        Text("Youtube")
                            .underline()
                            .onTapGesture {
                                UIApplication.shared.open(youtubeUrl)
                            }
                    }
                    if let recipeSourceUrl = recipe.sourceUrl {
                        Text("Recipe Source")
                            .underline()
                            .onTapGesture {
                                UIApplication.shared.open(recipeSourceUrl)
                            }
                    }
                }
            }
            Spacer()
        }
    }
    
    func VerticalView() -> some View {
        VStack {
            if let imageUrl = recipe.largeImageUrl {
                RecipeImageView(imageUrl: imageUrl)
                    .onTapGesture {
                        viewModel.largeImageViewRecipe = recipe
                    }
                    .frame(width: 200, height: 200)
            }
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .bold()
                    .lineLimit(2)
                    .minimumScaleFactor(0.6)
                Text(recipe.cuisine)
                    .lineLimit(2)
                if let youtubeUrl = recipe.youtubeUrl {
                    Text("Youtube")
                        .underline()
                        .onTapGesture {
                            UIApplication.shared.open(youtubeUrl)
                        }
                }
                if let recipeSourceUrl = recipe.sourceUrl {
                    Text("Recipe Source")
                        .underline()
                        .onTapGesture {
                            UIApplication.shared.open(recipeSourceUrl)
                        }
                }
            }
        }
    }
}

#Preview {
    let recipe = Recipe(id: UUID(),
                        cuisine: "Malaysian",
                        name: "Polskie NaleÅ›niki (Polish Pancakes)",
                        largeImageUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
                        smallImageUrl: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
                        sourceUrl: URL(string: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ"),
                        youtubeUrl: URL(string:"https://www.youtube.com/watch?v=6R8ffRRJcrg"))
    RecipeRowView(recipe: recipe)
        .addEnvironments()
}
