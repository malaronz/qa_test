import SwiftUI

struct WardrobePopupView: View {
    @Environment(\.popupCoordinator) private var popupCoordinator
    let onWardrobeButtonTap: () -> Void
    @State private var showingDisclaimer = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .topTrailing) {
                Image(.popup)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: Spec.imageHeight)
                    .clipped()
                
                Button(action: {
                    popupCoordinator.hide()
                }) {
                    Image(systemName: Spec.xMarkIcon)
                        .font(.system(size: Spec.buttonFontSize, weight: .medium))
                        .foregroundColor(.black)
                        .frame(width: Spec.iconSize, height: Spec.iconSize)
                        .background(.white)
                        .clipShape(Circle())
                        .shadow(color: Spec.blackShadowColor, radius: 4, x: 0, y: 2)
                }
                .padding([.top, .trailing], Spec.xMarkPadding)
            }
            
            VStack(alignment: .leading) {
                Text(Spec.titleText)
                    .font(.system(size: Spec.titleFontSize, weight: .bold))
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, Spec.textHorizontalPadding)
                
                
                Spacer()
                
                Button(action: {
                    showingDisclaimer = true
                }) {
                    Text(Spec.buttonText)
                        .font(.system(size: Spec.buttonFontSize, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: Spec.buttonHeight)
                        .background(Spec.yellowColor)
                        .cornerRadius(Spec.buttonCornerRadius)
                }
                .padding(.horizontal, Spec.buttonHorizontalPadding)
            }
            .padding(.top, Spec.topPadding)
            .padding(.bottom, Spec.bottomPadding)
            .background(Spec.backgroundColor)
            .clipShape(
                RoundedCorner(radius: Spec.stackCornerRadius, corners: [.topLeft, .topRight])
            )
            .offset(y: Spec.stackOffset)
        }
        .background(Spec.backgroundColor)
        .fullScreenCover(isPresented: $showingDisclaimer) {
            NavigationView {
                DisclaimerView {
                    showingDisclaimer = false
                    onWardrobeButtonTap()
                }
            }
        }
    }
}

private enum Spec {
    // Text
    static let xMarkIcon = "xmark"
    static let titleText = "Теперь в Яндекс Маркет есть гардероб. Заходи и пробуй"
//    static let descriptionText = "Заходи и пробуй!"
    static let buttonText = "Перейти в гардероб"
    
    // Size
    static let imageHeight: CGFloat = 240
    static let iconSize: CGFloat = 32
    
    // Spacing
    static let xMarkPadding: CGFloat = 10
    static let textHorizontalPadding: CGFloat = 16
    static let stackCornerRadius: CGFloat = 20
    static let stackOffset: CGFloat = -20
    static let textSpacing: CGFloat = 8
    static let titleFontSize: CGFloat = 24
    static let descriptionFontSize: CGFloat = 16
    static let topPadding: CGFloat = 20
    static let bottomPadding: CGFloat = 24
    static let buttonHorizontalPadding: CGFloat = 8
    static let buttonFontSize: CGFloat = 16
    static let buttonHeight: CGFloat = 56
    static let buttonCornerRadius: CGFloat = 16
    
    // Colors
    static let blackShadowColor = Color.black.opacity(0.1)
    static let yellowColor = Color(UIColor(red: 252/255, green: 224/255, blue: 0/255, alpha: 1.0))
    static let backgroundColor = Color(UIColor.systemBackground)
}
