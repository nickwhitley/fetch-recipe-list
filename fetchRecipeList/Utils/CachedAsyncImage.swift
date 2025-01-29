import SwiftUI

struct CachedAsyncImage<Content: View>: View {
    @State private var loader: ImageLoader
    
    private let content: (AsyncImagePhase) -> Content
    
    init(url: URL?, scale: CGFloat = 1, animation: Animation? = nil, @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        self.content = content
        self.loader = ImageLoader(url: url, scale: scale, animation: animation)
    }
    
    var body: some View {
        content(loader.phase)
            .onAppear {
                Task {
                    await loader.load()
                }
            }
    }
}

@Observable
private class ImageLoader {
    var phase: AsyncImagePhase = .empty
    private let scale: CGFloat
    private let animation: Animation?
    private let url: URL?
    
    private static let cache: URLCache = {
        let memoryCapacity = 100 * 1024 * 1024 // 100 MB
        let diskCapacity = 500 * 1024 * 1024 // 500 MB
        return URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "imagesCache")
    }()
    
    init(url: URL?, scale: CGFloat = 1, animation: Animation? = nil) {
        self.scale = scale
        self.animation = animation
        self.url = url
    }
    
    @MainActor
    func load() async {
        phase = .empty
        
        guard let url else {
            withAnimation(animation) {
                phase = .failure(URLError(.badURL))
            }
            return
        }
        
        if let cachedResponse = ImageLoader.cache.cachedResponse(for: URLRequest(url: url)),
           let cachedImage = UIImage(data: cachedResponse.data, scale: scale) {
            withAnimation(animation) {
                phase = .success(Image(uiImage: cachedImage))
            }
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            if let image = UIImage(data: data, scale: scale) {
                let cachedData = CachedURLResponse(response: response, data: data)
                
                ImageLoader.cache.storeCachedResponse(cachedData, for: URLRequest(url: url))
                
                withAnimation(animation) {
                    phase = .success(Image(uiImage: image))
                }
            } else {
                throw URLError(.cannotDecodeContentData)
            }
            
        } catch {
            withAnimation(animation) {
                phase = .failure(error)
            }
        }
    }
}

