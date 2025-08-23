import SwiftUI

struct Checkbox: View {
    var isSelected: Bool
    var size: CGFloat = 18
    
    private var cornerRadius: CGFloat {
        size == 18 ? 4.5 : 8.0
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(isSelected ? .checkboxOn : .checkboxOff)
            .frame(width: size, height: size)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color.clear)
                    .shadow(color: Color.black.opacity(0.05),
                            radius: 2.25,
                            x: 0,
                            y: 1.5)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .blendMode(.multiply)
            )
            .opacity(1)
            .position(x: 3 + 9, y: 3 + 9)
    }
}
