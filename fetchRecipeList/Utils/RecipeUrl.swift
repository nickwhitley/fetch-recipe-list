import Foundation

enum RecipeUrl: String {
    case validRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    case emptyRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
    case malformedRecipes = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"
}
