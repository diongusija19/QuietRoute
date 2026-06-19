import Foundation
import CoreLocation

enum RouteMode: String, CaseIterable, Identifiable {
    case fastest = "Fastest"
    case balanced = "Balanced"
    case calmest = "Calmest"

    var id: String { rawValue }
}

enum CrowdLevel: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

enum NoiseLevel: String {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

struct RouteOption: Identifiable {
    let id = UUID()
    let destination: String
    let name: String
    let minutes: Int
    let comfortScore: Int
    let crowd: CrowdLevel
    let noise: NoiseLevel
    let path: [CLLocationCoordinate2D]
}
