import SwiftUI

struct FilterView: View {
    @State private var selectedTopSizes: Set<String> = []
    @State private var isTopAllSelected: Bool = false
    @State private var selectedBottomSizes: Set<String> = []
    @State private var isBottomAllSelected: Bool = false
    @State private var selectedShoeSizes: Set<String> = []
    @State private var isShoeAllSelected: Bool = false
    @State private var selectedHeights: Set<String> = []
    @State private var isHeightAllSelected: Bool = false
    @State private var selectedSeasons: Set<String> = []
    @State private var selectedGenders: Set<String> = []
    
    var body: some View {
       
            VStack(spacing: 10) {
                TitleSection()
                GenderSection(selectedGenders: $selectedGenders)
                TopSizeSection(selectedSizes: $selectedTopSizes, isAllSelected: $isTopAllSelected)
                BottomSizeSection(selectedSizes: $selectedBottomSizes, isAllSelected: $isBottomAllSelected)
                ShoeSizeSection(selectedSizes: $selectedShoeSizes, isAllSelected: $isShoeAllSelected)
                HeightSection(selectedSizes: $selectedHeights, isAllSelected: $isHeightAllSelected)
                SeasonSection(selectedSeason: $selectedSeasons)
                ContinueButton()
            }
            .padding()
    }
}

struct TitleSection: View {
    var body: some View {
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        HStack {
            Image("AliceGPT") // Ensure this image exists in your assets
                .resizable()
                .frame(width: 35, height: 35)
            Spacer()
            Text("Настроить образ")
                .font(.headline)
            Spacer()
            Image(systemName: "xmark")
                .imageScale(.small)
                .font(.system(size: 35))
        }
    }
}

struct GenderSection: View {
    @Binding var selectedGenders: Set<String>
    
