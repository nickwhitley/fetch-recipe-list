import Foundation
import SwiftUI

struct RecipeRowView: View {
    var recipe: Recipe
    var body: some View {
        HStack {
            if let imageUrl = recipe.smallImageUrl {
                AsyncImage(url: imageUrl) { phase in
                    switch phase {
                    case .empty:
                        ImageLoadingView()
                    case .success(let image):
                        ImageView(image)
                    case .failure:
                        Rectangle()
                    @unknown default:
                        Rectangle()
                    }}
                .frame(width: 80, height: 80)
            }
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .bold()
                Text(recipe.cuisine)
                Text("Youtube")
                    .underline()
                Text("Recipe Source")
                    .underline()
            }
        }
    }
    
    func ImageLoadingView() -> some View {
        Color.gray
            .opacity(0.2)
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shimmer(when: true)
    }
    
    func ImageView(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
