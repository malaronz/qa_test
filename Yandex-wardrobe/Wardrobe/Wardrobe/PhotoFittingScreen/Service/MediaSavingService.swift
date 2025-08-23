import Photos
import UIKit

protocol MediaSavingService {
    func saveToLibrary(image: UIImage) async throws
}

struct MediaSavingServiceImpl: MediaSavingService {
    func saveToLibrary(image: UIImage) async throws {
        // Permissions
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        if status == .notDetermined {
            let granted = await PHPhotoLibrary.requestAuthorization(for: .addOnly) == .authorized
            if !granted { throw MediaSavingError.denied }
        } else if status != .authorized {
            throw MediaSavingError.denied
        }

        // Save
        do {
            try await PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.creationRequestForAsset(from: image)
            }
        } catch {
            throw MediaSavingError.failed
        }
    }
}