    var body: some View {
        Text("Пол")
            .font(.system(size: 22))
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        HStack {
            ForEach(["женский", "мужской", "для девочек"], id: \.self) { gender in
                Button(action: {
                    if selectedGenders.contains(gender) {
                        selectedGenders.remove(gender)
                    } else {
                        selectedGenders.insert(gender)
                    }
                }) {
                    ZStack {
                        if selectedGenders.contains(gender) {
                            HStack(spacing: 5) {
                                Text(gender)
                                    .font(.system(size: 12))
                                    .fixedSize()
                                    .foregroundColor(.white)
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .imageScale(.small)
                                    .font(.system(size: 15))
                            }
                            .padding(.vertical, 1)
                            .padding(.horizontal, 4)
                        } else {
                            Text(gender)
                                .font(.system(size: 12))
                                .fixedSize()
                                .foregroundColor(.black)
                                .frame(width: 90, height: 15, alignment: .center)
                        }
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(selectedGenders.contains(gender) ? Color.black.opacity(0.7) : Color.gray.opacity(0.2))
                .cornerRadius(30)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        HStack {
            ForEach(["для мальчиков", "унисекс"], id: \.self) { gender in
                Button(action: {
                    if selectedGenders.contains(gender) {
                        selectedGenders.remove(gender)
                    } else {
                        selectedGenders.insert(gender)
                    }
                    
                }) {
                    ZStack {
                        if selectedGenders.contains(gender) {
                            HStack(spacing: 5) {
                                Text(gender)
                                    .font(.system(size: 12))
                                    .fixedSize()
                                    .foregroundColor(.white)
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .imageScale(.small)
                                    .font(.system(size: 15))
                            }
                            .padding(.vertical, 1)
                            .padding(.horizontal, 4)
                        } else {
                            Text(gender)
                                .font(.system(size: 12))
                                .fixedSize()
                                .foregroundColor(.black)
                                .frame(width: 90, height: 15, alignment: .center)
                        }
                    }
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
                .background(selectedGenders.contains(gender) ? Color.black.opacity(0.7) : Color.gray.opacity(0.2))
                .cornerRadius(30)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct SizeSection: View {
    let title: String
    let sizes: [String]
    @Binding var selectedSizes: Set<String>
    @Binding var isAllSelected: Bool
    let frameWidth: CGFloat
    let frameHeight: CGFloat
    let cornerRadius: CGFloat
    
    var body: some View {
        Spacer()
        Text(title)
            .font(.system(size: 22))
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        HStack(spacing: 10) {
            ForEach(sizes, id: \.self) { size in
                Button(action: {
                    if isAllSelected {
                        isAllSelected = false
                    }
                    if selectedSizes.contains(size) {
                        selectedSizes.remove(size)
                    } else {
                        selectedSizes.insert(size)
                    }
                }) {
                    HStack(spacing: 5) {
                        Text(size)
                            .font(.system(size: 12))
                            .foregroundColor(selectedSizes.contains(size) ? .white : .black)
                            .fixedSize()
                        if selectedSizes.contains(size) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .imageScale(.small)
                                .font(.system(size: 15))
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
                }
                .padding(selectedSizes.contains(size) ? .vertical : .vertical, selectedSizes.contains(size) ? 2 : 20)
                .padding(selectedSizes.contains(size) ? .horizontal : .horizontal, selectedSizes.contains(size) ? 8 : 18)
                .frame(width: frameWidth, height: frameHeight)
                .background(selectedSizes.contains(size) ? Color.black.opacity(0.7) : Color.gray.opacity(0.2))
                .cornerRadius(cornerRadius)
            }
            Button(action: {
                if isAllSelected {
                    isAllSelected = false
                } else {
                    isAllSelected = true
                    selectedSizes.removeAll()
                }
            }) {
                if isAllSelected {
                    HStack(spacing: 5) {
                        Text("Все")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .imageScale(.small)
                            .font(.system(size: 15))
                    }
                    .frame(width: 90, height: 42)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(20)
                } else {
                    Text("Все")
                        .font(.system(size: 16))
                        .foregroundColor(.black)
                        .frame(width: 90, height: 42)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(20)
                }
            }
        }
    }
}

struct TopSizeSection: View {
    @Binding var selectedSizes: Set<String>
    @Binding var isAllSelected: Bool
    
    var body: some View {
        SizeSection(title: "Размер верх", sizes: ["XS", "S", "M", "L", "XL"], selectedSizes: $selectedSizes, isAllSelected: $isAllSelected, frameWidth: 48, frameHeight: 33, cornerRadius: 20)
    }
}

struct BottomSizeSection: View {
    @Binding var selectedSizes: Set<String>
    @Binding var isAllSelected: Bool
    
    var body: some View {
        SizeSection(title: "Размер низ", sizes: ["2XS", "S", "M", "L", "XL"], selectedSizes: $selectedSizes, isAllSelected: $isAllSelected, frameWidth: 48, frameHeight: 32, cornerRadius: 20)
    }
}

struct ShoeSizeSection: View {
    @Binding var selectedSizes: Set<String>
    @Binding var isAllSelected: Bool
    @State private var isShoeAllSelected: Bool = false
    var body: some View {
        SizeSection(title: "Размер обуви", sizes: ["35", "36", "37", "38", "39"], selectedSizes: $selectedSizes, isAllSelected: $isShoeAllSelected, frameWidth: 48, frameHeight: 32, cornerRadius: 20)
    }
}

struct HeightSection: View {
    @Binding var selectedSizes: Set<String>
    @Binding var isAllSelected: Bool
    
    var body: some View {
        Spacer()
        Text("Рост")
            .font(.system(size: 22))
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        HStack(alignment: .center, spacing: 5) {
            ForEach(["150-160", "160-170", "170-180"], id: \.self) { range in
                Button(action: {
                    if isAllSelected {
                        isAllSelected = false
                    }
                    if selectedSizes.contains(range) {
                        selectedSizes.remove(range)
                    } else {
                        selectedSizes.insert(range)
                    }
                }) {
                    HStack(spacing: 5) {
                        Text(range)
                            .font(.system(size: 12))
                            .foregroundColor(selectedSizes.contains(range) ? .white : .black)
                            .fixedSize()
                        if selectedSizes.contains(range) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.white)
                                .imageScale(.small)
                                .font(.system(size: 15))
                        }
                    }
                    .padding(.horizontal, selectedSizes.contains(range) ? 16 : 12)
                    .padding(.vertical, 8)
                    .frame(height: 36)
                    .background(selectedSizes.contains(range) ? Color.black.opacity(0.7) : Color.gray.opacity(0.2))
                    .cornerRadius(20)
                }
            }
            
            Button(action: {
                if isAllSelected {
                    isAllSelected = false
                } else {
                    isAllSelected = true
                    selectedSizes.removeAll()
                }
            }) {
                HStack(spacing: 5) {
                    Text("Все")
                        .font(.system(size: 16))
                        .foregroundColor(isAllSelected ? .white : .black)
                    if isAllSelected {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .imageScale(.small)
                            .font(.system(size: 15))
                    }
                }
                .frame(width: 90, height: 42)
                .background(isAllSelected ? Color.black.opacity(0.7) : Color.gray.opacity(0.2))
                .cornerRadius(20)
            }
        }
    }
}

struct SeasonSection: View {
    @Binding var selectedSeason: Set<String>
    
    var body: some View {
        Spacer()
        Text("Сезон")
            .font(.system(size: 22))
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(["весна", "лето", "осень", "зима"], id: \.self) { season in
                    Button(action: {
                        if selectedSeason.contains(season) {
                            selectedSeason.remove(season)
                        } else {
                            selectedSeason.insert(season)
                        }
                    }) {
                        HStack(spacing: 5) {
                            Text(season)
                                .font(.system(size: 14))
                                .foregroundColor(selectedSeason.contains(season) ? .white : .black)
                                .lineLimit(1)
                                .fixedSize(horizontal: true, vertical: false)
                            if selectedSeason.contains(season) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.white)
                                    .imageScale(.small)
                                    .font(.system(size: 15))
                            }
                        }
                        .padding(.horizontal, selectedSeason.contains(season) ? 16 : 12)
                        .padding(.vertical, 8)
                        .frame(height: 36)
                        .background(selectedSeason.contains(season) ? Color.black.opacity(0.7) : Color.gray.opacity(0.2))
                        .cornerRadius(20)
                    }
                }
            }
            .padding(.horizontal, 4)
        }
    }
}

struct ContinueButton: View {
    var body: some View {
        Spacer()
        Spacer()
        Button(action: {
            // No action yet
        }) {
            Text("Продолжить")
                .foregroundColor(.black)
                .padding()
                .frame(maxWidth: .infinity)
        }
        .background(Color(hex: "FCE000"))
        .cornerRadius(10)
        Spacer()
        Spacer()
        Spacer()
        Spacer()
    }
}


struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        FilterView()
    }
}
