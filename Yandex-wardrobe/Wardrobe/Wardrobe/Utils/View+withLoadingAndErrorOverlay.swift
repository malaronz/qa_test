import SwiftUI

extension View {
    func withLoadingAndErrorOverlay(
        isLoading: Bool,
        error: String?,
        onDismiss: @escaping () -> Void
    ) -> some View {
        self
            .overlay {
                if isLoading {
                    ProgressView()
                }
            }
            .alert("Ошибка", isPresented: .constant(error != nil)) {
                Button("Ок", role: .cancel, action: onDismiss)
            } message: {
                Text(error ?? "")
            }
    }
}
