import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        
        self.init(
            .sRGB,
            red: Double((rgb >> 16) & 0xFF) / 255.0,
            green: Double((rgb >> 8) & 0xFF) / 255.0,
            blue: Double(rgb & 0xFF) / 255.0,
            opacity: 1.0
        )
    }
}

struct SecondDisclaimerView: View {
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Spacer()
            Image("Disclaimer2")
                .resizable()
                .scaledToFit()
                .frame(height: 640)
            
            NavigationLink(destination: ThirdDisclaimerView(onComplete: onComplete)) {
                Text("Дальше")
                    .font(.custom("YS Text Bold", size: 16))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(hex: "FCE000"))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Spacer()
          
            
            
        }
        .navigationTitle("")
        .background(Color.white.edgesIgnoringSafeArea(.all))
        .navigationBarHidden(true)
    }
}

struct OutfitExampleView_Previews: PreviewProvider {
    static var previews: some View {
       
        NavigationView { // Wrap in NavigationView for preview
            SecondDisclaimerView(onComplete: {})
             }
            .previewDevice("iPhone 14") // Test on specific device
    }
}
