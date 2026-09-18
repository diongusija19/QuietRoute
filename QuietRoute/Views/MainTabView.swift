import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationStack {
                HomeView()
            }
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }

            NavigationStack {
                RouteOptionsView()
            }
                .tabItem {
                    Label("Routes", systemImage: "arrow.triangle.swap")
                }

            NavigationStack {
                CalmSpotsView()
            }
                .tabItem {
                    Label("Calm Spots", systemImage: "leaf.fill")
                }

            NavigationStack {
                FeedbackView()
            }
                .tabItem {
                    Label("Feedback", systemImage: "bubble.left.and.bubble.right.fill")
                }

            NavigationStack {
                SettingsView()
            }
                .tabItem {
                    Label("Settings", systemImage: "slider.horizontal.3")
                }
        }
        .tint(QRTheme.primary)
    }
}
