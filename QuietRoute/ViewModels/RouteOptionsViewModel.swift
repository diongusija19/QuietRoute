import Foundation

final class RouteOptionsViewModel: ObservableObject {
    @Published var selectedMode: RouteMode = .balanced
    @Published var selectedRouteID: UUID?
    @Published var preferences = UserPreferences.defaults
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
            return routes.sorted { score($0) < score($1) }
        case .calmest:
            return routes.sorted { $0.comfortScore > $1.comfortScore }
        }
    }

    var selectedRoute: RouteOption? {
        let ranked = sortedRoutes
        guard let selectedRouteID else { return ranked.first }
        return ranked.first(where: { $0.id == selectedRouteID }) ?? ranked.first
    }

    private func score(_ route: RouteOption) -> Double {
        let comfortWeight = preferences.comfortPriority / 5.0
        let timeWeight = preferences.preferFastest ? 1.35 : 1.0
        let crowdPenalty = preferences.avoidCrowds ? levelPenalty(route.crowd) * 7.0 : 0
        let noisePenalty = preferences.avoidNoise ? levelPenalty(route.noise) * 7.0 : 0
        let simplePenalty = preferences.preferSimpleRoute ? Double(route.turnCount) * 2.0 : 0
        let paceAdjustment: Double

        switch preferences.walkingPace {
        case .relaxed:
            paceAdjustment = 1.15
        case .normal:
            paceAdjustment = 1.0
        case .quick:
            paceAdjustment = 0.9
        }

        return (Double(route.minutes) * timeWeight * paceAdjustment)
            + (Double(100 - route.comfortScore) * comfortWeight)
            + crowdPenalty
            + noisePenalty
            + simplePenalty
    }

    private func levelPenalty(_ level: CrowdLevel) -> Double {
        switch level {
        case .low:
            return 0
        case .medium:
            return 1
        case .high:
            return 2
        }
    }

    private func levelPenalty(_ level: NoiseLevel) -> Double {
        switch level {
        case .low:
            return 0
        case .medium:
            return 1
        case .high:
            return 2
        }
    }
}
