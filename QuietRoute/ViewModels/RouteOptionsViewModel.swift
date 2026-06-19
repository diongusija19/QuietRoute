import Foundation

final class RouteOptionsViewModel: ObservableObject {
    @Published var selectedMode: RouteMode = .balanced
    @Published var selectedRouteID: UUID?
    @Published var destination: String {
        didSet {
            routes = CampusData.routes(for: destination)
            selectedRouteID = routes.first?.id
        }
    }
    @Published var routes: [RouteOption]

    init(destination: String) {
        self.destination = destination
        self.routes = CampusData.routes(for: destination)
        self.selectedRouteID = routes.first?.id
    }

    var sortedRoutes: [RouteOption] {
        switch selectedMode {
        case .fastest:
            return routes.sorted { $0.minutes < $1.minutes }
        case .balanced:
            return routes.sorted { (lhs, rhs) in
                let lhsRank = lhs.minutes + (100 - lhs.comfortScore)
                let rhsRank = rhs.minutes + (100 - rhs.comfortScore)
                return lhsRank < rhsRank
            }
        case .calmest:
            return routes.sorted { $0.comfortScore > $1.comfortScore }
        }
    }

    var selectedRoute: RouteOption? {
        let ranked = sortedRoutes
        guard let selectedRouteID else { return ranked.first }
        return ranked.first(where: { $0.id == selectedRouteID }) ?? ranked.first
    }
}
