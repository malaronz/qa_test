import SwiftUI

@MainActor
final class PhotoFittingViewModel: ObservableObject {

    @Published private(set) var state: ProcessingState = .initial
    @Published private(set) var route: PhotoFittingRoute? = nil
    @Published var alert: PhotoFittingAlert? = nil

    private let cameraAuth: CameraAuthorization
    private let imageProcessingService: ImageProcessingService
    private let mediaSavingService: MediaSavingService

    private var processingTask: Task<Void, Never>? = nil
    private var clothingURLs: [String] = []

    init(
        cameraAuth: CameraAuthorization = CameraAuthorizationImpl(),
        imageProcessingService: ImageProcessingService = ImageProcessingServiceImpl(),
        mediaSavingService: MediaSavingService = MediaSavingServiceImpl(),
        clothingURLs: [String] = []
    ) {
        self.cameraAuth = cameraAuth
        self.imageProcessingService = imageProcessingService
        self.mediaSavingService = mediaSavingService
        self.clothingURLs = clothingURLs
    }

    // MARK: - Routing
    func changeRoute(_ newRoute: PhotoFittingRoute?) { route = newRoute }
    func showInitialPopup() {
        route = .popupUpload
    }

    // MARK: - User intents
    func prepareCameraAccess() async {
        let result = await cameraAuth.checkAndRequestCameraAccess()
        switch result {
        case .authorized:
            changeRoute(.camera)
        case let .denied(reason):
            presentCameraUnavailable(reason, allowsSettings: true)
        case let .unavailable(reason):
            presentCameraUnavailable(reason, allowsSettings: false)
        }
    }

    func handlePhotoSelection(_ image: UIImage?) {
        guard let image else { return }
        state = .processing(preview: image)
        processImage(image, preview: image)
    }

    func downloadPhoto() async {
        guard case .success(let image) = state else { return }
        do {
            try await mediaSavingService.saveToLibrary(image: image)
        } catch {
            let message = (error as? LocalizedError)?.errorDescription ?? Spec.savingErrorTitle
            let allowsSettings = (error as? MediaSavingError) == .denied
            alert = PhotoFittingAlert(
                title: Spec.savingErrorTitle,
                message: message,
                allowsOpenSettings: allowsSettings
            )
        }
    }

    func reset() {
        processingTask?.cancel()
        state = .initial
        route = nil
        alert = nil
    }

    // MARK: - Validation
    func validateClothingItems() -> Bool {
        guard clothingURLs.count == 3 else {
            alert = PhotoFittingAlert(
                title: Spec.missingClothingTitle,
                message: Spec.invalidLookMessage,
                allowsOpenSettings: false
            )
            return false
        }
        
        let hasTop = !clothingURLs[0].isEmpty
        let hasBottom = !clothingURLs[1].isEmpty
        let hasShoes = !clothingURLs[2].isEmpty
        
        if !hasTop || !hasBottom || !hasShoes {
            var missingTypes: [String] = []
            
            if !hasTop {
                missingTypes.append("верх")
            }
            if !hasBottom {
                missingTypes.append("низ")
            }
            if !hasShoes {
                missingTypes.append("обувь")
            }
            
            let missingText = missingTypes.joined(separator: ", ")
            
            alert = PhotoFittingAlert(
                title: Spec.missingClothingTitle,
                message: String(format: Spec.missingClothingMessage, missingText),
                allowsOpenSettings: false
            )
            return false
        }
        
        return true
    }

    // MARK: - Private
    private func processImage(_ image: UIImage, preview: UIImage?) {
        processingTask?.cancel()
        processingTask = Task { [imageProcessingService, clothingURLs] in
            do {
                let result = try await imageProcessingService.process(image: image, clothingURLs: clothingURLs)
                guard !Task.isCancelled else { return }
                await MainActor.run { state = .success(result) }
            } catch {
                let message = (error as? LocalizedError)?.errorDescription ?? Spec.processingErrorTitle
                await MainActor.run {
                    state = .failure(.processing(message), preview: preview)
                    alert = PhotoFittingAlert(
                        title: Spec.processingErrorTitle,
                        message: message,
                        allowsOpenSettings: false
                    )
                }
            }
        }
    }

    // MARK: - Helpers
    private func presentCameraUnavailable(_ reason: String, allowsSettings: Bool) {
        alert = PhotoFittingAlert(
            title: Spec.cameraUnavailableTitle,
            message: reason,
            allowsOpenSettings: allowsSettings
        )
        changeRoute(.popupUpload)
    }
}

private enum Spec {
    static let cameraUnavailableTitle = "Камера недоступна"
    static let processingErrorTitle = "Ошибка обработки"
    static let savingErrorTitle = "Ошибка сохранения"
    static let missingClothingTitle = "Неполный образ"
    static let missingClothingMessage = "Для примерки образа не хватает: %@. Добавьте недостающие вещи в образ и попробуйте снова."
    static let invalidLookMessage = "Не удалось определить состав образа. Пожалуйста, добавьте все вещи в образ."
}
