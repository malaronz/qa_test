import SwiftUI

struct AddALookView: View {
    var body: some View {
        NavigationLink(destination: CarouselView(viewModel: CarouselViewModel(selectedIds: []))) {
            VStack {
                VStack(spacing: 10) {
                    Image("PlusSymbol")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }
                .frame(width: 175, height: 175) // Match grid item size
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Text("Создать новый образ")
                    .font(.custom("YS Text Bold", size: 14))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AddALookView_Previews: PreviewProvider {
    static var previews: some View {
        AddALookView()
    }
}
