import Foundation

struct LoadingConfiguration {
    let title: String
    let subtitle: String?
    let showSpinner: Bool
    let allowDismiss: Bool
    
    init(
        title: String,
        subtitle: String? = nil,
        showSpinner: Bool = true,
        allowDismiss: Bool = false
    ) {
        self.title = title
        self.subtitle = subtitle
        self.showSpinner = showSpinner
        self.allowDismiss = allowDismiss
    }
}

extension LoadingConfiguration {
    static let `default` = LoadingConfiguration(title: "Загрузка...")
}
