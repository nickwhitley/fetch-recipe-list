import Foundation

struct RecipeList: Codable {
    let recipes: [Recipe]
}

struct Recipe: Codable, Identifiable {
    let id: UUID
    let cuisine: String
    let name: String
    let largeImageUrl: URL?
    let smallImageUrl: URL?
    let sourceUrl: URL?
    let youtubeUrl: URL?
    
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
