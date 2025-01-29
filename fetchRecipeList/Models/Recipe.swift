import Foundation
import SwiftData

struct RecipeList: Codable {
    let recipes: [RecipeDTO]
    
    func toRecipeList() -> [Recipe] {
        return recipes.map { $0.toDataModel() }
    }
}

struct RecipeDTO: Codable, Identifiable {
    let id: UUID
    let cuisine: String
    let name: String
    let largeImageUrl: URL?
    let smallImageUrl: URL?
    let sourceUrl: URL?
    let youtubeUrl: URL?
    
    func toDataModel() -> Recipe {
        return Recipe(id: id,
                           cuisine: cuisine,
                           name: name,
                           largeImageUrl: largeImageUrl,
                           smallImageUrl: smallImageUrl,
                           sourceUrl: sourceUrl,
                           youtubeUrl: youtubeUrl)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case cuisine
        case name
        case largeImageUrl = "photo_url_large"
        case smallImageUrl = "photo_url_small"
        case sourceUrl = "source_url"
        case youtubeUrl = "youtube_url"
    }
}

@Model
class Recipe {
    var id: UUID
    var cuisine: String
    var name: String
    var largeImageUrl: URL?
    var smallImageUrl: URL?
    var sourceUrl: URL?
    var youtubeUrl: URL?
    
    init(id: UUID, cuisine: String, name: String, largeImageUrl: URL?, smallImageUrl: URL?, sourceUrl: URL?, youtubeUrl: URL?) {
        self.id = id
        self.cuisine = cuisine
        self.name = name
        self.largeImageUrl = largeImageUrl
        self.smallImageUrl = smallImageUrl
        self.sourceUrl = sourceUrl
        self.youtubeUrl = youtubeUrl
    }
}

