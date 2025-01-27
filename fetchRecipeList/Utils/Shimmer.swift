import SwiftUI

extension View {
    @ViewBuilder
    func shimmer(when isLoading: Bool) -> some View {
        if isLoading {
            self.modifier(Shimmer())
                .redacted(reason: .placeholder)
                .allowsHitTesting(false)
        } else {
            self
        }
    }
}

public struct Shimmer: ViewModifier {
    @State private var isAnimating = true
    
    public func body(content: Content) -> some View {
        content
            .mask(
                LinearGradient(
                    gradient: .init(colors: [.black, .black.opacity(0.6), .black]),
                    startPoint: isAnimating ? .init(x: -0.5, y: 0.5) : .init(x: 1, y: 0.5),
                    endPoint: isAnimating ? .init(x: 0, y: 0.5) : .init(x: 2.2, y: 0.5)
                )
            )
            .onAppear {
                isAnimating = false
                withAnimation(
                    .timingCurve(0.7, 0, 0.8, 1, duration: 1)
                    .repeatForever(autoreverses: false)
                ) {
                    isAnimating.toggle()
                }
            }
    }
}
