enum CameraAccessResult: Equatable {
    case authorized
    case denied(reason: String)
    case unavailable(reason: String)
}
