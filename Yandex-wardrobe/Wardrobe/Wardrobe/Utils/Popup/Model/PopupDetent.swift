import SwiftUICore

enum PopupDetent: Equatable {
    case fraction(CGFloat)
    case fixed(CGFloat)

    func resolvedHeight(containerHeight: CGFloat) -> CGFloat {
        switch self {
        case .fraction(let f):
            return max(0, min(1, f)) * containerHeight
        case .fixed(let h):
            return min(max(0, h), containerHeight)
        }
    }
}

enum PopupDetentCommand {
    case next
    case set(PopupDetent)
}
