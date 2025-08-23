import AVFoundation
import UIKit

protocol CameraAuthorization {
    func checkAndRequestCameraAccess() async -> CameraAccessResult
}

struct CameraAuthorizationImpl: CameraAuthorization {
    func checkAndRequestCameraAccess() async -> CameraAccessResult {
        let isAvailable = await MainActor.run { UIImagePickerController.isSourceTypeAvailable(.camera) }
        guard isAvailable else {
            return .unavailable(reason: Spec.cameraUnavailableText)
        }

        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .authorized:
            return .authorized
        case .notDetermined:
            let granted = await withCheckedContinuation { continuation in
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    continuation.resume(returning: granted)
                }
            }
            return granted ? .authorized : .denied(reason: Spec.deniedCameraAccessText)
        case .denied, .restricted:
            return .denied(reason: Spec.deniedCameraAccessText + "\n" + Spec.deniedCameraAccessSettingsText)
        @unknown default:
            return .unavailable(reason: Spec.unknownErrorText)
        }
    }
}

private enum Spec {
    static let cameraUnavailableText: String = "Камера недоступна на этом устройстве"
    static let deniedCameraAccessText: String = "Доступ к камере запрещён"
    static let deniedCameraAccessSettingsText: String = "Проверьте настройки приложения"
    static let unknownErrorText: String = "Неизвестная ошибка доступа к камере"
}
