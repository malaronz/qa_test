import SwiftUI

struct ClothesSubtypesSkeletonView: View {
    var count: Int = 4

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                ForEach(0..<count, id: \.self) { _ in
                    VStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 78.75, height: 78.75)

                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 12)
                    }
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 16)
            .padding(.horizontal)
        }
    }
}
