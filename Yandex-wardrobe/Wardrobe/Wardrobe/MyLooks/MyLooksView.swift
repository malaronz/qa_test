import SwiftUI

struct MyLooksView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var looks: [Look] = []
    var service = WardrobeService()

    var body: some View {
        VStack(spacing: 0) {
            Text("Готовые образы")
                .font(.system(size: 24))
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.top, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 5) {
                    Menu {
                        Button("Весна", action: { })
                        Button("Лето", action: { })
                        Button("Осень", action: { })
                        Button("Зима", action: { })
                    } label: {
                        HStack(spacing: 4) {
                            Text("Сезон")
                            Image(systemName: "chevron.down")
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.wardrobeBlack)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    }

                    Menu {
                        Button("Кэжуал", action: { })
                        Button("Офис", action: { })
                        Button("Вечерний", action: { })
                    } label: {
                        HStack(spacing: 4) {
                            Text("Стиль")
                            Image(systemName: "chevron.down")
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.wardrobeBlack)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    }

                    Menu {
                        Button("Офис", action: { })
                        Button("Выпускной", action: { })
                        Button("Спорт", action: { })
                        
                    } label: {
                        HStack(spacing: 4) {
                            Text("Повод")
                            Image(systemName: "chevron.down")
                        }
                        .font(.system(size: 14))
                        .foregroundColor(.wardrobeBlack)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 8)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    }
                }
                .padding(.vertical, 5)
                .padding(.horizontal)

            }
            Spacer()
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.fixed(175), spacing: 20),
                    GridItem(.fixed(175), spacing: 10)
                ], spacing: 30) {
                    AddALookView()
                    ForEach(looks, id: \.id) { look in
                        LookLayout(look: look)
                            .padding(.top, 15)
                    }
                }
                .padding(.horizontal)
            }
        }
        .padding(.top, 10)
        .navigationTitle("Мой гардероб")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "arrow.left").foregroundColor(.wardrobeBlack)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) { Image(systemName: "magnifyingglass").foregroundColor(.wardrobeBlack) }
        }
        .task {
            do {
                let all = try await service.getWardrobe(filter: Filter(top: nil, bottom: nil, shoes: nil, all: nil, look: nil)).looks
                await MainActor.run {
                    looks = all
                }
            } catch {
                print("Error: \(error)")
            }
        }

    }
}

#Preview {
    MyLooksView()
}
