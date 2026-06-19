import SwiftUI
import MapKit

struct ActiveRouteMapView: View {
    let route: RouteOption
    @State private var position: MapCameraPosition = .automatic

    var body: some View {
        VStack(spacing: 0) {
            Map(position: $position) {
                if let start = route.path.first {
                    Marker("Start", coordinate: start)
                }
                if let end = route.path.last {
                    Marker(route.destination, coordinate: end)
                }
                MapPolyline(coordinates: route.path)
                    .stroke(QRTheme.primary, lineWidth: 6)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(route.name)
                    .font(.headline)
                    .foregroundStyle(QRTheme.slate)
                Text("ETA: \(route.minutes) min")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(QRTheme.primary)
                Text("Comfort Score: \(route.comfortScore) | Crowd: \(route.crowd.rawValue) | Noise: \(route.noise.rawValue)")
                    .font(.subheadline)
                    .foregroundStyle(QRTheme.muted)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(QRTheme.card)
        }
        .background(QRTheme.background.ignoresSafeArea())
        .navigationTitle("Active Route")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            position = .region(regionToFit(route.path))
        }
    }

    private func regionToFit(_ coordinates: [CLLocationCoordinate2D]) -> MKCoordinateRegion {
        guard let first = coordinates.first else {
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 43.7745, longitude: -79.5005),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }

        var minLat = first.latitude
        var maxLat = first.latitude
        var minLon = first.longitude
        var maxLon = first.longitude

        for point in coordinates {
            minLat = min(minLat, point.latitude)
            maxLat = max(maxLat, point.latitude)
            minLon = min(minLon, point.longitude)
            maxLon = max(maxLon, point.longitude)
        }

        let center = CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLon + maxLon) / 2)
        let latDelta = max((maxLat - minLat) * 1.7, 0.004)
        let lonDelta = max((maxLon - minLon) * 1.7, 0.004)

        return MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta))
    }
}

#Preview {
    ActiveRouteMapView(route: CampusData.routes(for: "Library")[1])
}
