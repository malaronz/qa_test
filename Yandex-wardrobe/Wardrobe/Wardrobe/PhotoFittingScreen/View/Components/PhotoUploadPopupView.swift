import SwiftUI

struct PhotoUploadPopupView: View {
    let onContinueTap: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spec.stackSpacing) {
            VStack(alignment: .leading, spacing: Spec.textSpacing) {
                Text(Spec.titleText)
                    .font(.system(size: Spec.titleFontSize, weight: .bold))
                    .multilineTextAlignment(.leading)
                
                Text(Spec.descriptionText)
                    .font(.system(size: Spec.descriptionFontSize))
                    .multilineTextAlignment(.leading)
                
            }
            .padding(.horizontal, Spec.textHorizontalPadding)
            
            Button(
                action: {
                    AnalyticsService.reportEvent(
                        name: "tryon_click",
                        screen: "PhotoFitting",
                        item: "look"
                    )
                    onContinueTap()
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
            
            Spacer()
        }
        .padding(.top, Spec.topPadding)
        .background(Spec.backgroundColor)
    }
}

private enum Spec {
    static let titleText = "Загрузите фото"
    static let descriptionText = "Чтобы увидеть как вещь будет смотреться на вас, загрузите свое фото в полный рост, с хорошим освещением"
    static let buttonText = "Продолжить"
    
    static let textHorizontalPadding: CGFloat = 16
    static let stackSpacing: CGFloat = 20
    static let stackCornerRadius: CGFloat = 20
    static let textSpacing: CGFloat = 8
    static let titleFontSize: CGFloat = 24
    static let descriptionFontSize: CGFloat = 16
    static let topPadding: CGFloat = 20
    static let buttonHorizontalPadding: CGFloat = 8
    static let buttonFontSize: CGFloat = 16
    static let buttonHeight: CGFloat = 56
    static let buttonCornerRadius: CGFloat = 16
    
    // Colors
    static let yellowColor = Color(UIColor(red: 252/255, green: 224/255, blue: 0/255, alpha: 1.0))
    static let backgroundColor = Color(UIColor.systemBackground)
}
