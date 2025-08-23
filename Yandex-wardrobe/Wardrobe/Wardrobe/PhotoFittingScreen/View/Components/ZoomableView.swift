import SwiftUI

struct ZoomableView<Content: View>: View {
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    let content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            content()
                .scaleEffect(scale)
                .offset(offset)
                .gesture(
                    SimultaneousGesture(
                        MagnificationGesture()
                            .onChanged { value in
                                withAnimation(.interactiveSpring()) {
                                    scale = min(max(value, 1.0), 4.0)
                                }
                            }
                            .onEnded { _ in
                                if scale < 1.0 {
                                    withAnimation(.spring()) {
                                        scale = 1.0
                                        offset = .zero
                                    }
                                }
                            },
                        DragGesture()
                            .onChanged { value in
                                if scale > 1.0 {
                                    let newOffset = CGSize(
                                        width: lastOffset.width + value.translation.width,
                                        height: lastOffset.height + value.translation.height
                                    )
                                    
                                    let maxOffset = (scale - 1) * geometry.size.width / 2
                                    offset = CGSize(
                                        width: min(max(newOffset.width, -maxOffset), maxOffset),
                                        height: min(max(newOffset.height, -maxOffset), maxOffset)
                                    )
                                } else {
                                    withAnimation(.interactiveSpring()) {
                                        offset = value.translation
                                    }
                                }
                            }
                            .onEnded { _ in
                                if scale <= 1.0 {
                                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                                        offset = .zero
                                    }
                                } else {
                                    lastOffset = offset
                                }
                            }
                    )
                )
                .onTapGesture(count: 2) {
                    withAnimation(.spring()) {
                        if scale > 1.0 {
                            scale = 1.0
                            offset = .zero
                            lastOffset = .zero
                        } else {
                            scale = 2.0
                        }
                    }
                }
        }
    }
}
