import SwiftUI

struct RouteOptionsView: View {
    @StateObject private var viewModel: RouteOptionsViewModel

    init(destination: String = "Library") {
        _viewModel = StateObject(wrappedValue: RouteOptionsViewModel(destination: destination))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Route Options")
                    .font(.title.bold())
                    .foregroundStyle(QRTheme.slate)

                Text("Destination: \(viewModel.destination)")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(QRTheme.primary)

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

                HStack(spacing: 10) {
                    ForEach(RouteMode.allCases) { mode in
                        let isSelected = viewModel.selectedMode == mode
                        Button {
                            viewModel.selectedMode = mode
                        } label: {
                            Text(mode.rawValue)
                                .font(.subheadline.weight(.semibold))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .foregroundStyle(isSelected ? .white : QRTheme.primary)
                                .background(isSelected ? QRTheme.primary : QRTheme.accent.opacity(0.25))
                                .clipShape(Capsule())
                        }
                    }
                }

                ForEach(viewModel.sortedRoutes) { route in
                    Button {
                        viewModel.selectedRouteID = route.id
                    } label: {
                        RouteCardView(route: route, isSelected: viewModel.selectedRouteID == route.id)
                    }
                    .buttonStyle(.plain)
                }

                if let selectedRoute = viewModel.selectedRoute {
                    NavigationLink {
                        ActiveRouteMapView(route: selectedRoute)
                    } label: {
                        Text("Start Selected Route")
                            .font(.headline)
                            .frame(maxWidth: .infinity, minHeight: 54)
                            .foregroundStyle(.white)
                            .background(QRTheme.primary)
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                    .padding(.top, 4)
                }
            }
            .padding(20)
        }
        .background(QRTheme.background.ignoresSafeArea())
    }
}

#Preview {
    RouteOptionsView()
}
