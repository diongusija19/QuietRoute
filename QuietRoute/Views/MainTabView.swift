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
                CalmSpotsPlaceholderView()
            }
                .tabItem {
                    Label("Calm Spots", systemImage: "leaf.fill")
                }

            NavigationStack {
                FeedbackPlaceholderView()
            }
                .tabItem {
                    Label("Feedback", systemImage: "bubble.left.and.bubble.right.fill")
                }

            NavigationStack {
                ProfilePlaceholderView()
            }
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
        }
        .tint(QRTheme.primary)
    }
}
