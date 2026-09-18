import SwiftUI

struct CalmSpotsView: View {
    @State private var selectedType: CalmSpotType = .all

    private var filteredSpots: [CalmSpot] {
        if selectedType == .all {
            return CalmSpot.samples
        }
        return CalmSpot.samples.filter { $0.type == selectedType }
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Calm Spots")
                    .font(.title.bold())
                    .foregroundStyle(QRTheme.slate)

                Text("Find a quieter place to reset between classes.")
                    .font(.subheadline)
                    .foregroundStyle(QRTheme.muted)

                HStack(spacing: 10) {
                    ForEach(CalmSpotType.allCases) { type in
                        let isSelected = selectedType == type
                        Button {
                            selectedType = type
                        } label: {
                            Text(type.rawValue)
                                .font(.subheadline.weight(.semibold))
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .foregroundStyle(isSelected ? .white : QRTheme.primary)
                                .background(isSelected ? QRTheme.primary : QRTheme.accent.opacity(0.25))
                                .clipShape(Capsule())
                        }
                        .buttonStyle(.plain)
                    }
                }

                ForEach(filteredSpots) { spot in
                    NavigationLink {
                        CalmSpotDetailView(spot: spot)
                    } label: {
                        CalmSpotCardView(spot: spot)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(20)
        }
        .background(QRTheme.background.ignoresSafeArea())
    }
}

private struct CalmSpotCardView: View {
    let spot: CalmSpot

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(spot.name)
                        .font(.headline)
                        .foregroundStyle(QRTheme.slate)
                    Text(spot.location)
                        .font(.subheadline)
                        .foregroundStyle(QRTheme.muted)
                }

                Spacer()

                Text(spot.distance)
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(QRTheme.primary)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(QRTheme.accent.opacity(0.22))
                    .clipShape(Capsule())
            }

            HStack(spacing: 12) {
                MetricPill(title: "Comfort", value: "\(spot.comfortScore)")
                MetricPill(title: "Crowd", value: spot.crowd.rawValue)
                MetricPill(title: "Noise", value: spot.noise.rawValue)
            }

            Text(spot.bestFor)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(QRTheme.primary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(QRTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
        .shadow(color: QRTheme.surfaceShadow, radius: 10, y: 4)
    }
}

private struct MetricPill: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.caption)
                .foregroundStyle(QRTheme.muted)
            Text(value)
                .font(.caption.weight(.bold))
                .foregroundStyle(QRTheme.slate)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(10)
        .background(QRTheme.background)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CalmSpotDetailView: View {
    let spot: CalmSpot
    @State private var didQueueRoute = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(spot.name)
                        .font(.title.bold())
                        .foregroundStyle(QRTheme.slate)
                    Text(spot.location)
                        .font(.headline)
                        .foregroundStyle(QRTheme.primary)
                }

                VStack(alignment: .leading, spacing: 12) {
                    Text("Why it helps")
                        .font(.headline)
                        .foregroundStyle(QRTheme.slate)
                    Text(spot.notes)
                        .font(.body)
                        .foregroundStyle(QRTheme.muted)
                }
                .padding(16)
                .background(QRTheme.card)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                .shadow(color: QRTheme.surfaceShadow, radius: 10, y: 4)

                HStack(spacing: 12) {
                    MetricPill(title: "Comfort", value: "\(spot.comfortScore)")
                    MetricPill(title: "Crowd", value: spot.crowd.rawValue)
                    MetricPill(title: "Noise", value: spot.noise.rawValue)
                }

                Button {
                    didQueueRoute = true
                } label: {
                    Text("Route To This Spot")
                        .font(.headline)
                        .frame(maxWidth: .infinity, minHeight: 54)
                        .foregroundStyle(.white)
                        .background(QRTheme.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                }
            }
            .padding(20)
        }
        .background(QRTheme.background.ignoresSafeArea())
        .navigationTitle("Calm Spot")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Route Ready", isPresented: $didQueueRoute) {
            Button("Done") {}
        } message: {
            Text("QuietRoute will prioritize lower-crowd paths near \(spot.location).")
        }
    }
}

struct CalmSpotsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            CalmSpotsView()
        }
    }
}
