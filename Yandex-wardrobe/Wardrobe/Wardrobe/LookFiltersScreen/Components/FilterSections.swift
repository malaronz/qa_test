import SwiftUI

struct LookSeasonSection: View {
    @Binding var selectedSeason: String?
    let onSeasonSelect: (String) -> Void
    
    private let seasons = ["весна", "лето", "осень", "зима", "всесезон"]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Сезон")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.wardrobeBlack)

            HStack(spacing: 8) {
                ForEach(seasons, id: \.self) { season in
                    FilterChip(
                        title: season,
                        isSelected: selectedSeason == season,
                        onTap: {
                            onSeasonSelect(season)
                        }
                    )
                }
                Spacer()
            }
        }
    }
}

struct LookStyleSection: View {
    @Binding var selectedStyle: String?
    let onStyleSelect: (String) -> Void
    
    private let styles = [
        "повседневный", "формальный", "классический",
        "минималистичный", "роскошный", "спортивный",
        "модный", "нарядный"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Стиль")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.wardrobeBlack)

            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100), spacing: 8)
            ], alignment: .leading, spacing: 8) {
                ForEach(styles, id: \.self) { style in
                    FilterChip(
                        title: style,
                        isSelected: selectedStyle == style,
                        onTap: {
                            onStyleSelect(style)
                        }
                    )
                }
            }
        }
    }
}

struct LookOccasionSection: View {
    @Binding var selectedOccasion: String?
    let onOccasionSelect: (String) -> Void
    
    private let occasions = [
        "без повода", "свидание", "дом", "работа",
        "путешествие", "вечеринка", "спорт", "пляж",
        "школа", "праздник"
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Повод")
                .font(.system(size: 22, weight: .regular))
                .foregroundColor(.wardrobeBlack)

            LazyVGrid(columns: [
                GridItem(.adaptive(minimum: 100), spacing: 8)
            ], alignment: .leading, spacing: 8) {
                ForEach(occasions, id: \.self) { occasion in
                    FilterChip(
                        title: occasion,
                        isSelected: selectedOccasion == occasion,
                        onTap: {
                            onOccasionSelect(occasion)
                        }
                    )
                }
            }
        }
    }
}
