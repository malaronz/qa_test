import SwiftUI

struct LoadingOverlay: View {
    let configuration: LoadingConfiguration
    
    var body: some View {
        ZStack {
            Color.white.opacity(0.8)
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                if configuration.showSpinner {
                    LoadingSpinner()
                }
                
                VStack(spacing: 8) {
                    Text(configuration.title)
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                    
                    if let subtitle = configuration.subtitle {
                         Text(subtitle)
                             .font(.system(size: 14, weight: .regular))
                             .multilineTextAlignment(.center)
                    }
                }
            }
        }
        .allowsHitTesting(!configuration.allowDismiss)
    }
}

struct LoadingSpinner: View {
    @State private var isAnimating = false
    
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.75)
            .stroke(.black, lineWidth: 2)
            .frame(width: 24, height: 24)
            .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
            .background(
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
            )
            .animation(
                Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false),
                value: isAnimating
            )
            .onAppear {
                isAnimating = true
            }
    }
}
