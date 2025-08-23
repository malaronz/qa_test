import SwiftUI

struct PhotoFittingView: View {
    @Environment(\.popupCoordinator) private var popupCoordinator
    @Environment(\.loadingCoordinator) private var loadingCoordinator
    @Environment(\.tabBarCoordinator) private var tabBarCoordinator
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: PhotoFittingViewModel
    
    init(viewModel: PhotoFittingViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        mainContent
            .navigationBarBackButtonHidden()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { toolbarContent }
            .onAppear {
                showInitialPopup()
                tabBarCoordinator.hide()
            }
            .onDisappear {
                popupCoordinator.hide()
                tabBarCoordinator.show()
            }
            .confirmationDialog(
                "",
                isPresented: isConfirmationDialogPresented,
                titleVisibility: .hidden,
                actions: { confirmationDialogContent }
            )
            .fullScreenCover(isPresented: isCameraSheetPresented) {
                CameraPicker { image in
                    viewModel.handlePhotoSelection(image)
                    viewModel.changeRoute(.popupUpload)
                }
            }
            .sheet(isPresented: isPhotoLibrarySheetPresented) {
                PhotoLibraryPicker { image in
                    viewModel.handlePhotoSelection(image)
                    viewModel.changeRoute(.popupUpload)
                    
                }
            }
            .onChange(of: viewModel.route) { handleRouteChange($0) }
            .onChange(of: viewModel.state) { handleStateChange($0) }
            .alert(item: $viewModel.alert) { model in
                if model.allowsOpenSettings {
                    return Alert(
                        title: Text(model.title),
                        message: Text(model.message),
                        primaryButton: .default(Text(Spec.settingsButtonTitle)) {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url)
                            }
                            viewModel.changeRoute(.popupUpload)
                        },
                        secondaryButton: .cancel(Text(Spec.okButtonTitle)) {
                            viewModel.changeRoute(.popupUpload)
                        }
                    )
                } else {
                    return Alert(
                        title: Text(model.title),
                        message: Text(model.message),
                        dismissButton: .default(Text(Spec.okButtonTitle)) { viewModel.changeRoute(.popupUpload) }
                    )
                }
            }
    }
    
    private var mainContent: some View {
        GeometryReader { geometry in
            Group {
                switch viewModel.state {
                case .initial:
                    initialContent(geometry: geometry)
                case let .processing(preview: preview):
                    if let preview { selectedPhotoContent(preview, geometry: geometry) }
                    else { initialContent(geometry: geometry) }
                case let .failure(_, preview: preview):
                    if let preview { selectedPhotoContent(preview, geometry: geometry) }
                    else { initialContent(geometry: geometry) }
                case let .success(image):
                    successContent(image)
                }
            }
        }
    }
    
    private var toolbarContent: some ToolbarContent {
        Group {
            ToolbarItem(placement: .principal) {
                if case .success = viewModel.state {
                    EmptyView()
                } else {
                    Text(Spec.navbarTitle)
                        .font(.system(size: Spec.navbarTitleFontSize, weight: .medium))
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                if case .success = viewModel.state {
                    EmptyView()
                } else {
                    Button(action: { dismiss() }) {
                        Image(.arrowLeft)
                            .renderingMode(.template)
                            .font(.system(size: 24))
                            .foregroundColor(.primary)
                    }
                    .tint(.primary)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                trailingButtons
            }
        }
    }
    
    @ViewBuilder
    private var trailingButtons: some View {
        if case .success = viewModel.state {
            HStack(spacing: Spec.trailingButtonsSpacing) {
                Button(action: { Task { await viewModel.downloadPhoto() } }) {
                    Image(.downloadButton)
                        .renderingMode(.template)
                        .font(.system(size: 24))
                        .foregroundColor(.primary)
                }
                
                Button(action: { dismiss() }) {
                    Image(systemName: Spec.closeIcon)
                        .foregroundColor(.primary)
                }
            }
        } else {
            EmptyView()
        }
    }
    
    private var isConfirmationDialogPresented: Binding<Bool> {
        Binding(
            get: { viewModel.route == .confirmation },
            set: { isPresented in
                if !isPresented && viewModel.route == .confirmation {
                    viewModel.changeRoute(.popupUpload)
                }
            }
        )
    }
    
    private var confirmationDialogContent: some View {
        Group {
            Button(Spec.openCameraTitle) {
                Task { await viewModel.prepareCameraAccess() }
            }
            
            Button(Spec.openLibraryTitle) {
                viewModel.changeRoute(.photoLibrary)
            }
            
            Button(Spec.cancelTitle, role: .cancel) {
                viewModel.changeRoute(.popupUpload)
            }
        }
    }
    
    private var isCameraSheetPresented: Binding<Bool> {
        Binding(
            get: { viewModel.route == .camera },
            set: { _ in viewModel.changeRoute(.popupUpload) }
        )
    }
    
    private var isPhotoLibrarySheetPresented: Binding<Bool> {
        Binding(
            get: { viewModel.route == .photoLibrary },
            set: { _ in viewModel.changeRoute(.popupUpload) }
        )
    }
    
    private func initialContent(geometry: GeometryProxy) -> some View {
        Image(.fittingPlaceholderPhoto)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: geometry.size.height - (geometry.size.height * Spec.bottomAreaRatio))
    }
    
    private func selectedPhotoContent(_ image: UIImage, geometry: GeometryProxy) -> some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(height: geometry.size.height - (geometry.size.height * Spec.bottomAreaRatio))
    }
    
    private func successContent(_ image: UIImage) -> some View {
        ZoomableView {
            VStack {
                Spacer()
                
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Spacer()
            }
        }
    }
    
    private func showInitialPopup() {
        viewModel.showInitialPopup()
        
        popupCoordinator.show(
            PhotoUploadPopupView(
                onContinueTap: {
                    if viewModel.validateClothingItems() {
                        viewModel.changeRoute(.confirmation)
                    }
                }
            ),
            config: Spec.popupConfig
        )
    }
    
    private func handleRouteChange(_ newRoute: PhotoFittingRoute?) {
        switch newRoute {
        case .popupUpload:
            showInitialPopup()
        case .confirmation, .camera, .photoLibrary:
            popupCoordinator.hide()
        case .none:
            break
        }
    }

    private func handleStateChange(_ newState: ProcessingState) {
        switch newState {
        case .processing:
            loadingCoordinator.show(
                configuration: LoadingConfiguration(title: Spec.loadingTitle)
            )
        case .success, .failure:
            popupCoordinator.hide()
            loadingCoordinator.hide()
        case .initial:
            break
        }
    }
}

#Preview {
    PhotoFittingView(viewModel: PhotoFittingViewModel())
}

private enum Spec {
    // Texts
    static let navbarTitle = "Мой гардероб"
    static let openCameraTitle = "Открыть камеру"
    static let openLibraryTitle = "Выбрать из галереи"
    static let cancelTitle = "Отмена"
    static let okButtonTitle = "OK"
    static let settingsButtonTitle = "Настройки"
    static let loadingTitle = "Примеряем красоту"

    // Icons
    static let backIcon = "arrow.left"
    static let closeIcon = "xmark"

    // Spacing
    static let trailingButtonsSpacing: CGFloat = 12
    
    // Layout ratios/sizes
    static let bottomAreaRatio: CGFloat = 0.25
    static let navbarTitleFontSize: CGFloat = 16

    // Popup configuration
    static let popupConfig = PopupConfiguration(
        cornerRadius: 20,
        shadowRadius: 16,
        shadowOpacity: 0.08,
        backgroundOpacity: .zero,
        dismissThreshold: 80,
        velocityThreshold: 400,
        animationConfig: .interpolatingSpring(
            stiffness: 222,
            damping: 28
        ),
        detents: [.fraction(0.27)],
        initialDetent: .fraction(0.27)
    )
}
