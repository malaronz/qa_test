import Foundation

final class LoadingCoordinator: ObservableObject {
    @Published var isLoading = false
    @Published var configuration: LoadingConfiguration = .default
    
    func show(configuration: LoadingConfiguration) {
        self.configuration = configuration
        isLoading = true
    }
    
    func hide() {
        isLoading = false
    }
}
