import SwiftUI

struct ClothesSubtypesList: View {
    var shelfType: ShelfType
    var items: [Item]
    @Binding var selectedClothesSubtype: ClothesSubtype?
    @Binding var selectedClothesTypeForAll: ClothesType?

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 18) {
                if shelfType == .all {
                    ForEach(ClothesType.allCases.filter({$0 != .none}), id: \.self) { type in
                        Button {
                            if selectedClothesTypeForAll == type {
                                selectedClothesTypeForAll = nil
                            } else {
                                selectedClothesTypeForAll = type
                            }
                        } label: {
                            VStack {
                                ClothesSubtypeView(
                                    isSelected: Binding<Bool>(
                                        get: { selectedClothesTypeForAll == type },
                                        set: { isSelected in
                                            if isSelected {
                                                selectedClothesTypeForAll = type
                                            } else if selectedClothesTypeForAll == type {
                                                selectedClothesTypeForAll = nil
                                            }
                                        }
                                    ),
                                    imageURL: items.first(where: { $0.clothesType == type })?.photoURL
                                )
                                Text(type.title)
                                    .font(.system(size: 13, weight: .medium))
                                    .lineLimit(2)
                                    .foregroundStyle(.wardrobeBlack)
                            }
                        }
                        .foregroundColor(.black)
                    }
                } else {
                    ForEach(shelfType.clothesType[0].availableSubtypes, id: \.self) { subtype in
                        Button {
                            if selectedClothesSubtype == subtype {
                                selectedClothesSubtype = nil
                            } else {
                                selectedClothesSubtype = subtype
                            }
                        } label: {
                            VStack {
                                ClothesSubtypeView(
                                    isSelected: Binding<Bool>(
                                        get: { selectedClothesSubtype == subtype },
                                        set: { isSelected in
                                            if isSelected {
                                                selectedClothesSubtype = subtype
                                            } else if selectedClothesSubtype == subtype {
                                                selectedClothesSubtype = nil
                                            }
                                        }
                                    ),
                                    imageURL: items.first(where: { $0.clothesSubtype == subtype })?.photoURL
                                )
                                Text(subtype.title)
                                    .font(.custom("YS Text Medium", size: 12))
                                    .lineLimit(2)
                                    .foregroundStyle(.wardrobeBlack)
                            }
                        }
                        .foregroundColor(.black)
                    }
                }
            }
            .padding(.top, 16)
            .padding(.bottom, 16)
            .padding(.horizontal)
        }
    }
}

#Preview {
    @State var selectedClothesSubtype: ClothesSubtype? = nil
    @State var selectedClothesTypeForAll: ClothesType?
    ClothesSubtypesList(shelfType: .top, items: [], selectedClothesSubtype: $selectedClothesSubtype, selectedClothesTypeForAll: $selectedClothesTypeForAll)
}
