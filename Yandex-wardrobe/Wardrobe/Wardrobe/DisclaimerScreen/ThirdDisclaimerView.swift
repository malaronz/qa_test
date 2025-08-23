import SwiftUI

struct ThirdDisclaimerView : View {
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            
            Image("disclaimer3")
                .resizable()
                .scaledToFit()
                .frame(height: 640)
            
            Spacer()
            
            Button(action: onComplete) {
                Text("Дальше")
                    .font(.custom("YS Text Bold", size: 16))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "FCE000"))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
          
            
        }
        .navigationBarHidden(true)
    }
    
}
    
#Preview {
    
    ThirdDisclaimerView(onComplete: {})
}
