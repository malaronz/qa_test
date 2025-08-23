import SwiftUI

struct ContentView: View {
    @State private var selectedTab: Tab = .profile
    
    var body: some View {
        TabBarView(selectedTab: $selectedTab)
    }
}

#Preview {
    ContentView()
}
