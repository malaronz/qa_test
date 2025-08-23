import SwiftUI

struct AddClothesView: View {
    var body: some View {
        VStack {
            Button(action: {
                
            }) {
                VStack(spacing: 10) {
                    Image("PlusSymbol")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }
                .frame(width: 179.5, height: 229)
                .padding(4)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
            }
            
            HStack {
                Text("Добавить одежду").bold()
                    .font(.custom("YS Text", size: 13))
                
                Spacer()
            }
            
            Spacer()
        }
    }
}
