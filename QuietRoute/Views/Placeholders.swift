import SwiftUI

struct CalmSpotsPlaceholderView: View {
    var body: some View {
        PlaceholderScreen(title: "Calm Spots", message: "Calm spot discovery is planned for the next phase.")
    }
}

struct FeedbackPlaceholderView: View {
    var body: some View {
        PlaceholderScreen(title: "Feedback", message: "Collect student route feedback here in a future iteration.")
    }
}

struct ProfilePlaceholderView: View {
    var body: some View {
        PlaceholderScreen(title: "Profile", message: "Profile settings and preferences are coming next.")
    }
}

private struct PlaceholderScreen: View {
    let title: String
    let message: String

    var body: some View {
        ZStack {
            QRTheme.background.ignoresSafeArea()
            VStack(spacing: 14) {
                Text(title)
                    .font(.title.bold())
                    .foregroundStyle(QRTheme.slate)
                Text(message)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(QRTheme.muted)
                    .padding(.horizontal, 24)
            }
        }
    }
}
