import SwiftUI

struct PopupView: View {
    @ObservedObject private var viewModel: PopupViewModel
    @State private var keyboardHeight: CGFloat = 0
    @State private var keyboardAnimationDuration: Double = 0.25
    @State private var keyboardEndFrame: CGRect = .zero

    init(viewModel: PopupViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if viewModel.state != .hidden {
                    backgroundOverlay
                    popupContent(geometry: geometry)
                }
            }
        }
    }
    
    private var backgroundOverlay: some View {
        Color.black.opacity(viewModel.config.backgroundOpacity)
            .ignoresSafeArea(.all, edges: .all)
            .onTapGesture {
                UIApplication.shared.endEditing()
                viewModel.hide()
            }
            .transition(.opacity)
    }
    
    private func popupContent(geometry: GeometryProxy) -> some View {
        VStack {
            Spacer()
            
            if let content = viewModel.content {
                let containerHeight = geometry.size.height
                let fixedHeight: CGFloat = {
                    if let detent = viewModel.currentDetent {
                        return detent.resolvedHeight(containerHeight: containerHeight)
                    } else if let first = viewModel.config.detents.first {
                        return first.resolvedHeight(containerHeight: containerHeight)
                    } else {
                        return containerHeight * 0.5
                    }
                }()
                let lift = keyboardLift(geometry: geometry)

                content
                    .frame(height: fixedHeight)
                    .cornerRadius(viewModel.config.cornerRadius, corners: [.topLeft, .topRight])
                    .padding(.bottom, lift)
                    .animation(.smooth(duration: keyboardAnimationDuration), value: keyboardHeight)
                    .offset(y: calculateOffset(geometry: geometry))
                    .shadow(
                        color: .black.opacity(viewModel.config.shadowOpacity),
                        radius: viewModel.config.shadowRadius
                    )
                    .gesture(dragGesture)
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                        guard let info = notification.userInfo,
                              let frame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                        else { return }
                        keyboardAnimationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25
                        keyboardEndFrame = frame
                        keyboardHeight = frame.height
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { notification in
                        guard let info = notification.userInfo else { keyboardHeight = 0; keyboardEndFrame = .zero; return }
                        keyboardAnimationDuration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) ?? 0.25
                        keyboardEndFrame = .zero
                        keyboardHeight = .zero
                    }
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)) { notification in
                        guard let info = notification.userInfo,
                              let frame = info[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
                        else { return }
                        keyboardEndFrame = frame
                    }
            }
        }
    }
    
    private func calculateOffset(geometry: GeometryProxy) -> CGFloat {
        switch viewModel.state {
        case .hidden:
            return geometry.size.height
        case .appearing:
            return geometry.size.height
        case .visible:
            return viewModel.dragOffset
        case .dismissing:
            return geometry.size.height
        }
    }
    
    private var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                if value.translation.height > 0 {
                    viewModel.handleDragChange(value.translation.height)
                }
            }
            .onEnded { value in
                UIApplication.shared.endEditing()
                viewModel.handleDragEnd(
                    translation: value.translation.height,
                    velocity: value.velocity.height
                )
            }
    }

    private func keyboardLift(geometry: GeometryProxy) -> CGFloat {
        guard keyboardHeight > .zero, keyboardEndFrame != .zero else { return .zero }
        let safeAreaBottom = geometry.safeAreaInsets.bottom
        return max(0, keyboardHeight - safeAreaBottom)
    }
}
