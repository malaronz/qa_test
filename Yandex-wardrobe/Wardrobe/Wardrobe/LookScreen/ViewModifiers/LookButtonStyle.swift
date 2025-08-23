import SwiftUI

struct LookButtonWithTextStyle: ButtonStyle {
    private var padding: EdgeInsets {
        EdgeInsets(top: 13, leading: 0, bottom: 13, trailing: 0)
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.custom("YS Text", size: 14))
            .foregroundStyle(.white)
            .padding(padding)
            .frame(width: 154.5, height: 40)
            .background(Color.white.opacity(0.2))
            .clipShape(.rect(cornerRadius: 12))
    }
}

struct LookButtonWithIconStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(.white)
            .frame(width: 40, height: 40)
            .background(Color.white.opacity(0.2))
            .clipShape(.rect(cornerRadius: 12))
    }
}
