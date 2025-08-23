import SwiftUI

struct LookFiltersView: View {
    @StateObject private var viewModel: LookFiltersViewModel
    @Environment(\.dismiss) private var dismiss
    @Environment(\.tabBarCoordinator) private var tabBarCoordinator
    private var onDismiss: (Look) -> Void
    init(look: Look,onDismiss: @escaping (Look) -> Void) {
        self._viewModel = StateObject(wrappedValue: LookFiltersViewModel(look: look))
        self.onDismiss = onDismiss
    }
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.lookScreenGradientStart, .lookScreenGradientEnd], startPoint: .leading, endPoint: .trailing)
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
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
                        
                        Text(viewModel.look.name.uppercased())
                            .foregroundStyle(.white)
                            .font(.custom("YS Text Cond Heavy", size: 28.44))
                            .padding(.bottom, 16)
                        
                        LookLayoutForFilters(look: viewModel.look)
                            .padding(.bottom, 16)
                    }
                    
                    VStack(spacing: 0) {
                        VStack(spacing: 0) {
                            LookSeasonSection(
                                selectedSeason: $viewModel.selectedSeason,
                                onSeasonSelect: viewModel.selectSeason
                            )
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 0.5)
                                .padding(.vertical, 20)
                            
                            LookStyleSection(
                                selectedStyle: $viewModel.selectedStyle,
                                onStyleSelect: viewModel.selectStyle
                            )
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 0.5)
                                .padding(.vertical, 20)
                            
                            LookOccasionSection(
                                selectedOccasion: $viewModel.selectedOccasion,
                                onOccasionSelect: viewModel.selectOccasion
                            )
                            
                            Spacer(minLength: 120)
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 32)
                    }
                    .frame(maxWidth: .infinity)
                    .background(.wardrobeWhite)
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                }
            }
            .ignoresSafeArea(edges: .bottom)
            
            VStack {
                Spacer()
                
                Button(action: {
                    Task {
                        await viewModel.updateLook()
                        dismiss()
                        onDismiss(viewModel.look)
                    }
                }) {
                    HStack {
                        if viewModel.isUpdating {
                            ProgressView()
                                .tint(.black)
                                .scaleEffect(0.8)
                        }
                        Text(viewModel.isUpdating ? "Обновление..." : "Применить")
                            .font(.custom("YS Text Medium", size: 16))
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(Color(UIColor(red: 252/255, green: 224/255, blue: 0/255, alpha: 1.0)))
                    .cornerRadius(16)
                }
                .disabled(viewModel.isUpdating)
                .padding(.horizontal, 20)
                
                if tabBarCoordinator.isVisible {
                    Spacer()
                        .frame(height: 8)
                }
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            tabBarCoordinator.show()
        }
        .onAppear {
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().bounces = true
        }
    }
}

#Preview {
    LookFiltersView(
        look: Look(
            id: 1,
            name: "НА ПРОГУЛКУ",
            items: [
                Item(
                    id: 25,photoURL: URL(string: "https://avatars.mds.yandex.net//get-mpic//1332324/2a000001919295a4fb01ef996f3f651650bc//180x240")!,name: "kjgg для велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .top, clothesSubtype: .skirt,state: []),
                Item(
                    id: 26,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/12280362/2a000001944b2ae723d400e60d730d0cffdc/optimize")!,name: "Кепка для tttвелоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .bottom, clothesSubtype: .trousers,state: []),
                Item(
                    id: 27,photoURL: URL(string: "https://avatars.mds.yandex.net/get-mpic/5387588/img_id5077483725256516125.jpeg/optimize")!,name: "Кепка длgggя велоспорта",brandName: "MUSEUM OF PEACE",price: 52,description: "",clothesType: .shoes, clothesSubtype: .aquaShoes,state: [])
            ]
        ), onDismiss: {_ in }
    )
}


