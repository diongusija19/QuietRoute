import SwiftUI

struct HomeView: View {
    @State private var selectedDestination = CampusData.quickDestinations.first ?? "Library"

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Good morning")
                        .font(.title.bold())
                        .foregroundStyle(QRTheme.slate)

                    Text("Where do you want to go?")
                        .font(.title2.weight(.semibold))
                        .foregroundStyle(QRTheme.slate)

                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(QRTheme.muted)
                        Text("Search building, room, or place")
                            .foregroundStyle(QRTheme.muted)
                        Spacer()
                    }
                    .padding()
                    .background(QRTheme.card)
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    .shadow(color: QRTheme.surfaceShadow, radius: 10, y: 4)

                    Text("Quick destinations")
                        .font(.headline)
                        .foregroundStyle(QRTheme.slate)

                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 145), spacing: 12)], spacing: 12) {
                        ForEach(CampusData.quickDestinations, id: \.self) { destination in
                            let isSelected = selectedDestination == destination
                            Button {
                                selectedDestination = destination
                            } label: {
                                Text(destination)
                                    .font(.subheadline.weight(.semibold))
                                    .foregroundStyle(isSelected ? .white : QRTheme.primary)
                                    .frame(maxWidth: .infinity, minHeight: 48)
                                    .background(isSelected ? QRTheme.primary : QRTheme.accent.opacity(0.25))
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                            .buttonStyle(.plain)
                        }
                    }

                    NavigationLink {
                        RouteOptionsView(destination: selectedDestination)
                    } label: {
                        Text("Find Route")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 52)
                            .foregroundStyle(.white)
                            .background(QRTheme.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }

                    Button(action: {}) {
                        Text("Browse Calm Spots")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 52)
                            .foregroundStyle(QRTheme.primary)
                            .background(QRTheme.card)
                            .overlay(
                                RoundedRectangle(cornerRadius: 14, style: .continuous)
                                    .stroke(QRTheme.primary.opacity(0.3), lineWidth: 1)
                            )
                    }
                }
                .padding(20)
            }
            .background(QRTheme.background.ignoresSafeArea())
        }
    }
}

#Preview {
    HomeView()
}
