import UIKit

enum ProcessingState: Equatable {
    case initial
    case processing(preview: UIImage?)
    case success(UIImage)
    case failure(PhotoFittingError, preview: UIImage?)
}
