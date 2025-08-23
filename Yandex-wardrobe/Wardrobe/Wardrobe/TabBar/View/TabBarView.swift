import SwiftUI

struct TabBarView: View {
    @Environment(\.tabBarCoordinator) private var tabBarCoordinator
    @Binding var selectedTab: Tab
    
    var body: some View {
        ZStack {
            VStack {
                makeView(for: selectedTab)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if tabBarCoordinator.isVisible {
                    tabBar
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
            }
        }
    }
    
    // MARK: - Subviews
    
    private var tabBar: some View {
        HStack {
            ForEach(Tab.allCases, id: \.self) { tab in
                tabButton(for: tab)
            }
        }
        .frame(height: 63)
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(Color.gray.opacity(0.2)),
            alignment: .top
        )
    }
    
    private func tabButton(for tab: Tab) -> some View {
        Button(action: {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = tab
            }
        }) {
            Image(tab.icon)
                .renderingMode(.template)
                .font(.system(size: selectedTab == tab ? 24 : 22))
                .foregroundColor(selectedTab == tab ? .primary : .secondary)
                .scaleEffect(selectedTab == tab ? 1.1 : 1.0)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 48)
    }
    
    @ViewBuilder
    private func makeView(for tab: Tab) -> some View {
        switch tab {
        case .home:
            Text("Home")
        case .aliceGPT:
            Text("Alice")
        case .lavka:
            Text("Lavka")
        case .favorites:
            Text("Favorites")
        case .cart:
            Text("Shopping Cart")
        case .profile:
            NavigationView {
                ProfileView()
            }
        }
    }
}

#Preview {
    TabBarView(
        selectedTab: .constant(.home)
    )
}
