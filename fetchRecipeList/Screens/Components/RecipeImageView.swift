import SwiftUI

struct RecipeImageView: View {
    let imageUrl: URL
    
    var body: some View {
        CachedAsyncImage(url: imageUrl) { phase in
            switch phase {
            case .empty:
                imageLoadingView()
            case .success(let image):
                imageView(image)
            case .failure:
                Rectangle()
            @unknown default:
                Rectangle()
            }}
        .padding(0)
    }
    
    func imageLoadingView() -> some View {
        Color.gray
            .opacity(0.2)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shimmer(when: true)
    }
    
    func imageView(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

