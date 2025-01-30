import SwiftUI

struct RecipeImageView: View {
    var imageUrl: URL
    
    var body: some View {
        CachedAsyncImage(url: imageUrl) { phase in
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
        .padding(0)
    }
    
    func ImageLoadingView() -> some View {
        Color.gray
            .opacity(0.2)
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

