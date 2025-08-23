import SwiftUI

struct DisclaimerView: View {
    let onComplete: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            // Main image with two photos overlaid
            ZStack {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .scaleEffect(3.6)
                    .rotationEffect(.degrees(350))
                    .offset(x: 150, y: -244)
                
                Image(.jacket)
                    .resizable()
                    .scaledToFit()
                    .offset(x: 100, y: -40)
                
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .scaleEffect(3.6)
                  .rotationEffect(.degrees(320))
                    .offset(x: -55, y: -190)
                Image(.jeans)
                    .resizable()
                    .scaledToFit()

                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
                    .scaleEffect(4.3)
                    .rotationEffect(.degrees(730))
                    .offset(x: 140, y: 180)
            }
            .frame(height: 500)

            // Text description
            VStack(alignment: .center, spacing: 2) {
                Text("Все любимые вещи")
                    .font(.custom("YS Text Bold", size: 24))
                Text("в одном месте")
                    .font(.custom("YS Text Bold", size: 24))
            }
            .padding(.top, -65)
            .padding()
            //в одном месте
            
            VStack {
                    HStack {
                        Text("Мы перенесли одежду, аксессуары из ваших избранных сюда, чтобы вам было удобнее создавать образы и находить новую одежду")
                            .lineLimit(nil)
                            .font(.custom("YandexSansDisplay-Light", size: 16))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
                    .padding(.vertical, -50)
                }
            Spacer()
            
            NavigationLink(destination:  SecondDisclaimerView(onComplete: onComplete)){
                Text("Дальше")
                    .font(.custom("YS Text Bold", size: 16))
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor(red: 252/255, green: 224/255, blue: 0/255, alpha: 1.0)))
                    .cornerRadius(10)
            }
            .frame(width: 357, height: 56)
            .padding()
            .padding(.top, 95)
            .navigationBarBackButtonHidden()
        }
        .background(Color.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { // Wrap in NavigationView for preview
            DisclaimerView(onComplete: {})
             }

    }
}
