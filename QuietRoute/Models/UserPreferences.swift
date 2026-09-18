import Foundation

struct UserPreferences {
    var avoidCrowds = true
    var avoidNoise = true
    var preferFastest = false
    var preferSimpleRoute = true
    var comfortPriority = 4.0
    var walkingPace = WalkingPace.normal

    static let defaults = UserPreferences()
}

enum WalkingPace: String, CaseIterable, Identifiable {
    case relaxed = "Relaxed"
    case normal = "Normal"
    case quick = "Quick"

    var id: String { rawValue }
}
