import SwiftUI

struct LookView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.popupCoordinator) private var popupCoordinator
    @StateObject private var viewModel: ViewModel
    @State private var editedName = ""
    @State private var headerHeight: CGFloat = 0

    init(look: Look) {
        _viewModel = StateObject(wrappedValue: ViewModel(look: look))
    }

    var body: some View {
        ZStack {
            LinearGradient(colors: [.lookScreenGradientStart, .lookScreenGradientEnd], startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                ScrollView {
                    // Header (measured)
                    VStack(spacing: 0) {
                        // Navigation Bar
                        ZStack {
                            HStack {
                                Button(action: {
                                    dismiss()
                                }) {
                                    Image(.lookArrowLeft)
                                        .foregroundColor(.white)
                                        .font(.custom("YS Text Medium", size: 18))
                                }
                                
                                Spacer()
                            }
                            
                            Text("Мой гардероб")
                                .foregroundColor(.white)
                                .font(.custom("YS Text Medium", size: 16))
                            
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 13)
                        .padding(.bottom, 26)
                        
                        VStack(spacing: 40) {
                            if !viewModel.isLoadingName {
                                Button(
                                    action: {
                                        editedName = viewModel.look.name
                                        popupCoordinator.show(
                                            LookNameEditPopupView(
                                                name: $editedName,
                                                onCancel: { popupCoordinator.hide() },
                                                onSave: { editedName in
                                                    Task {
                                                        await viewModel.updateLookName(editedName)
                                                    }
                                                    popupCoordinator.hide()
                                                    UIApplication.shared.endEditing()
                                                }
                                            ),
                                            config: .init(
                                                cornerRadius: 16,
                                                shadowRadius: 16,
                                                shadowOpacity: 0.08,
                                                backgroundOpacity: 0.3,
                                                dismissThreshold: 80,
                                                velocityThreshold: 400,
                                                animationConfig: .spring(response: 0.4, dampingFraction: 0.8),
                                                detents: [.fraction(0.27)],
                                                initialDetent: .fraction(0.27)
                                            )
                                    )
                                }) {
                                    Text(viewModel.look.name.uppercased())
                                        .foregroundStyle(.white)
                                        .font(.custom("YS Text Cond Heavy", size: 28.44))
                                }
                            } else {
                                ProgressView()
                                    .tint(.white)
                            }
                            
                            HStack(spacing: 8){
                                Button("Добавить в корзину") {viewModel.addItemsToCart()}
                                    .buttonStyle(LookButtonWithTextStyle())
                                
                                NavigationLink(
                                    destination: PhotoFittingView(
                                        viewModel: viewModel.createPhotoFittingViewModel()
                                    )
                                ) {
                                    Text("Примерить")
                                }
                                .buttonStyle(LookButtonWithTextStyle())
                                
                                NavigationLink(destination: LookFiltersView(look: viewModel.look, onDismiss: {look in viewModel.look = look})) {
                                    Image("Settings")
                                }
                                .buttonStyle(LookButtonWithIconStyle())
                            }
                        }
                        .padding(.bottom, 14)
                    }
                    .background(
                        GeometryReader { geo in
                            Color.clear.preference(key: HeaderHeightKey.self, value: geo.size.height)
                        }
                    )
                    .onPreferenceChange(HeaderHeightKey.self) { headerHeight = $0 }
                    
                    // Items container
                    VStack {
                        if !viewModel.isLoadingItems {
                            LazyVGrid(columns: [
                                GridItem(.flexible(), spacing: 8),
                                GridItem(.flexible(), spacing: 8)
                            ], spacing: 4) {
                                ForEach(viewModel.look.items, id: \.id) { item in
                                    let isCartedBinding = Binding(
                                        get: {
                                            item.state.contains(.bucket)
                                            //viewModel.cartedItems.contains(where: { $0.id == item.id })
                                        },
                                        set: { _ in
                                            viewModel.addItemToCart(item)
                                            //viewModel.toggleCarted(for: item)
                                        }
                                    )
                                    DetailedItemCardView(
                                        item: item,
                                        isLiked: item.state.contains(.liked),
                                        isCarted: isCartedBinding,
                                        isBought: item.state.contains(.bought)
                                    )
                                    .frame(width: 183.5, height: 330)
                                    .padding(4)
                                }
                                
                                // Add new clothes button as the last grid item
                                AddClothesView()
                            }
                            .padding(.horizontal, 8)
                        } else {
                            ProgressView()
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical, 16)
                    .padding(.bottom, 35)
                    .frame(maxWidth: .infinity)
                    .frame(minHeight: UIScreen.main.bounds.height - headerHeight)
                    .background(.wardrobeWhite)
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                }
                .onAppear {
                    UIScrollView.appearance().bounces = false
                }
                .onDisappear {
                    UIScrollView.appearance().bounces = true
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
//        .task {
//            await viewModel.loadLook()
//        }
        .navigationBarHidden(true)
    }
}

private struct HeaderHeightKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = max(value, nextValue())
    }
}

struct LookNameEditPopupView: View {
    @Binding var name: String
    let onCancel: () -> Void
    let onSave: (String) -> Void

    private let maxCharacters = 40
    
    var body: some View {
        VStack() {
            RoundedCorner(radius: 2)
                .frame(width: 34, height: 4)
                .padding(.vertical, 6)
                .foregroundStyle(.lightGray)
            
            VStack(alignment: .leading, spacing: 7) {
                Text("Название")
                    .font(.custom("YS Text Regular", size: 11))
                    .foregroundStyle(.secondary)
                
                TextField("Введите название", text: $name)
                    .font(.custom("YS Text Regular", size: 13))
                    .textFieldStyle(PlainTextFieldStyle())
                    .onChange(of: name) { newValue in
                        if newValue.count > maxCharacters {
                            name = String(newValue.prefix(maxCharacters))
                        }
                    }
                
                Rectangle()
                    .frame(height: 0.5)
                    .foregroundColor(.black)
                
                HStack {
                    Text("\(name.count)/\(maxCharacters)")
                        .font(.custom("YS Text", size: 11))
                        .foregroundColor(.secondary)
                    Spacer()
                }
            }
            .padding(.bottom, 16)
            
            HStack(spacing: 12) {
                Button("Отменить") { onCancel() }
                    .frame(width: 176.5, height: 48)
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.black)
                    .cornerRadius(16)
                
                Button("Сохранить") { onSave(name) }
                    .frame(width: 176.5, height: 48)
                    .background(Color(UIColor(red: 252/255, green: 224/255, blue: 0/255, alpha: 1.0)))
                    .foregroundColor(.black)
                    .cornerRadius(16)
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .background(Color(UIColor.systemBackground))
    }
}

struct RoundedCornersShape: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


#Preview {
    LookView(look: Look(id: 1, name: "", items: []))
}
